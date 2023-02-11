<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ page language="java" pageEncoding="UTF-8"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <title>부동산 중개업자 신청 관리</title>
</head>
<body>

<%@ include file ="../template/header.jsp" %>
<div id="headeer"></div>
<div id="button2">
    <button type="button" class="b1" id="userList">회원관리</button>
    <button type="button" class="b2" id="reportList">신고관리</button>
    <button type="button" class="b3" id="moveBrokerList">부동산관리</button>
</div>
<br><br><br><br>
<div class="reportTable">
    <table id="tableDiv">
        <thead>
        <tr>
            <th>중개자 이름</th>
            <th>이메일</th>
            <th>부동산 이름</th>
            <th>공인중개사 번호</th>
            <th>전화번호</th>
            <th>첨부파일</th>
            <th>처리상태</th>
        </tr>
        </thead>
        <tbody id="tableList">
        <c:forEach var="broker" items="${brokerList}">
            <tr>
                <td>${broker.memberName}</td>
                <td>${broker.email}</td>
                <td>${broker.agentName}</td>
                <td>${broker.agentNo}</td>
                <td>${broker.agentPhone}</td>
                <td><a href="${broker.attachment}" download="${broker.agentName}_${broker.memberNo}"><button>다운로드</button></a></td>
                <td>
                    <button type="button" class="approveBroker" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                            data-agentNo="${broker.agentNo}" data-memberNo="${broker.memberNo}">
                        ${broker.applyStatus}
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>


    </table>
</div>


<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                승인하시겠습니까 ?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary handleApply" value="consent">승인</button>
                <button type="button" class="btn btn-primary handleApply" value="reject">거부</button>
            </div>
        </div>
    </div>
</div>

<script>

        <%--$("#reportList").click(function () {--%>

        <%--    $.ajax({--%>
        <%--        type: "POST",--%>
        <%--        url: "${pageContext.request.contextPath}/admin/reportList/" +${fNo},--%>
        <%--        data: {},--%>
        <%--        dataType: "html",--%>
        <%--        cache: false,--%>
        <%--        success(data) {--%>
        <%--            $("body").html(data);--%>
        <%--        }--%>
        <%--    });--%>
        <%--});--%>

        <%--$("#userList").click(function () {--%>
        <%--    $.ajax({--%>
        <%--        type: "POST",--%>
        <%--        url: "${pageContext.request.contextPath}/admin/userList/" +${fNo},--%>
        <%--        data: {},--%>
        <%--        dataType: "html",--%>
        <%--        cache: false,--%>
        <%--        success(data) {--%>
        <%--            $("body").html(data);--%>
        <%--        }--%>
        <%--    });--%>
        <%--});--%>



        $('#moveBrokerList').click(function (){
            $.ajax({
                type : "POST",
                url : "${pageContext.request.contextPath}/admin/brokerList",
                dataType : "html",
                success : function (data){
                    $("body").html(data);
                }
            })
        })

        let agentNo="";
        let memberNo="";
        $(document).ready(function() {
            $('#staticBackdrop').on('show.bs.modal', function(event){
                agentNo = $(event.relatedTarget).data('agentNo');
                memberNo = $(event.relatedTarget).data('memberNo');
                console.log(agentNo);
                console.log(memberNo);
            });
        });





        $('.handleApply').click(function (){
            let status = $(this).val();
            // let tr = $(this).parent().parent()
            // console.log(agentNo)
            // console.log(memberNo)
            console.log($(this).data('agentNo'))
            // console.log(tr.text())
            // let agentNo =;
            // let memberNo = ;
            $.ajax({
                type : "POST",
                url : "${pageContext.request.contextPath}/admin/broker/handleApply",
                data : { 'handle': status},
                success : function (){
                    console.log("테스트 성공1")
                },
                fail : function (){
                    console.log("테스트 실패!")
                }
            })
        })
</script>
</body>
</html>