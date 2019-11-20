<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 관리 페이지</title>

<style type="text/css">


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
			<h3>관리자페이지</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                 
                <li class="abcd"><a href="userAdmin.do?pnum=1"><span>회원관리</span></a></li>
                <li class="abcd"><a href="category.do"><span>카테고리 관리</span></a></li>
                <li class="abcd"><a href="searchAdmin.do"><span>인기검색어 관리</span></a></li>
                <li class="current abcd"><a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a></li>
                <li class="abcd"><a href="bannerList.do?pnum=1"><span>배너관리</span></a></li>
			</ul>
		</div>
	</aside>            
</div>
<table class="list-table">
	
	
	<tr>
		<th>쿠폰 이미지</th>
		<th>쿠폰명</th>
		<th>할인금액</th>
		<th>기간</th>
	</tr>
	<c:forEach items="${coulist}" var="dto">
		<tr>
			<td>
				<img src="${dto.coupon_img}"  style="width:250px; height:230px;" >
			</td>
			<td>${dto.coupon_name}</td>
			<td>${dto.coupon_money} 원</td>
			<td>${dto.coupon_period} 일</td>
		</tr>
	</c:forEach>
	<c:if test="${map != null}">
		<tr>
			<td colspan="4" align="center">
			<c:if test="${pnum != 1}">
				<a href="adminCouponList.do?pnum=${map.prePageNum}">◀</a>
			</c:if>	
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}" step="1">
					<c:choose>
						<c:when test="${pnum eq i}">
							${i}
						</c:when>
						<c:otherwise>
							<a href="adminCouponList.do?pnum=${i}">${i}</a>
						</c:otherwise>
					</c:choose>	
				</c:forEach>
			<c:if test="${pnum < map.pcount}">
				<a href="adminCouponList.do?pnum=${map.nextPageNum}">▶</a>
			</c:if>
			</td>
		</tr>
	</c:if>
	
	<tr>
		<td colspan="4">
			<input type="button" value="쿠폰생성" class="buttonsignup actionbutton" onclick="location.href='insertCouponForm.do'" />
		</td>
	</tr>
</table>
<br/><br/>
<jsp:include page="footer.jsp" />
</body>
</html>