<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h4>상품 도매</h4>
<table border="1">
	<c:forEach items="${doList}" var="dto">
		<tr>
			<td></td>
		</tr> 
	</c:forEach>
</table>

<h4>상품 소매</h4>
<table border="1">
	<c:forEach items="${soList}" var="dto">
		<tr>
			<td></td>
		</tr>
	</c:forEach>
</table>

<h4>게시판</h4>
<table border="1">
	<tr>
		<td></td>
	</tr>
</table>

<h4>카테고리</h4>
<table border="1">
	<tr>
		<td></td>
	</tr>
</table>
</body>
</html>