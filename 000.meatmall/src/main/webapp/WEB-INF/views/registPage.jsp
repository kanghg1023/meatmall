<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:if test="${registError != null}">
	<script type="text/javascript">
		alert("${registError}");
	</script>
</c:if>
<a href="licenseeRegist.do" class="licenseeRegist">사업자 회원가입</a> | 
<a href="normalRegist.do" class="normalRegist">일반 회원가입</a>
</body>
</html>