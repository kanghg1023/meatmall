<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<script type="text/javascript">
	
	$(function() {
		$("#regist").click(function(){
			location.href="registPage.do";
		});
	});
	
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<c:if test="${msg != null}">
	<script type="text/javascript">
		alert("${msg}");
	</script>
</c:if>
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
				<input type="button" id="regist" value="회원가입"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>