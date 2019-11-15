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
<script type="text/javascript"
   src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
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
<main class="ps-main">
      <c:choose>
      <c:when test="${kind_num eq null}">
         <h1>전체에서</h1>
         <input type="hidden" name="pnum" value="${pnum}">
      </c:when>
      <c:otherwise>
         <h1>카테고리에서</h1>
         <input type="hidden" name="kind_num" value="${kind_num}">
         <input type="hidden" name="pnum" value="${pnum}">
      </c:otherwise>
   </c:choose>
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
                        <c:when test="${dto.goods_delflag eq 0}"><img src="" alt="삭제된 이미지"></c:when>
                        <c:otherwise>
                  <a class="ps-shoe__favorite" href="#"><i class="ps-icon-heart"></i></a><img src="${dto.goods_img_title}" alt=""><a class="ps-shoe__overlay" href="goodsDetail.do?goods_num=${dto.goods_num}"></a>
                        </c:otherwise>
                  </c:choose>
                </div>
                <div class="ps-shoe__content">                 
                  <div class="ps-shoe__detail"><a class="ps-shoe__name" href="#">등심이</a>
                    <p class="ps-shoe__categories">500만원</p>
                    <p>1kg단위</p>                     
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
                <li><a href="#"><i class="fa fa-angle-left"></i></a></li>
                <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">...</a></li>
                <li><a href="#"><i class="fa fa-angle-right"></i></a></li>
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
            <c:forEach items="${cList}" var="dto">
                 <c:choose>
                    <c:when test="${kind_num eq dto.kind_num}">
                       <li class="current">
                         <c:if test="${ldto.user_role eq 'ADMIN'}">
                           <input type="checkbox" name="chk" value="${dto.kind_num}" />
                        </c:if>
                          <a href="allGoods.do?kind_num=${dto.kind_num}&pnum=1">${dto.kind_name}</a>            
                      </li>
                    </c:when>
                    <c:otherwise>
                       <li>
                         <c:if test="${ldto.user_role eq 'ADMIN'}">
                           <input type="checkbox" name="chk" value="${dto.kind_num}" />
                        </c:if>
                          <a href="allGoods.do?kind_num=${dto.kind_num}&pnum=1">${dto.kind_name}</a>            
                      </li>
                    </c:otherwise>
                 </c:choose>
                 </c:forEach>
              </ul>
            </div>
          </aside>
         <aside class="ps-widget--sidebar ps-widget--filter">    
         <div>       
         <c:if test="${ldto.user_role eq 'ADMIN'}">
            <input type="button" value="카테고리 추가" 
            onclick="window.open('insertCategoryForm.do','insertCategory','width=450px,height=30px,location=no,status=no,scrollbars=no')" class="catebtn" />
            <input type="submit" value="카테고리 삭제" class="catebtn" />
         </c:if>
            </div>
          </aside>     
        </div>        
      </div>      
    </main>
<jsp:include page="footer.jsp" />    
</body>
</html>