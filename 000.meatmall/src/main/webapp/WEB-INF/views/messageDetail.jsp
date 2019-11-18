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
<table border="1">
	<tr>
		<th>보낸 사람</th>
		<td>${mdto.user_nick}</td>
	</tr> 
	<tr>
		<th>받은시간</th>
		<td><fmt:formatDate value="${dto.message_regdate}" pattern="yy-MM-dd [hh:mm]" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${mdto.message_content}</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" id="insert" value="답장"/>
			<input type="button" id="delete" value="답장"/>
		</td>
	</tr>
</table>
</body>
</html>