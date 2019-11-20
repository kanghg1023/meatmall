<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
.list-table {   
	text-align: left;
}

.list-table, .list-table th , .list-table td {         
	text-align: left;
	padding:10px;               
}

.list-table th{
   height:40px;  
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 15px;
}
.list-table td{
   text-align:left;
   padding:10px 0;   
   border-bottom:1px solid #CCC; 
   height:20px;
   font-size: 13px 
}

.list-table .list:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .notice:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .actionbutton {
    margin-top:2%;
}
.bannerbtn {
    width: 100px;
    height: 30px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:#fff;
    transition: background-color .4s ease-out;
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
                <li class="abcd"><a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a></li>
                <li class="current abcd"><a href="bannerList.do?pnum=1"><span>배너관리</span></a></li>
			</ul>
		</div>
	</aside>            
</div>

<div class="ps-products-wrap pt-80 pb-80" style="width:70%;margin: auto 0 auto 17% ;">
<table class="list-table">
	<col width="300px">
	<col width="300px">
	<col width="300px">
	<col width="300px">
	<tr>
		<th>배너 이미지</th>
		<th>배너명</th>
		<th>등록일</th>
		<th>종료일</th>
	</tr>
	<c:choose>
		<c:when test="${empty bannerlist}">
			<tr>
				<td>배너가 존재하지 않습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${bannerlist}" var="dto">
				<tr>
					<td>
						<img src="${dto.banner_img_name}"  style="width:250px; height:230px;" >
					</td>
					<td>${dto.banner_name}</td>
					<td><fmt:formatDate value="${dto.banner_regist_date}" pattern="yy-MM-dd [hh:mm]" /></td>
					<td><fmt:formatDate value="${dto.banner_end_date}" pattern="yy-MM-dd [hh:mm]" /></td>
				</tr>
			</c:forEach>
			<c:if test="${map != null}">
				<tr>
					<td colspan="4" align="center" style="text-align: center;">
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
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="4">
			<input type="button" value="배너 추가" onclick="location.href='insertBannerForm.do'" class="bannerbtn"/>
		</td>
	</tr>
</table>
</div>
<br/><br/>
<jsp:include page="footer.jsp" />
</body>
</html>