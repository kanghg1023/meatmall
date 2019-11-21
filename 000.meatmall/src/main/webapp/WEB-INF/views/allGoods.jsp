<%@page import="com.hk.meatmall.dtos.Goods_kindDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
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
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<main class="ps-main">
      <div class="ps-products-wrap pt-80 pb-80">
        <div class="ps-products" data-mh="product-listing">
          <c:choose>
             <c:when test="${empty gList}">
                <p>----상품이 없습니다.----</p>
             </c:when>    
             <c:otherwise>         
          <div class="ps-product__columns">
            <!-- 반복 -->
            <c:forEach items="${gList}" var="dto">
            <div class="ps-product__column">
              <div class="ps-shoe mb-30">
                <div class="ps-shoe__thumbnail">
                  <c:choose>
                        <c:when test="${dto.goods_delflag eq 0}"><img src="img/삭제상품.png" alt="삭제된 이미지" style="height:200px;"><a class="ps-shoe__overlay" href="goodsDetail.do?goods_num=${dto.goods_num}"></a></c:when>
                        <c:otherwise>
                  <a class="ps-shoe__favorite" href="#"><i class="ps-icon-heart"></i></a><img src="${dto.goods_img_title}"  alt="" id="abcd" style="height:200px;" ><a class="ps-shoe__overlay" href="goodsDetail.do?goods_num=${dto.goods_num}"></a>
                        </c:otherwise>
                  </c:choose>
                </div>
                <div class="ps-shoe__content">
                  <div class="ps-shoe__detail"><a class="ps-shoe__name" href="#">${dto.goods_title}</a>
                    <p>100g 당</p>
                    <p class="ps-shoe__categories"><fmt:formatNumber value="${dto.goods_cost}" maxFractionDigits="0" />원</p>
                  </div>
                </div>
              </div>
            </div>
            </c:forEach>           
          </div>
             </c:otherwise>
          </c:choose>
          <div class="ps-product-action">
            <div class="ps-pagination">
              <ul class="pagination">
              	<c:if test="${pnum != 1}">
					<li><a href="allGoods.do?pnum=${map.prePageNum}${statusPage==null?'':statusPage}"><i class="fa fa-angle-left"></i></a></li>				
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}" step="1" >																			
					<c:choose>
						<c:when test="${i == 0}">
							<li class="active"><a href="#">1</a></li>
						</c:when>
						<c:when test="${pnum eq i}">
							<li class="active"><a href="#">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="allGoods.do?pnum=${i}${statusPage==null?'':statusPage}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pnum < map.pcount}">
					 <li><a href="allGoods.do?pnum=${map.nextPageNum}${statusPage==null?'':statusPage}"><i class="fa fa-angle-right"></i></a></li>
				</c:if>
              </ul>
            </div>
          </div>
        </div>
        <div class="ps-sidebar" data-mh="product-listing">
          <aside class="ps-widget--sidebar ps-widget--category">
            <div class="ps-widget__header">
              <h3>Category</h3>
            </div>
                 
            <div class="ps-widget__content">
              <ul class="ps-list--checked">
            <c:choose>
               <c:when test="${kind_num == null}">
                   <li class="current"><a href="allGoods.do?pnum=1">전체상품보기</a></li>
               </c:when>
               <c:otherwise>
                  <li><a href="allGoods.do?pnum=1">전체상품보기</a></li>
               </c:otherwise>
            </c:choose>
            <c:forEach items="${category}" var="dto">
                 <c:choose>
                    <c:when test="${kind_num eq dto.kind_num}">
                       <li class="current">
                          <a href="allGoods.do?kind_num=${dto.kind_num}&pnum=1">${dto.kind_name}</a>            
                      </li>
                    </c:when>
                    <c:otherwise>
                       <li>
                          <a href="allGoods.do?kind_num=${dto.kind_num}&pnum=1">${dto.kind_name}</a>            
                      </li>
                    </c:otherwise>
                 </c:choose>
                 </c:forEach>
              </ul>
              <c:if test="${ldto.user_role ne 'USER'}">
	            <input type="button" value="상품 등록" 
	            	onclick="location.href='insertGoodsForm.do'" class="catebtn" />
	         </c:if>
            </div>
          </aside>
        </div>
      </div>
    </main>
<jsp:include page="footer.jsp" />
</body>
</html>