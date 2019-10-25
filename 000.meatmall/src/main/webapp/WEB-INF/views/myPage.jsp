<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<dl>
	<dt>마이페이지</dt>
	<dd>
		<a href="myPage.do" class="myPage"><span>내 정보보기</span></a>
	</dd>
	<dd>
		<a href="category.do" class="category"><span>구매내역</span></a>
	</dd>
	<dd>
		<a href="faqlist.do" class="faqlist"><span>알림</span></a>
	</dd>
</dl>

<form action="login.do" method="post">
	<input type="hidden" name="user_id" value="${ldto.user_id}">
	<table border="1">
		<tr>
			<td>정보를 수정하시려면 비밀번호를 입력하세요</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="pw" />
				<input type="submit" value="확인" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>