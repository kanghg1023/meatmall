<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 기록보기</title>
<style type="text/css">
.abcd{
	display: inline-block;
	margin-left: 60px;
}

.list-table {   
	text-align: left;
}

.list-table, .list-table th , .list-table td {         
	text-align: left;
	padding:10px;               
}

.list-table th{
   height:40px;  
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 15px;
}
.list-table td{
   text-align:left;
   padding:10px 0;   
   border-bottom:1px solid #CCC; 
   height:20px;
   font-size: 13px 
}

.list-table .list:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .notice:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .actionbutton {
    margin-top:2%;
}
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="ps-sidebar" data-mh="product-listing" style="text-align: center;">
	<aside class="ps-widget--sidebar ps-widget--category">
		<div class="ps-widget__header">
			<h3>접속 IP 확인</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                
                <li class="abcd"><a href="myPage.do" class="myPage"><span>내 정보보기</span></a></li>
                <li class="abcd"><a href="orderList.do?user_num=${ldto.user_num}" class="category"><span>구매내역</span></a></li>
                <c:if test="${ldto.user_role ne 'USER'}">
                <li class="abcd"><a href="selOrderList.do?user_num=${ldto.user_num}" class="category"><span>내 상품관리</span></a></li>
				</c:if>
                <li class="abcd"><a href="myboardlist.do?pnum=1" class="myboardlist"><span>내가 쓴 글 보기</span></a></li>
                <li class="current abcd"><a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a></li>     
			</ul>
		</div>
	</aside>            
</div>

<div class="ps-products-wrap pt-80 pb-80" style="width:70%;margin: auto 0 auto 25% ;">
<h4 style="margin:-50px 0px 30px 0px;">최근 1주일(10건)간 로그인 시도 이력입니다.</h4>
<table class="list-table"> 
	<col width="300px">
	<col width="300px">
	<col width="300px">
	<tr>
		<th>일시(시간)</th>
		<th>로그인 IP</th>
		<th>성공여부</th>
	</tr>
	<c:forEach items="#{recordList}" var="dto">
		<tr>
			<td><fmt:formatDate value="${dto.record_date}" pattern="MM.dd (hh:mm)"/></td>
			<td>${dto.record_ip}</td>
			<c:choose>
				<c:when test="${dto.record_check == 1}">
					<td>성공</td>
				</c:when>
				<c:otherwise>
					<td>실패</td>
				</c:otherwise>
			</c:choose>
		</tr>
	</c:forEach>
</table>
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>