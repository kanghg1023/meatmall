<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %> <!-- 요청할때 utf-8로 -->
<%response.setContentType("text/html; charset=UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<h1>자주묻는질문 수정하기</h1>
<form action="faqupdateboard.do" method="post">
<!-- <input type="hidden" name="command" value="updateboard"/> -->
<input type="hidden" name="faq_num" value="${dto.faq_num}"/>
<table border="1">
	<tr>
		<th>제목</th>
		<td><input type="text" name="faq_title" value="${dto.faq_title}"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="faq_content">${dto.faq_content}</textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정완료"/>
			<button type="button" onclick="location.href='faqlist.do'">글목록</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>