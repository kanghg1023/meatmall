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
<title></title>
<style type="text/css" media="screen">
.abcd{
	display: inline-block;
	margin-left: 60px;
}

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
<jsp:include page="header.jsp" />
<div class="ps-sidebar" data-mh="product-listing" style="text-align: center;">
	<aside class="ps-widget--sidebar ps-widget--category">
		<div class="ps-widget__header">
			<h3>나의 활동 내역</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                
                <li class="abcd"><a href="myPage.do" class="myPage"><span>내 정보보기</span></a></li>
                <li class="abcd"><a href="orderList.do?user_num=${ldto.user_num}" class="category"><span>구매내역</span></a></li>
                <c:if test="${ldto.user_role ne 'USER'}">
                <li class="abcd"><a href="selOrderList.do?user_num=${ldto.user_num}" class="category"><span>내 상품관리</span></a></li>
				</c:if>
                <li class="current abcd"><a href="myboardlist.do?pnum=1" class="myboardlist"><span>내가 쓴 글 보기</span></a></li>
                <li class="abcd"><a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a></li>     
			</ul>
		</div>
	</aside>            
</div>
<div class="ps-products-wrap pt-80 pb-80" style="width:70%;margin: auto 0 auto 15% ;">
<h4 style="margin:-50px 0px -70px 10px;">내가 쓴 글 보기</h4>
<table class="list-table">	
	<col width="200px" />
	<col width="400px" />
	<col width="400px" />
	<col width="300px" />
	
	<tr>		
		<th>번호</th>
		<th>제 목</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
		<c:choose>
		<c:when test="${empty myboardList}">
			<tr>
				<td colspan="4">----작성된 글이 없습니다.----</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${myboardList}" var="dto">
				<tr class="list">					
					<td>${dto.board_num}</td>
					<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>						
					<td><fmt:formatDate value="${dto.board_regdate}" pattern="yy-MM-dd [hh:mm]"/> </td>					
					<td>${dto.board_readcount}</td>
				</tr>
			</c:forEach>			
		</c:otherwise>
		</c:choose>		
		<tr>
			<td colspan="4" style="text-align: center;">
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
</table>
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>