package com.project.restaurant.service;

import com.project.common.template.Utils;
import com.project.common.template.PageInfoCombine;
import com.project.restaurant.repository.RestaurantRepository;
import com.project.restaurant.dto.RestaurantListFilter;
import com.project.restaurant.dto.RestaurantListRequest;
import com.project.restaurant.dto.RestaurantListResponse;
import com.project.restaurant.vo.Hashtag;
import com.project.restaurant.vo.ResHashtag;
import com.project.restaurant.vo.ResImg;
import com.project.restaurant.vo.Restaurant;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class RestaurantService {

    private static final int DEFAULT_RES_SIZE = 12;
    private final ServletContext servletContext;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantCrawlingService restaurantCrawlingService;


    /**
     * 전체 리스트 조회
     */
    public RestaurantListResponse selectList(RestaurantListRequest request) {
        RestaurantListFilter filter = RestaurantListFilter.from(request);
        int count = restaurantRepository.selectResListCount(filter);
        PageInfoCombine pageInfoCombine = new PageInfoCombine(count, request.getCurrentPage(), DEFAULT_RES_SIZE);
        List<Restaurant> result = restaurantRepository.selectResList(pageInfoCombine, filter);
        result.forEach(this::updateImageIfEmpty);
        return new RestaurantListResponse(result, pageInfoCombine);
    }

    /**
     * 맛집 이미지 크롤링
     */
    private void updateImageIfEmpty(Restaurant restaurant) {
        if (Objects.isNull(restaurant.getResImgUrl()) || restaurant.getResImgUrl().isEmpty()) {
            String imageUrl = restaurantCrawlingService.findImage(restaurant.getResName());
            restaurantRepository.updateImage(restaurant.getResNo(), imageUrl);
            restaurant.setImageUrl(imageUrl);
        }
    }

    public Restaurant restaurantDetail(String resNo) {
        return restaurantRepository.restaurantDetail(resNo);
    }

    public List<String> resHashtagByAdmin(String resNo) {
        return restaurantRepository.resHashtagByAdmin(resNo);
    }

    public List<String> selectStateList() {
        return restaurantRepository.selectStateList();
    }

    public List<Hashtag> selectHashtagList() {
        return restaurantRepository.selectHashtagList();
    }

    /**
     * 관리자 - 등록
     */
    @Transactional // 트랜잭션 해줘야함(전부 성공했을때만 들어가도록)
    public String restaurantInsert(MultipartFile file, Restaurant restaurant, HttpSession session, List<String> hashTagId) {

        try {
            // 1. 이미지 파일 저장
            String savePath = servletContext.getRealPath("/resources/images/restaurant/");
//            String savePath = servletContext.getRealPath("target/Matdongsan-1.0-SNAPSHOT/resources/images/restaurant/");
            String fileName = Utils.saveFile(savePath, file);

            // 2. Restaurant 엔티티 생성 후 저장

            restaurant.setImageUrl("http://localhost:8070/Matdongsan/resources/images/restaurant/" + fileName);
//            restaurant.setImageUrl("/resources/images/restaurant/" + fileName);
            String resNo = restaurantRepository.resInsert(restaurant);

            // 3. ResImg 엔티티 생성 후 저장
            ResImg resImg = new ResImg();
            resImg.setMemberNo(1L);
            resImg.setResNo(resNo);
            resImg.setOriginName(file.getOriginalFilename());
            resImg.setChangeName(fileName);
            restaurantRepository.resInsertImg(resImg);

            // 4. ResHashTag 엔티티 List 생성 후 저장
            hashTagId.forEach(tagId -> {
                ResHashtag resHashtag = new ResHashtag();
                resHashtag.setHashtagId(tagId);
                resHashtag.setResNo(resNo);
                resHashtag.setMemberNo(1L);
                restaurantRepository.resHashtagInsert(resHashtag);
            });
            return resNo;
        } catch (IllegalStateException e) {
            System.out.println("파일 업로드 오류");
            return null;
        }
    }


    /**
     * 관리자 - 수정
     */
    public void restaurantModify(MultipartFile file, Restaurant restaurant, HttpSession session, List<String> hashTagId) {

        try {
            // 1. 이미지 파일 저장
            if (file.getSize() > 0) {
                String savePath = servletContext.getRealPath("/resources/images/restaurant/");
//                String savePath = servletContext.getRealPath("/home/ubuntu/apps/tomcat/apache-tomcat-9.0.71/webapps/ROOT/resources/images/restaurant/");
                String fileName = Utils.saveFile(savePath, file);

                restaurant.setImageUrl("http://localhost:8070/Matdongsan/resources/images/restaurant/" + fileName);
//                restaurant.setImageUrl("http://matdongsan.site/resources/images/restaurant/" + fileName);

                ResImg resImg = new ResImg();
                resImg.setMemberNo(1L);
                resImg.setResNo(restaurant.getResNo());
                resImg.setChangeName(fileName);
                restaurantRepository.resInsertImg(resImg);
            }

            // 2. Restaurant 엔티티 생성 후 저장
            String resNo = restaurantRepository.resModify(restaurant);

            // 4. ResHashTag 엔티티 List 생성 후 저장
            if (!hashTagId.isEmpty()) {
                restaurantRepository.deleteResHashOnlyAdmin(resNo);
                hashTagId.forEach(tagId -> {
                    ResHashtag resHashtag = new ResHashtag();
                    resHashtag.setHashtagId(tagId);
                    resHashtag.setResNo(resNo);
                    resHashtag.setMemberNo(1L);
                    restaurantRepository.resHashtagInsert(resHashtag);
                });
            }
        } catch (IllegalStateException e) {
            System.out.println("파일 업로드 오류");
        }
    }

    /**
     * 관리자 - 맛집 삭제
     */
    @Transactional
    public void deleteRes(String resNo) {
        restaurantRepository.deleteResHash(resNo);
        restaurantRepository.deleteResImg(resNo);
        restaurantRepository.deleteRes(resNo);
    }

}
