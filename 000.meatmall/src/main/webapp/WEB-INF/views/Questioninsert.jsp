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
<h1>1:1문의글 추가하기</h1>
<form action="questioninsert.do" method="post" >
	<input type="hidden" name="user_num" value="${ldto.user_num}"/>
	<table border="1">
		<tr>
			<th>작성자</th>
			<td>${ldto.user_num}</td>
		</tr>
		<tr>
			<th>문의제목</th>
			<td><input type="text" name="question_title" /></td>
		</tr>
		<tr>
			<th>문의내용</th>
			<td><textarea rows="10" cols="60" name="question_content" ></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="글등록"/>
				<input type="button" value="목록" 
				          onclick="location.href='questionlist.do?user_num=${ldto.user_num}'"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>