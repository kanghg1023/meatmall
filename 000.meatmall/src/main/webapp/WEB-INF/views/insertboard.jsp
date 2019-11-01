<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>게시글 추가폼</title>
<script type="text/javascript" src="js/formCheck.js"></script>
</head>
<body>
<h1>게시글 추가하기</h1>
<form action="insertboard.do" method="post" >
<input type="hidden" name="user_num" value="${ldto.user_num}">
<table border="1">
	<tr>
		<th>아이디</th>
		<td>${ldto.user_num}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="board_title" class="inputval"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="board_content" class="inputval"></textarea></td>
	</tr>
	<tr>
		<td colspan="3">
			<input type="submit" value="글등록"/>
			<input type="button" value="목록" 
			          onclick="location.href='boardlist.do?pnum=1'"/>
			<c:if test="${ldto.user_num == 1}">
				<label><input type="checkbox" name="board_notice" value="Y" />공지</label>
			</c:if>
		</td>
	</tr>
</table>
</form>
</body>
</html>











