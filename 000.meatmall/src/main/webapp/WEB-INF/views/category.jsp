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
<h4>부위별 카테고리</h4>
<main class="ps-main">
      <div class="ps-products-wrap pt-80 pb-80">
        <div class="ps-sidebar" data-mh="product-listing">
          <aside class="ps-widget--sidebar ps-widget--category">
            <div class="ps-widget__header">
              <h3>Category</h3>
            </div>
            <div class="ps-widget__content">
              <ul class="ps-list--checked">
                 <c:forEach items="${cList}" var="cList">
                <li class="current">
                <c:if test="${ldto.user_role eq 'ADMIN'}">
               <input type="checkbox" name="chk" value="${cList.kind_num}" />
            </c:if>
               <a href="allGoods.do?kind_num=${cList.kind_num}&pnum=1">${cList.kind_name}</a>            
                 </li>
                 </c:forEach>
              </ul>
            </div>
          </aside>
         <aside class="ps-widget--sidebar ps-widget--filter">    
         <div>
            <input type="button" value="카테고리 추가" 
            onclick="window.open('insertCategoryForm.do','insertCategory','width=450px,height=30px,location=no,status=no,scrollbars=no')" class="catebtn" />
            <input type="submit" value="카테고리 삭제" class="catebtn" />
            </div>
          </aside>     
        </div>        
      </div>      
    </main>
<jsp:include page="footer.jsp" />     
</body>
</html>