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
</head>
<body>

	<jsp:include page="header.jsp" />

<dl>
	<dt>마이페이지</dt>
	<dd>
		<a href="myPage.do" class="myPage"><span>내 정보보기</span></a>
	</dd>
	<dd>
<!-- 		수정중 -->
		<a href="category.do" class="category"><span>구매내역</span></a>
	</dd>
	<dd>
<!-- 		수정중 -->
		<a href="faqlist.do" class="faqlist"><span>알림</span></a>
	</dd>
	<dd>
		<a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a>
	</dd>
	<dd>
		<a href="withdrawForm.do" class="withdrawForm"><span>회원 탈퇴</span></a>
	</dd>
</dl>
<h2>최근 1주일(10건)간 로그인 시도 이력입니다.</h2>
<table border="1">
	<tr>
		<th>날짜(시간)</th>
		<th>아이피</th>
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
<jsp:include page="footer.jsp" /> 
</body>
</html>