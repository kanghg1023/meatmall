<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="questionupdate.do" method="post">
	<input type="hidden" name="question_num" value="${qdto.question_num}"/>
	<table border="1">
		<tr>
			<th>문의제목</th>
			<td><input type="text" name="question_title" value="${qdto.question_title}"/></td>
		</tr>
		<tr>
			<th>문의내용</th>
			<td><textarea rows="10" cols="60" name="question_content">${qdto.question_content}</textarea> </td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정완료"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>