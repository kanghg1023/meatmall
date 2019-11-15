<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
   
   #layer1 {
   padding-top : 50px;
   margin-left : 30%;
   margin-bottom : 200px;
   width: 800px;
   }
   
   #heading {
   margin: 1px;
   color: black;
   padding: 3px 10px;
   cursor: pointer;
   background-color:white;
   border-bottom:1px solid #2AC37D;>
   height: 30px;
   }
   
   .content {
   padding: 5px 10px;
   background-color:#E2E2E2;
   }
   
   p { 
   padding:5px; 
   margin-top: 10px;   
   }
   
   .faqbutton {
   width: 8%;
    height: 30px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
   }
   
   #faqinsert {
   width: 20%;
    height: 30px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
   }
   
   #interval {
   padding: 10px 0 0 0;
   }
</style>
<script type="text/javascript">

   $(document).ready(function() {
      $(".content").hide();
      
      $(".heading").click(function(){
         var content = $(this).next(".content");
         $(".content").not(content).hide();
         content.slideToggle(300);
      });   
   });
   
</script>

</head>
<body>

   <jsp:include page="header.jsp" />

<div id="layer1">
   <h2>FAQ</h2>
   <p style="border-bottom:3px solid #2AC37D"></p>
   <c:forEach items="${faqlist}" var="dto">
      <div class="heading" id="heading" >
         <p>${dto.faq_title}</p>
      </div>
      <div class="content" id="content">
         <pre>${dto.faq_content}</pre>
         <c:if test="${ldto.user_role eq 'ADMIN'}">
            <input type="button" value="글 수정" 
                      onclick="location.href='faqupdateform.do?faq_num=${dto.faq_num}'" class="faqbutton"/>
            <input type="button" value="글 삭제" 
                      onclick="location.href='faqdelboard.do?faq_num=${dto.faq_num}'" class="faqbutton"/>
         </c:if>
      </div>
   </c:forEach>
   <c:if test="${ldto.user_role eq 'ADMIN'}">   
      <div id="interval">
         <input type="button" value="자주묻는글 추가" 
                   onclick="location.href='faqinsertform.do'" id="faqinsert"/>      
      </div>
   </c:if>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>