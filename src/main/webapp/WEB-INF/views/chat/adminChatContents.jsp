<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:include page="../template/font.jsp"></jsp:include>

<div id="chat_contents_ajax">
    <div class="header-chat">
        <div class="name" id="titleName"></div>
    </div>
    <div class="chat">
        <div class="messages-chat">
            <c:forEach items="${chattingMessageList}" var="chattingMessageList">
                <c:choose>
                    <c:when test="${chattingMessageList.memberNo eq 1}">
                        <div class="response">
                            <span class="text">${chattingMessageList.message}</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="request">
                            <span class=" text">${chattingMessageList.message}</span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
    <div class="footer-chat">
        <input id="chat-input" type="text"/>
        <input id="roomNo-send" type="hidden">
        <div id="sendMessage" onclick="send();"><i class="fa-solid fa-paper-plane"></i></div>
    </div>

    <script>
        // 채팅 클릭시 밑으로 내리기
        $('.chat').scrollTop($('.chat').prop('scrollHeight'));
        //엔터 눌렀을때 전송
        $('#chat-input').keypress(function(e){
            if(e.keyCode===13){
                send();


            }
        });

        function send(){
            if($("#chat-input").val() == ''){
                return false;
            }
            const roomNo = currentChatRoom;
            const data = {
                'memberNo' : ${loginUser.memberNo},
                'message': $("#chat-input").val(),
                'roomNo' : roomNo
            };
            // send(destination,헤더,페이로드)
            stompClient.send("/app/chat/send", {}, JSON.stringify(data));
            $("#chat-input").val('');
            // 채팅 보내고 받는 시간이 있으므로 0.2초 후에 스크롤 내리기
            setTimeout(() => $('.chat').scrollTop($('.chat').prop('scrollHeight')), 250);
        }
    </script>
</div>