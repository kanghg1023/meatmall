<%@page import="java.util.Map"%>
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
<%Map<String,Integer>qmap=(Map<String,Integer>)request.getAttribute("qmap"); %>

</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>1:1문의 글 리스트</h1>
<table border="1">
	<col width="100px" />
	<col width="100px" />
	<col width="300px" />
	<col width="100px" />
	<col width="70px" />
	
	<tr>
		<th>문의글 번호</th>
		<th>작성자</th>
		<th>제 목</th>
		<th>작성일</th>
		<th>답변상태</th>
	</tr>
	<c:choose>
		<c:when test="${empty qlist}">
			<tr>
				<td colspan="10">----작성된 글이 없습니다.----</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${qlist}" var="qlist">
				<tr>
					<td>${qlist.question_num}</td>
					<td>${qlist.user_num}</td>
					<td><a href="questiondetail.do?seq=${qlist.question_num}">${qlist.question_title}</a></td>
					<td><fmt:formatDate value="${qlist.question_regdate}" pattern="yyyy년MM월dd일"/></td>
					<c:choose>
						<c:when test="${qlist.question_status eq 'Y'}">
							<td>답변완료</td>
						</c:when>
						<c:when test="${qlist.question_status eq 'N' && qlist.question_readcount>0}">
							<td>처리중</td>
						</c:when>
						<c:when test="${qlist.question_status eq 'N' && qlist.question_readcount==0}">
							<td>답변대기중</td>
						</c:when>
					</c:choose>	
				</tr>			
			</c:forEach>
			<tr>
					<td colspan="5" style="text-align: center;">
						
						<c:choose>
							<c:when test="${ldto.user_role eq 'ADMIN'}">
								<a href="allqnalist.do?pnum=${qmap.prePageNum}">◀</a>
							</c:when>
							<c:otherwise>
								<a href="questionlist.do?pnum=${qmap.prePageNum}">◀</a>
							</c:otherwise>
						</c:choose>
							<c:forEach var="i" begin="${qmap.startPage}" end="${qmap.endPage}" step="1" >					
							<c:choose>
								<c:when test="${ldto.user_role eq 'ADMIN'}">
									<c:choose>
										<c:when test="${pnum eq i}">
											${i}
										</c:when>
										<c:otherwise>
											<a href="allqnalist.do?pnum=${i}" style="text-decoration: none">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${pnum eq i}">
											${i}
										</c:when>
										<c:otherwise>
											<a href="questionlist.do?pnum=${i}" style="text-decoration: none">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							</c:forEach>
						<c:choose>
							<c:when test="${ldto.user_role eq 'ADMIN'}">
								<a href="allqnalist.do?pnum=${qmap.nextPageNum}">▶</a>
							</c:when>
							<c:otherwise>
								<a href="questionlist.do?pnum=${qmap.nextPageNum}">▶</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
		</c:otherwise>
	</c:choose>
	<c:if test="${ldto.user_role eq 'USER' || ldto.user_role eq 'LICENSE'}">
	<tr>
		<td colspan="10">
			<input type="button" value="글추가" 
			       onclick="location.href='questioninsertform.do'"/>       
		</td>
	</tr>
	</c:if>
</table>
</body>
</html>