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
<script type="text/javascript">
	var msg = "${msg}";
	var url = "${url}";
	alert(msg+": 같은 문제가 반복될 경우 관리자에게 문의해 주세요.");
	
	location.href = url;
</script>
</body>
</html>