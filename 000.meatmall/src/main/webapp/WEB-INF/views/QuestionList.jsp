<%@page import="com.hk.meatmall.dtos.QuestionDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %> <!-- 요청할때 utf-8로 -->
<%response.setContentType("text/html; charset=UTF-8"); %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
<h1>1:1문의 글 리스트</h1>
<table border="1">
	<col width="100px" />
	<col width="100px" />
	<col width="300px" />
	<col width="80px" />
	<col width="70px" />
	
	<tr>
		<th>문의글 번호</th>
		<th>작성자</th>
		<th>제 목</th>
		<th>작성일</th>
		<th>답변여부</th>
	</tr>
	<c:choose>
		<c:when test="${empty list}">
			<tr>
				<td colspan="10">----작성된 글이 없습니다.----</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.question_num}</td>
					<td>${list.user_num}</td>
					<td><a href="questiondetail.do?seq=${list.question_num}">${list.question_title}</a></td>
					<td><fmt:formatDate value="${list.question_regdate}" pattern="yyyy년MM월dd일"/></td>
					<td>${list.question_status}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="10">
			<input type="button" value="글추가" 
			       onclick="location.href='questioninsertform.do'"/>       
		</td>
	</tr>
</table>
</body>
</html>