package com.project.member.controller;

import com.project.admin.vo.BrokerEnroll;
import com.project.common.type.StateList;
import com.project.member.dto.*;
import com.project.member.service.MemberService;
import com.project.member.type.MemberGrade;
import com.project.member.vo.Member;
import com.project.realestate.dto.RealEstateInterestRequest;
import com.project.realestate.dto.ReservationRequest;
import com.project.realestate.dto.ReservationResponse;
import com.project.restaurant.vo.Hashtag;
import com.project.restaurant.vo.Restaurant;
import com.project.restaurant.vo.Review;
import org.json.JSONArray;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.util.Arrays;
import java.util.List;

@Controller
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @RequestMapping("/myPage")
    public ModelAndView ListPaging(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
                                   ModelAndView modelAndView, HttpSession session){
        Member m = (Member) session.getAttribute("loginUser");

        MyPageListRequest req = new MyPageListRequest(currentPage);
        MyPageListResponse resp = memberService.selectList(req, m);

        modelAndView.addObject("selectAllBoardList", resp.getAllBoardList());
        modelAndView.addObject("interestList", memberService.getInterestList(m));
        modelAndView.addObject("reviewList", resp.getReviewList());
        modelAndView.addObject("reservationList", resp.getReservationList());
        modelAndView.addObject("pi1", resp.getPageInfoCombine());
        modelAndView.addObject("pi2", resp.getPageInfoCombine2());
        modelAndView.addObject("pi3", resp.getPageInfoCombine3());

        modelAndView.setViewName("member/myPage");

        return modelAndView;
    }

    @RequestMapping("/brokerMemberMyPage")
    public ModelAndView brokerMemberMyPage(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
                                   ModelAndView modelAndView, HttpSession session){
        Member m = (Member) session.getAttribute("loginUser");

        MyPageListRequest req = new MyPageListRequest(currentPage);
        MyPageListResponse resp = memberService.selectList(req, m);
        List<ReservationBroker> brokerReservationList = memberService.selectBrokerReservationList(m);

        modelAndView.addObject("selectAllBoardList", resp.getAllBoardList());
        modelAndView.addObject("interestList", memberService.getInterestList(m));
        modelAndView.addObject("reviewList", resp.getReviewList());
        modelAndView.addObject("brokerResList", brokerReservationList);
        modelAndView.addObject("pi", resp.getPageInfoCombine());

        System.out.println("부동산 예약 리스트 : " + brokerReservationList);

        modelAndView.setViewName("member/brokerMemberMyPage");

        return modelAndView;
    }



    @RequestMapping(value = "/memberModify")
    public String memberModify(Model model){
        model.addAttribute("stateList", StateList.values());
        return "member/memberModify";
    }

    /**
     * 회원정보를 수정하면 회원등급 변경
     */
    @RequestMapping(value = "/updateMember")
    public String updateMember(HttpSession session, Model model, Member m) {
        int result = memberService.updateMember(m);
        if (result != 0) {
            Member updateMember = memberService.loginMember(m);
            session.setAttribute("loginUser", updateMember);

            if(m.getGrade().equals(MemberGrade.BROKER)) {
                return "member/brokerMemberMyPage";
            }else {
                return "member/myPage";
            }
        } else {
            model.addAttribute("errorMsg", "회원정보 수정 실패");
            return "common/errorPage";
        }
    }

//    @GetMapping("/myPage/interest")
//    @ResponseBody
//    public ResponseEntity<Boolean> checkInterest(@RequestParam String estateNo, HttpSession session){
//        Member loginUser = (Member) session.getAttribute("loginUser");
//        if (loginUser == null) {
//            throw new RuntimeException("로그인 하고 오세용");
//        }
//        boolean isInterest = MemberService.checkInterest(estateNo, loginUser);
//        return ResponseEntity.ok(isInterest);
//    }

    @PostMapping("/myPage")
    @ResponseBody
    public ResponseEntity<Void> saveInterest(@RequestBody RealEstateInterestRequest req, HttpSession session){
        Member loginUser = (Member) session.getAttribute("loginUser");
        if(loginUser == null){
            throw  new RuntimeException("로그인 해라 ");
        }
        memberService.saveInterest(req, loginUser);
        return ResponseEntity.ok().build();
    }

    @RequestMapping("/delete")
    public String deleteMember(HttpSession session) {
        Member member = (Member)session.getAttribute("loginUser");
        memberService.deleteMember(member);
        session.removeAttribute("loginUser");
        return "redirect:/";

    }

    /**
     * 휴대폰 인증
     */
    @RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
    @ResponseBody
    public String sendSMS(@RequestParam("phone") String userPhoneNumber) {
        int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);
        memberService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
        return Integer.toString(randomNumber);
    }


    /**
     * 부동산 회원 인증
     */
    @RequestMapping("broker/enrollPage")
    public ModelAndView brokerEnrollPage(ModelAndView modelAndView) {
        modelAndView.setViewName("member/brokerMemberEnroll");
        return modelAndView;
    }

    // Spring Boot -> Validator 를 이용한 유효성 검사
    // Validator -> Client 로부터 받은 데이터에 대한 유효성 검사
    @PostMapping("broker/enroll")
    public String agentMemberInsert(@RequestParam(value = "file", required = true) MultipartFile file,
                                    BrokerEnroll brokerEnroll
    ) {
        memberService.brokerMemberInsert(file, brokerEnroll);
        return "member/myPage";
    }

    @RequestMapping("/revDelete")
    public String deleteReservation(HttpSession session){
        Member m = (Member) session.getAttribute("loginUser");
        memberService.deleteReservation(m);

        return "redirect:/myPage";

    }



}
