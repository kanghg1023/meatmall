<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
   <jsp:include page="header.jsp" />
<style type="text/css">
	.ps-shoe:hover:before {
    visibility: visible;
    opacity: 1;
    border: 1px solid #2AC37D;
    -webkit-transform: scale(1, 0.85);
    -moz-transform: scale(1, 0.85);
    -ms-transform: scale(1, 0.85);
    -o-transform: scale(1, 0.85);
    transform: scale(1, 0.85); 
	top:-45px;
    }
    .ps-shoe:hover .ps-shoe__content {
    padding-top: 10px;
    bottom: -10px;
    max-height: none; }
    
     #container_test{width:90%; overflow: auto; margin-left:25px;}    
     #slide{float: left;}    
     #test123{float:right;}    
	
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
</style>
</head>
<body>
<!-- <div id="header" class="header" style="outline: none;"> -->
<!-- </div> -->
<input type="hidden" name="page" value="main">

<main class="ps-main">
<div id="container_test">
<div id="slide" style="max-width: 100%; height: auto;">
  <input type="radio" name="pos" id="pos1" checked>
  <input type="radio" name="pos" id="pos2">
  <input type="radio" name="pos" id="pos3">
  <input type="radio" name="pos" id="pos4">
  <ul>
    <c:forEach items="${mainBanner}" var="dto">
  		<li><a href="#"><img src="${dto.banner_img_name}" style="display: block; margin-left: auto ; margin-right: auto; height:400px;"></a></li>
  	</c:forEach>
  </ul>
  <p class="pos">
    <label for="pos1"></label>
    <label for="pos2"></label>
    <label for="pos3"></label>
    <label for="pos4"></label>
  </p>
</div>
<!-- 여기부터 -->
<div id="test123" style="max-width: 100%; height: auto; margin-top:40px;margin-right:50px;">
<div style="width:50%;">
<h4 style="margin-bottom: 10px;">인기검색어<span style="margin-left:11px;color: #2AC37D;font-weight: bold; font-size: 20px;">TOP 5</span></h4>
<ul>
	<c:choose>
		<c:when test="${empty bestSearch}">
			<li>검색어가 없습니다.</li>
		</c:when>
		<c:otherwise>
			<c:set var="i" value="0" />
			<c:forEach items="${bestSearch}" var="dto">
				<c:set var="i" value="${i+1}" />
				<li style="margin-bottom: 5px;"><strong style="color: #2AC37D;">${i}</strong> <a href="search.do?search_word=${dto.search_word}">${dto.search_word}</a></li>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</ul>
</div>
<h4 style="margin-top:80px;"><span style="margin-right: 10px;color: #2AC37D;font-weight: bold; font-size: 20px;">BEST</span>게시글</h4>
<table class="list-table">
	<col width="300px"/><col width="150px"/><col width="90px"/>
	<tr>
		<th>제목</th>
		<th>작성자</th>
		<th>좋아요</th>
	</tr>
	<c:choose>
		<c:when test="${empty bestBoard}">
			<tr> 
				<td colspan="3">좋아요를 받은 게시글이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${bestBoard}" var="dto">
				<tr>
					<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>
					<td>${dto.user_nick}</td>
					<td>${dto.likecount}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</div>
</div>

<!-- 여기까지 -->
      <div class="ps-section--features-product ps-section masonry-root pt-100 pb-100">
        <div class="ps-container">
          <div class="ps-section__header mb-50">
            <h3 class="ps-section__title" data-mask="sale"></h3>
          </div>
          <div class="ps-section__content pb-50">
            <div class="masonry-wrapper" data-col-md="4" data-col-sm="2" data-col-xs="1" data-gap="30" data-radio="100%">
              <div class="ps-masonry">
                <div class="grid-sizer"></div>
                <!-- 반복 -->
                <c:forEach items="${mainList}" var="dto"> 
                <div class="grid-item kids">
               
                  <div class="grid-item__content-wrapper" >
					
                    <div class="ps-shoe mb-30" >
                      <div class="ps-shoe__thumbnail">
                        <img src="${dto.goods_img_title}" alt="" style="height:250px;"><a class="ps-shoe__overlay" href="goodsDetail.do?goods_num=${dto.goods_num}"></a>
                      </div>
                      <div class="ps-shoe__content" >
                      <div class="ps-shoe__variants" >
                         </div>
                        <div class="ps-shoe__detail"><a class="ps-shoe__name" href="#">${dto.goods_title}</a>
                          <p>100g 당</p>
                          <p class="ps-shoe__categories"><fmt:formatNumber value="${dto.goods_cost}" maxFractionDigits="0" />원</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </div>
  
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>