<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>카테고리 추가하기</h1>
<form action="insertCategory.do" method="get">
	<table border="1">
		<col width="100px"><col width="300px">
		<tr>
			<th>등록할 부위 이름 입력</th>
			<td><input type="text" name="kind_name" required="required"/></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="부위 추가" onclick="opener.document.location.reload(); javascript:self.close();" onclose="opener.parent.location.reload();"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>