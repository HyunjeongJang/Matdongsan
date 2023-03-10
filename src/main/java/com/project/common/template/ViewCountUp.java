package com.project.common.template;

import com.project.board.vo.FreeBoard;
import com.project.member.vo.Member;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewCountUp {
    public static Boolean countUp(FreeBoard freeBoard,
                                  long memberNo,
                                  HttpServletRequest request,
                                  HttpServletResponse response) {
        if (freeBoard.getMemberNo() != memberNo) {
            Cookie oldCookie = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null && cookies.length > 0) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("boardView")) {
                        oldCookie = cookie;
                    }
                }
            }
            if (oldCookie == null) {
                Cookie newCookie = new Cookie("boardView", "[" + freeBoard.getBoardNo() + "]");
                newCookie.setPath("/");
                newCookie.setMaxAge(60 * 60);
                newCookie.setPath(request.getContextPath());
                response.addCookie(newCookie);
                return true;
            } else {
                if (!oldCookie.getValue().contains("[" + freeBoard.getBoardNo() + "]")) {
                    oldCookie.setValue(oldCookie.getValue() + "_[" + freeBoard.getBoardNo() + "]");
                    oldCookie.setPath("/");
                    oldCookie.setMaxAge(60 * 60);
                    oldCookie.setPath(request.getContextPath());
                    response.addCookie(oldCookie);
                    return true;
                }
                return false;
            }
        }
        return false;
    }
}
