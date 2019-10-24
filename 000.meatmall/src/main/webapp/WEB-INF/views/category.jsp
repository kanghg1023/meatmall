<%@page import="com.hk.meatmall.dtos.Goods_kindDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h4>부위별 카테고리</h4>
<form action="delCategory.do" method="post">
<div>
<c:if test="${ldto.user_role eq 'ADMIN'}">
	<input type="button" value="카테고리 추가" 
	onclick="window.open('insertCategoryForm.do','insertCategory','width=450px,height=200px,location=no,status=no,scrollbars=no')" />
	<input type="submit" value="카테고리 삭제" />
</c:if>	
</div>
<hr />
<ul>
<c:forEach items="${list}" var="list">
	<li>
		<c:if test="${ldto.user_role eq 'ADMIN'}">
			<input type="checkbox" name="chk" value="${list.kind_num}" />
		</c:if>
		<a href="categoryGoods.do?kind_num=${list.kind_num}">${list.kind_name}</a>
		</li>
</c:forEach>
</ul>
</form>
</body>
</html>