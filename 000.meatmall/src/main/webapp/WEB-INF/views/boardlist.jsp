<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>글목록보기</title>
<style type="text/css">
	.notice {
		color: red;
		text-decoration: none;
	}
</style>
<script type="text/javascript">

	$(function(){
		$(".message").click(function(){
			var user_nick = $(this).html();
			var user_num = $(this).prev().val();
			
			window.open("messageForm.do?user_num="+user_num+"&user_nick="+user_nick,"","width=640px,height=480px");
		});
	});
	
</script>
</head>
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
		<c:when test="${empty boardList}">
			<tr>
				<td colspan="10">----작성된 글이 없습니다.----</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:if test="${!(empty noticeList)}">
				<c:forEach items="${noticeList}" var="dto">
					<tr class="notice">									
						<td>공지</td>
						<td>${dto.user_num}</td>
						<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>					
						<td><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy년MM월dd일"/></td>					
						<td>${dto.board_readcount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:forEach items="${boardList}" var="dto">
				<tr>					
					<td>${dto.board_num}</td>
					<td><input type="hidden" value="${dto.user_num}" /><a class="message">${dto.user_nick}</a></td>
					<c:choose>
						<c:when test="${dto.board_delflag=='0'}">
							<td>------삭제된 글입니다.------</td>
						</c:when>
						<c:otherwise>
							<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>
						</c:otherwise>
					</c:choose>										
					<td><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy년MM월dd일"/> </td>					
					<td>${dto.board_readcount}</td>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="6" style="text-align: center;">
			<c:if test="${pnum != 1}">
				<a href="boardlist.do?pnum=${pmap.prePageNum}">◀</a>
			</c:if>
			<c:forEach var="i" begin="${pmap.startPage}" end="${pmap.endPage}" step="1" >
				<c:choose>
					<c:when test="${pnum eq i}">
						${i}
					</c:when>
					<c:otherwise>
						<a href="boardlist.do?pnum=${i}" style="text-decoration: none">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pnum < pmap.pcount}">
			<a href="boardlist.do?pnum=${pmap.nextPageNum}">▶</a>
			</c:if>
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