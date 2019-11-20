<%@page import="com.hk.meatmall.dtos.Goods_kindDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.abcd{
	display: inline-block;
	margin-left: 60px;
}
.catebtn { 
   width: 40%;
    height: 30px;
    padding: 0px;
    border: 0;
    margin-left:12px;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
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
<script type="text/javascript"
   src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function allSel(ele) {
	$("input[name=chk]").prop("checked", $(ele).prop("checked"));
}
$(function() {
   $("form").submit(function() {
      var bool = true;
      var count = $(this).find("input[name=chk]:checked").length; //체크된 input태그의 개수
      if (count == 0) {
         alert("하나이상 선택하시오");
         bool = false;
      }else{
         var isDel = confirm(count+" 개 카테고리를 정말 삭제하시겠습니까?");
         if(!(isDel)){
            bool = false;
         }
      }
      return bool;
   });
});   
</script>
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
                <li class="current abcd"><a href="category.do"><span>카테고리 관리</span></a></li>
                <li class="abcd"><a href="searchAdmin.do"><span>인기검색어 관리</span></a></li>
                <li class="abcd"><a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a></li>
                <li class="abcd"><a href="bannerList.do?pnum=1"><span>배너관리</span></a></li>
			</ul>
		</div>
	</aside>            
</div>
<h4 style="margin-left: 500px; margin-bottom: -20px;margin-top: 100px;">부위별 카테고리</h4>
	<form action="delCategory.do" method="post">
		<div id="container" style="width:100%;">
			<table class="list-table" style="margin-bottom: 150px;text-align: center;">
			<col width="400px">
			<col width="500px">
				<tr>
					<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
					<th>부위별 종류</th>
				</tr>
					<c:forEach items="${category}" var="dto">
						<tr align="center">
							<td id="chk">
								<input type="checkbox" name="chk" value="${dto.kind_num}" />
							</td>
							<td id="seq">
								<a href="allGoods.do?kind_num=${dto.kind_num}&pnum=1">${dto.kind_name}</a>
							</td>
						</tr>
					</c:forEach>
				<tr>
					<td colspan="2">
						<input type="button" value="카테고리 추가" 
          					  onclick="window.open('insertCategoryForm.do','insertCategory','width=450px,height=30px,location=no,status=no,scrollbars=no')" class="catebtn" />
           				<input type="submit" value="카테고리 삭제" class="catebtn" />
					</td>
				</tr>
			</table>
		</div>
	</form>

<jsp:include page="footer.jsp" />     
</body>
</html>