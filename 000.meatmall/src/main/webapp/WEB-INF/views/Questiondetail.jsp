<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>1:1문의하기</h1>
<table border="1">
	<tr>
		<th>작성자</th>
		<td>${dto.user_num}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.question_title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.question_content}</textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="답글등록"/>
			<button onclick="questionupdateForm(${dto.question_num})">수정</button>
			<button onclick="questiondelete(${dto.question_num})">삭제</button>
			<input type="button" value="목록" 
			          onclick="location.href='questionlist.do?user_num=${dto.user_num}'"/>
		</td>
	</tr>
</table>


</body>
</html>