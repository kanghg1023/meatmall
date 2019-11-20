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
<style type="text/css">
.abcd{
	display: inline-block;
	margin-left: 60px;
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

#searchbtn {
    width: 50px;
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
                <li class="current abcd"><a href="searchAdmin.do"><span>인기검색어 관리</span></a></li>
                <li class="abcd"><a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a></li>
                <li class="abcd"><a href="bannerList.do?pnum=1"><span>배너관리</span></a></li>
			</ul>
		</div>
	</aside>            
</div>
<form action="insertBestSearch.do" method="post">
	<h4 style="margin-left: 600px;margin-bottom: -120px;margin-top: 120px;">인기검색어 순위 변경</h4>
<table class="list-table" style="margin-bottom: 250px;margin-top: 150px;">	
	<col width="350px">
	<col width="350px">
	<tr>
		<th>순위</th>
		<th>검색어</th>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach items="${bestSearch}" var="dto">
		<c:set var="i" value="${i+1}" />
		<tr>
			<td>${i}</td>
			<td>${dto.search_word}</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="2">
			<span>순위</span>
			<select name=search_fake_ranking>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
			<span style="margin-left: 20px;">검색어</span>
			<input type="text" name="search_word" style="width:50%;"/>
			
			<input type="submit" value="등록" id="searchbtn" />
		</td>
	</tr>
</table>
</form>
</body>
<jsp:include page="footer.jsp" />
</html>
