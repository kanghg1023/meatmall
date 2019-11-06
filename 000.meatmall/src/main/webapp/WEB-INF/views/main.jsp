<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>메인페이지 입니다.</h1>
<%
	session.setAttribute("page", "main");
%>
<input type="hidden" name="page" value="main">

<div>
	<h3>도매</h3>
	<c:forEach items="${doList}" var="dto">
		<div>
			<img src="${dto.goods_img_title}"  style="width:250px; height:180px;" >
			<strong>${dto.goods_cost}원</strong>(100g 당)
		</div>
	</c:forEach>
</div>

<div>
	<h3>소매</h3>
	<c:forEach items="${soList}" var="dto">
		<div>
			<img src="${dto.goods_img_title}"  style="width:250px; height:180px;" >
			<strong>${dto.goods_cost}원</strong>(100g 당)
		</div>
	</c:forEach>
</div>
</body>
</html>