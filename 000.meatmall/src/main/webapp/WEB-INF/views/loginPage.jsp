<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>로그인 페이지</title>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<form action="login.do" method="post">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="user_id" /></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><input type="password" name="pw" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="로그인" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="idInquiryForm.do">아이디 찾기</a> | 
				<a href="pwInquiryForm.do">비밀번호 찾기</a> | 
				<a href="signUpPage.do">회원가입</a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>