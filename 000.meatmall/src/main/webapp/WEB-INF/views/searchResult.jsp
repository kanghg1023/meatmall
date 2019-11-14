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
<jsp:include page="header.jsp" />

<h3>"${search_word}" 검색 결과입니다.</h3>

<h4>카테고리</h4>
<table border="1">
	<c:forEach items="${caList}" var="dto">
		<tr>
			<td><a href="allGoods.do?kind_num=${dto.kind_num}">${dto.kind_name}</a></td>
		</tr>
	</c:forEach>
</table>

<h4>상품 도매</h4>
<table border="1">
	<c:forEach items="${doList}" var="dto">
		<tr>
			<td><img src="${dto.goods_img_title}"  style="width:250px; height:230px;" ></td>
			<td><a href="goodsDetail.do?goods_num=${dto.goods_num}&pnum=${pnum}">${dto.goods_title}</a></td>
			<td>${dto.goods_cost}</td>
		</tr>
	</c:forEach>
</table>

<h4>상품 소매</h4>
<table border="1">
	<c:forEach items="${soList}" var="dto">
		<tr>
			<td><img src="${dto.goods_img_title}"  style="width:250px; height:230px;" ></td>
			<td><a href="goodsDetail.do?goods_num=${dto.goods_num}&pnum=${pnum}">${dto.goods_title}</a></td>
			<td>${dto.goods_cost}</td>
		</tr>
	</c:forEach>
</table>

<h4>게시판</h4>
<table border="1">
	<c:forEach items="${bList}" var="dto">
		<tr>
			<td>${dto.board_title}</td>
			<td>${dto.user_nick}</td>
			<td>${dto.board_content}</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>