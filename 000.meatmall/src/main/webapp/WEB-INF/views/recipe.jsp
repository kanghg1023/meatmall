<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>한우레시피</title>
<style type="text/css">

html,body{
    height: 100%;
    width: 100%;
}

#asd {
	margin: auto;
}
</style>
</head>
<body>

   <jsp:include page="header.jsp" />


<table id="asd">
<col width="1250px">
<tr>
	<td>
		<iframe src="http://www.minsokmeat.com/ekapepiarese.php" width="1250" height="1800" style="align-content: center;" ></iframe>
	</td>
</tr>
</table>
<jsp:include page="footer.jsp" /> 
</body>
</html>