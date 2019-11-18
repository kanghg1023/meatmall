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
<style type="text/css" media="screen">
.notice {
	color: red;
	text-decoration: none;
}

* {
    margin:0; padding:0

}



body {
        font-family: "Montserrat", sans-serif; font-size:0.75em; color:#333

}

.list-table {
    margin:100px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  text-align: center;
  padding:10px;               
}

.list-table th{
   height:40px;
   border-top:2px solid #2AC37D;
   border-bottom:1px solid #CCC;
   font-weight: bold;
   font-size: 17px;
}
.list-table td{
   text-align:center;
   padding:10px 0;
   border-bottom:1px solid #CCC; height:20px;
   font-size: 14px 
}

.list-table .list:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .notice:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .buttonsignup {
    width: 15%;
    height: 30px;
    padding: 0;
    border: 0;
    display: block;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:#fff;
    transition: background-color .4s ease-out;
}

.list-table .actionbutton {
    margin-top:0%;
}
	
</style>
</head>
<body>
<!-- <div id="header" class="header" style="outline: none;"> -->
	<jsp:include page="header.jsp" />
<!-- </div> -->
<jsp:useBean id="util" class="com.hk.utils.Util"  />

<table class="list-table">	
	<col width="100px" />
	<col width="150px" />
	<col width="400px" />
	<col width="200px" />
	<col width="150px" />
	
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
			<c:if test="${pnum == 1}">
				<c:forEach items="${noticeList}" var="dto">
					<tr class="notice">									
						<td>공지</td>
						<td>${dto.user_nick}</td>
						<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>					
						<td><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy년MM월dd일"/> </td>					
						<td>${dto.board_readcount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:forEach items="${boardList}" var="dto">
				<tr class="list">					
					<td>${dto.board_num}</td>
					<td>${dto.user_num}</td>
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
	<tr>
		<td colspan="10">
			<input type="button" value="글추가" class="buttonsignup actionbutton"
			       onclick="location.href='insertForm.do?user_num=${dto.user_num}'"/>
		</td>
	</tr>
</table>
<jsp:include page="footer.jsp" /> 
</body>
</html>