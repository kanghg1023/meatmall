<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 관리 페이지</title>
</head>
<body>
<jsp:include page="header.jsp" />
<table border="1">
	<tr>
		<th>쿠폰 이미지</th>
		<th>쿠폰명</th>
		<th>할인금액</th>
		<th>기간</th>
	</tr>
	<c:forEach items="${coulist}" var="dto">
		<tr>
			<td>
				<img src="${dto.coupon_img}"  style="width:250px; height:230px;" >
			</td>
			<td>${dto.coupon_name}</td>
			<td>${dto.coupon_money} 원</td>
			<td>${dto.coupon_period} 일</td>
		</tr>
	</c:forEach>
	<c:if test="${map != null}">
		<tr>
			<td colspan="4" align="center">
			<c:if test="${pnum != 1}">
				<a href="adminCouponList.do?pnum=${map.prePageNum}">◀</a>
			</c:if>	
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}" step="1">
					<c:choose>
						<c:when test="${pnum eq i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="adminCouponList.do?pnum=${i}">${i}</a>
						</c:otherwise>
					</c:choose>	
				</c:forEach>
			<c:if test="${pnum < map.pcount}">
				<a href="adminCouponList.do?pnum=${map.nextPageNum}">▶</a>
			</c:if>
			</td>
		</tr>
	</c:if>
	
	<tr>
		<td colspan="4">
			<input type="button" value="쿠폰생성" onclick="location.href='insertCouponForm.do'" />
		</td>
	</tr>
</table>
</body>
</html>