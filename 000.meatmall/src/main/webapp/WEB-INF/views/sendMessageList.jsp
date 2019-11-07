<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<dl>
	<dt>쪽지</dt>
	<dd>
		<a href="messageForm.do"><span>쪽지 보내기</span></a>
	</dd>
	<dd>
		<a href="messageList.do?user_num=${ldto.user_num}"><span>받은 쪽지함</span></a>
	</dd>
	<dd>
		<a href="sendMessageList.do?message_from_num=${ldto.user_num}" class="category"><span>보낸 쪽지함</span></a>
	</dd>
</dl>
</body>
</html>