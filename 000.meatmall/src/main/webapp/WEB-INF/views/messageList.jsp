<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 쪽지함</title>
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

<div>
	<table border="1">
		<tr>
			<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
			<th>보낸사람</th>
			<th>내용</th>
			<th>날짜</th>
		</tr>
		<c:choose>
			<c:when test="${empty mlist}">
				<tr>
					<td colspan="4" id="noList">----작성된 글이 없습니다.----</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${mlist}" var="dto">
					<tr align="center">
						<td>
							<input type="checkbox" name="chk" value="${dto.message_num}" />
						</td>
						<td align="left">
							${dto.message_from_num}
						</td>
						<td>
							<a href="BoardController.do?command=boarddetail&seq=${dto.message_from_num}">${dto.message_from_num}</a>
						</td>
						<td>
							<fmt:formatDate value="${dto.message_regdate}" pattern="yy-MM-dd [hh:mm]" />
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="6" style="text-align: center;">
						<c:if test="${pnum != 1}">
							<a href="boardlist.do?pnum=${pmap.prePageNum}${statusPage==null?'':statusPage}">◀</a>				
						</c:if>
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
						<c:if test="${pnum < pmap.pcount}">																		
						<a href="boardlist.do?pnum=${pmap.nextPageNum}${statusPage==null?'':statusPage}">▶</a>
						</c:if>
					</td>
				</tr>		
			</c:otherwise>
		</c:choose>
	</table>
</div>
</body>
</html>