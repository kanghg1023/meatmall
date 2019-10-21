<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h1>간이 페이지</h1>
	<form action="login.do" method="post">
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="user_id" /></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" name="user_pw" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="로그인" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>