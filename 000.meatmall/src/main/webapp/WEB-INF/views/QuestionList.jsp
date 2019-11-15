<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
a.underline:link    { text-decoration:none }
a.underline:visited { text-decoration:none }
a.underline:hover   { text-decoration:underline }
a.underline:active  { text-decoration:none }

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
<title></title>
</head>
<body>

	<jsp:include page="header.jsp" />

<h1 style="text-align: center;">1:1문의 글 리스트</h1>
<table class="list-table">
	<col width="150px" />
	<col width="100px" />
	<col width="300px" />
	<col width="130px" />
	<col width="90px" />
	
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
			<c:forEach items="${qlist}" var="dto">
				<tr>
					<td>${dto.question_num}</td>
					<td>${dto.user_num}</td>
					<td><a href="questiondetail.do?question_num=${dto.question_num}" class="underline">${dto.question_title}</a></td>
					<td><fmt:formatDate value="${dto.question_regdate}" pattern="yyyy년MM월dd일"/></td>
					<c:choose>
						<c:when test="${dto.question_status == 2}">
							<td>답변완료</td>
						</c:when>
						<c:when test="${dto.question_status == 1}">
							<td>처리중</td>
						</c:when>
						<c:when test="${dto.question_status == 0}">
							<td>접수중</td>
						</c:when>
					</c:choose>	
				</tr>			
			</c:forEach>
			<tr>
				<td colspan="5" style="text-align: center;">
					<c:if test="${pnum != 1}">
						<a href="questionlist.do?pnum=${qmap.prePageNum}" class="underline">◀</a>
					</c:if>
					<c:forEach var="i" begin="${qmap.startPage}" end="${qmap.endPage}" step="1" >
					<c:choose>
						<c:when test="${pnum eq i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="questionlist.do?pnum=${i}" style="text-decoration: none" class="underline">${i}</a>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					<c:if test="${pnum < qmap.pcount}">
						<a href="questionlist.do?pnum=${qmap.nextPageNum}" class="underline">▶</a>
					</c:if>
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
<jsp:include page="footer.jsp" /> 
</body>
</html>