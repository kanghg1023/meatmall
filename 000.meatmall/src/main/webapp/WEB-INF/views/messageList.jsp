<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>내 쪽지함</title>
<script type="text/javascript">
$(function(){
	$(".msg").click(function(){
		var message_num = $(this).prev().val();
		window.open("messageDetail.do?message_num="+message_num+"&fromTo=1","","width=640px,height=480px");
	});
});
</script>

<style type="text/css" media="screen">

body {
        font-family: "Montserrat", sans-serif; font-size:0.75em; color:#333

}

.list-table {
    margin:50px auto 0px auto;
    margin-bottom: 10%;
    
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

.mass{
	text-align: left;
	margin-left: 25%;
	margin-top: 3%
}

	
</style>

</head>
<body>

	<jsp:include page="header.jsp" />

<dl class="mass">
	<dt style="font-size: 35px">쪽지</dt>
	<dd>
		<a href="messageList.do?pnum=1" style="border-bottom:2px solid #2AC37D; font-size: 15px"><span>받은 쪽지함</span></a>
	</dd>
	<dd>
		<a href="sendMessageList.do?pnum=1" class="category" style="border-bottom:2px solid #2AC37D; font-size: 15px"><span>보낸 쪽지함</span></a>
	</dd>
</dl>

<div>
	<table class="list-table">
	<col width="100px" />
	<col width="150px" />
	<col width="400px" />
	<col width="200px" />
		<tr>
			<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
			<th>보낸 사람</th>
			<th>내용</th>
			<th>날짜</th>
		</tr>
		<c:choose>
			<c:when test="${empty mlist}">
				<tr>
					<td colspan="4" id="noList">----쪽지가 없습니다.----</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${mlist}" var="dto">
					<tr align="center">
						<td>
							<input type="checkbox" name="chk" value="${dto.message_num}" />
						</td>
						<td align="left">
							${dto.user_nick}
						</td>
						<td>
							<input type="hidden" value="${dto.message_num}"/>
							<a class="msg">${dto.message_content}</a>
						</td>
						<td>
							<fmt:formatDate value="${dto.message_regdate}" pattern="yy-MM-dd [hh:mm]" />
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="6" style="text-align: center;">
						<c:if test="${pnum != 1}">
							<a href="messageList.do?pnum=${pmap.prePageNum}">◀</a>				
						</c:if>
						<c:forEach var="i" begin="${pmap.startPage}" end="${pmap.endPage}" step="1" >																			
							<c:choose>
								<c:when test="${i == 0}">
									1
								</c:when>
								<c:when test="${pnum eq i}">
									${i}
								</c:when>
								<c:otherwise>
									<a href="messageList.do?pnum=${i}" style="text-decoration: none">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pnum < pmap.pcount}">							
						<a href="messageList.do?pnum=${pmap.nextPageNum}">▶</a>
						</c:if>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</div>
<br/>
<jsp:include page="footer.jsp" /> 
</body>
</html>