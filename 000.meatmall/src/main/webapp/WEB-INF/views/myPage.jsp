<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>마이페이지</title>
<script type="text/javascript">
   $(function(){
      $("#pwChk").click(function(){
         var aCount = $("#pwChk");
         var user_id = "${ldto.user_id}";
         var pw = $("#pw").val();
         
         $.ajax({
            url:"pwChk.do",
            data:{"user_id":user_id
               ,"pw":pw},
            method:"post",
            datatype:"json",
            async:false,
            success:function(isPW){
               if(isPW){
                  location.href="userInfo.do";
               }else{
                  aCount.after("<div class='chkFalse'>"
                              +"다시 입력해 주십시오."
                           +"</div>");
               }
            },
            error:function(){
               alert("서버통신에러: 관리자에게 문의주세요");
            }
         });
      });
   });
</script>
<style type="text/css">
#ps-products-wrap{
   width:60%; text-align:left; margin:0px auto;
}
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<c:if test="${updateSuccess != null}">
   <script type="text/javascript">
      alert("${updateSuccess}");
   </script>
</c:if>
<div class="ps-products-wrap pt-80 pb-80" id="ps-products-wrap">
   <div class="ps-products" data-mh="product-listing">
      <div class="ps-product__columns">
           <table border="1">
            <tr>
               <td>정보를 수정하시려면 비밀번호를 입력하세요</td>
            </tr>
            <tr>
               <td>
                  <input type="password" id="pw" />
                  <input type="button" id="pwChk" value="확인" />
               </td>
            </tr>
         </table>
      </div>
   </div>
        <div class="ps-sidebar" data-mh="product-listing">
          <aside class="ps-widget--sidebar ps-widget--category">
            <div class="ps-widget__header">
              <h3>마이페이지</h3>
            </div>
            <div class="ps-widget__content">
              <ul class="ps-list--checked">                
                <li class="current"><a href="myPage.do" class="myPage"><span>내 정보보기</span></a></li>
                <li><a href="orderList.do?user_num=${ldto.user_num}" class="category"><span>구매내역</span></a></li>
                <li><a href="myboardlist.do?pnum=1" class="faqlist"><span>내가 쓴 글</span></a></li>
                <li><a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a></li>        
              </ul>
            </div>
          </aside>            
        </div>        
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>