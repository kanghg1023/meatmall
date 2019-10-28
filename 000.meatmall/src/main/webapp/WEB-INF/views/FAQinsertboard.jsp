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
	<h1>자주묻는글 추가하기</h1>
<form action="faqinsertboard.do" method="post" >
<!-- <input type="hidden" name="user_role" value="admin"/> -->
<table border="1">
	<tr>
		<th>제목</th>
		<td><input type="text" name="faq_title" maxlength="15" wrap="hard"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" id="textarea" name="faq_content" ></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="글등록"/>
			<input type="button" value="목록" 
			          onclick="location.href='faqlist.do'"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>