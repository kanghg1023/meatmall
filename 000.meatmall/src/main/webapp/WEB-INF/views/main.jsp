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
</head>
<body>
<!-- <div id="header" class="header" style="outline: none;"> -->
   <jsp:include page="header.jsp" />
<!-- </div> -->
<input type="hidden" name="page" value="main">

<main class="ps-main">
<div id="slide">
  <input type="radio" name="pos" id="pos1" checked>
  <input type="radio" name="pos" id="pos2">
  <input type="radio" name="pos" id="pos3">
  <input type="radio" name="pos" id="pos4">
  <ul>
    <li><a href="#"><img src="img/gogi.jpg" style="display: block; margin-left: auto ; margin-right: auto; height:400px;"></a></li>
    <li><a href="#"><img src="img/coupon.png" style="display: block; margin-left: auto ; margin-right: auto; height:400px;"></a></li>
    <li></li>
    <li></li>
  </ul>
  <p class="pos">
    <label for="pos1"></label>
    <label for="pos2"></label>
    <label for="pos3"></label>
    <label for="pos4"></label>
  </p>
</div>
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
                  <div class="grid-item__content-wrapper">
                    <div class="ps-shoe mb-30">
                      <div class="ps-shoe__thumbnail">
                        <a class="ps-shoe__favorite" href="#"><i class="ps-icon-heart"></i></a><img src="${dto.goods_img_title}" alt=""><a class="ps-shoe__overlay" href="goodsDetail.do?goods_num=${dto.goods_num}"></a>
                      </div>
                      <div class="ps-shoe__content">
                      <div class="ps-shoe__variants">
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