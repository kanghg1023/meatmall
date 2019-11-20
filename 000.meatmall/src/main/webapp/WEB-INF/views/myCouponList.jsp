<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 관리 페이지</title>

<style type="text/css">
.abcd{
	display: inline-block;
	margin-left: 60px;
}

body {
        font-family: "Montserrat", sans-serif; font-size:0.75em; color:#333

}

.list-table {
    margin:50px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  text-align: center;
  padding:10px;               
}

.list-table th{
   height:40px;
   width: 200px;
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
    display: inline-block;
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
			<h3>내 쿠폰보기</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                
                <li class="abcd"><a href="myPage.do" class="myPage"><span>내 정보보기</span></a></li>
                <li class="abcd"><a href="orderList.do?user_num=${ldto.user_num}" class="category"><span>구매내역</span></a></li>
	         	<c:if test="${ldto.user_role ne 'USER'}">
                <li class="abcd"><a href="selOrderList.do?user_num=${ldto.user_num}" class="category"><span>내 상품관리</span></a></li>
				</c:if>
                <li class="abcd"><a href="myboardlist.do?pnum=1" class="myboardlist"><span>내가 쓴 글 보기</span></a></li>
                <li class="current abcd"><a href="myCouponList.do?pnum=1&user_num=${ldto.user_num}" class="myCouponList"><span>내 쿠폰</span></a></li>      
                <li class="abcd"><a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a></li>        
			</ul>
		</div>
	</aside>            
</div> 
<table class="list-table" style="width:60%;">
	
	
	<tr>
		<th>쿠폰 이미지</th>
		<th>쿠폰명</th>
		<th>할인금액</th>
		<th>유효기간</th>
		<th>사용여부</th>
	</tr>
	<c:choose>
		<c:when test="${empty clist}">
			<tr>
				<td colspan="4">보유중인 쿠폰이 없습니다</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${clist}" var="dto">
				<tr>
					<td>
						<img src="${dto.coupon_img}"  style="width:250px; height:230px;" >
					</td>
					<td>${dto.coupon_name}</td>
					<td>${dto.coupon_money} 원</td>
					<td>
						<fmt:formatDate value="${dto.user_coupon_date}" pattern="yy-MM-dd [hh:mm]" /> 까지
					</td>
					<td>
						<c:choose>
							<c:when test="${dto.user_coupon_use == 1}">
								사용가능
							</c:when>
							<c:otherwise>
								사용함
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${map != null}">
				<tr>
					<td colspan="4" align="center">
					<c:if test="${pnum != 1}">
						<a href="myCouponList.do?pnum=${map.prePageNum}">◀</a>
					</c:if>	
						<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}" step="1">
							<c:choose>
								<c:when test="${pnum eq i}">
									${i}
								</c:when>
								<c:otherwise>
									<a href="myCouponList.do?pnum=${i}">${i}</a>
								</c:otherwise>
							</c:choose>	
						</c:forEach>
					<c:if test="${pnum < map.pcount}">
						<a href="myCouponList.do?pnum=${map.nextPageNum}">▶</a>
					</c:if>
					</td>
				</tr>
			</c:if>
		</c:otherwise>
	</c:choose>
	
</table>
<br/><br/>
<jsp:include page="footer.jsp" />
</body>
</html>