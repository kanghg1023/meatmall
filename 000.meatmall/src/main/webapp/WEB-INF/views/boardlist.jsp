<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글목록보기</title>
<style type="text/css">
	.notice {
		color: red;
		text-decoration: none;
	}
</style>
</head>
<%
Map<String,Integer>map=(Map<String,Integer>)request.getAttribute("pmap");
%>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<jsp:useBean id="util" class="com.hk.utils.Util"  />
<table border="1">	
	<col width="50px" />
	<col width="100px" />
	<col width="300px" />
	<col width="150px" />
	<col width="50px" />
	<tr>		
		<th>번호</th>
		<th>작성자</th>
		<th>제 목</th>
		<th>작성일</th>		
		<th>조회수</th>		
	</tr>
		<c:choose>
		<c:when test="${empty list}">
			<tr>
				<td colspan="10">----작성된 글이 없습니다.----</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${list1}" var="dto">
				<c:if test="${dto.board_notice eq 'Y'}">
				<tr class="notice">									
					<td>공지</td>
					<td>${dto.user_num}</td>
					<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>					
					<td><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy년MM월dd일"/> </td>					
					<td>${dto.board_readcount}</td>
				</tr>
				</c:if>
			</c:forEach>
			<c:forEach items="${list}" var="dto">
				<tr>					
					<td>${dto.board_num}</td>
					<td>${dto.user_num}</td>
					<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>					
					<td><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy년MM월dd일"/> </td>					
					<td>${dto.board_readcount}</td>
				</tr>
			</c:forEach>			
		</c:otherwise>
		</c:choose>		
		<tr>
			<td colspan="6" style="text-align: center;">
				<a href="boardlist.do?pnum=${pmap.prePageNum}${statusPage==null?'':statusPage}">◀</a>				
				<c:forEach var="i" begin="${pmap.startPage}" end="${pmap.endPage}" step="1" >																			
					<c:choose>
						<c:when test="${pnum eq i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="boardlist.do?pnum=${i}${statusPage==null?'':statusPage}" style="text-decoration: none">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>																		
				<a href="boardlist.do?pnum=${pmap.nextPageNum}${statusPage==null?'':statusPage}">▶</a>
				
			</td>
		</tr>														
	<tr>
		<td colspan="10">
			<input type="button" value="글추가"
			       onclick="location.href='insertForm.do?user_num=${dto.user_num}'"/>
		</td>
	</tr>
	
</table>
</body>
</html>