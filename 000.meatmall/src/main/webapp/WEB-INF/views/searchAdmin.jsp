<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="ps-sidebar" data-mh="product-listing" style="text-align: center;">
	<aside class="ps-widget--sidebar ps-widget--category">
		<div class="ps-widget__header">
			<h3>관리자페이지</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                 
                <li class="abcd"><a href="userAdmin.do?pnum=1"><span>회원관리</span></a></li>
                <li class="abcd"><a href="category.do"><span>카테고리 관리</span></a></li>
                <li class="current abcd"><a href="searchAdmin.do"><span>인기검색어 관리</span></a></li>
                <li class="abcd"><a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a></li>
                <li class="abcd"><a href="bannerList.do?pnum=1"><span>배너관리</span></a></li>
			</ul>
		</div>
	</aside>            
</div>
<form action="insertBestSearch.do" method="post">
<table border="1">
	<tr>
		<th>순위</th>
		<th>검색어</th>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach items="${bestSearch}" var="dto">
		<c:set var="i" value="${i+1}" />
		<tr>
			<td>${i}</td>
			<td>${dto.search_word}</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="2">
			<input type="text" name="search_word" />
			순위
			<select name=search_fake_ranking>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
			<input type="submit" value="등록" />
		</td>
	</tr>
</table>
</form>
</body>
</html>