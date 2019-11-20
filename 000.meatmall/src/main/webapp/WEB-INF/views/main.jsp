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
</style>
</head>
<body>
<!-- <div id="header" class="header" style="outline: none;"> -->
<!-- </div> -->
<input type="hidden" name="page" value="main">

<main class="ps-main">
<div id="slide">
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
<h4>인기검색어</h4>
<ul>
	<c:choose>
		<c:when test="${empty bestSearch}">
			<li>검색어가 없습니다.</li>
		</c:when>
		<c:otherwise>
			<c:forEach items="${bestSearch}" var="dto">
				<li><a href="search.do?search_word=${dto.search_word}">${dto.search_word}</a></li>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</ul>
<h4>베스트 게시글</h4>
<table border="1">
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

<!-- 여기까지 -->
      <div class="ps-section--features-product ps-section masonry-root pt-100 pb-100">
        <div class="ps-container">
          <div class="ps-section__header mb-50">
            <h3 class="ps-section__title" data-mask="wholesale">- 도매 상품</h3>
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
                        <a class="ps-shoe__favorite" href="#"><i class="ps-icon-heart"></i></a><img src="${dto.goods_img_title}" alt="" style="height:250px;"><a class="ps-shoe__overlay" href="goodsDetail.do?goods_num=${dto.goods_num}"></a>
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