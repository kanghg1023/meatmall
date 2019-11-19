<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		<th>배너 이미지</th>
		<th>배너명</th>
		<th>등록일</th>
		<th>종료일</th>
	</tr>
	<c:choose>
		<c:when test="${empty bannerlist}">
			<tr>
				<td>배너가 존재하지 않습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${bannerlist}" var="dto">
				<tr>
					<td>
						<img src="${dto.banner_img_name}"  style="width:250px; height:230px;" >
					</td>
					<td>${dto.banner_name}</td>
					<td><fmt:formatDate value="${dto.banner_regist_date}" pattern="yy-MM-dd [hh:mm]" /></td>
					<td><fmt:formatDate value="${dto.banner_end_date}" pattern="yy-MM-dd [hh:mm]" /></td>
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
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="4">
			<input type="button" value="배너 추가" onclick="location.href='insertBannerForm.do'" />
		</td>
	</tr>
</table>
</body>
</html>