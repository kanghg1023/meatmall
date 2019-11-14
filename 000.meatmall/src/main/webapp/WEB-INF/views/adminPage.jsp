<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<jsp:include page="header.jsp" />

<dl>
	<dt>마이페이지</dt>
	<dd>
		<a href="myPage.do" class="myPage"><span>상품관리</span></a>
	</dd>
	<dd>
		<a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a>
	</dd>
	<dd>
		<a href="faqlist.do" class="faqlist"><span>알림</span></a>
	</dd>
	<dd>
		<a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a>
	</dd>
</dl>
</body>
</html>