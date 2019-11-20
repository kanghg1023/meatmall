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

.abcd{
display: inline-block;
margin-left: 60px;
}

div.ps-product__columns{
	margin-right: 110px;
}
.list-table {
    margin:5px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  text-align: center;
  padding:10px;               
}

.list-table td{
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

.mybtn {
    width: 70px;
    height: 30px;
    padding: 0;
    border: 0;
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
</head>
<body>
<jsp:include page="header.jsp" />
<c:if test="${updateSuccess != null}">
   <script type="text/javascript">
      alert("${updateSuccess}");
   </script>
</c:if>
<div class="ps-sidebar" data-mh="product-listing" style="text-align: center;">
	<aside class="ps-widget--sidebar ps-widget--category">
		<div class="ps-widget__header">
			<h3>마이페이지</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                
                <li class="current abcd"><a href="myPage.do" class="myPage"><span>내 정보보기</span></a></li>
                <li class="abcd"><a href="orderList.do?user_num=${ldto.user_num}" class="category"><span>구매내역</span></a></li>
			<c:if test="${ldto.user_role ne 'USER'}">
                <li class="abcd"><a href="selOrderList.do?user_num=${ldto.user_num}" class="category"><span>내 상품관리</span></a></li>
			</c:if>
                <li class="abcd"><a href="myboardlist.do?pnum=1" class="myboardlist"><span>내가 쓴 글 보기</span></a></li>
                <li class="abcd"><a href="myCouponList.do?pnum=1&user_num=${ldto.user_num}" class="myCouponList"><span>내 쿠폰</span></a></li>
                <li class="abcd"><a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a></li>        
			</ul>
		</div>
	</aside>            
</div>
<div class="ps-products-wrap pt-80 pb-80" id="ps-products-wrap">
	<table border="1" class="list-table">
		<col width="500px">
		<col width="500px">
			<tr>
				<td>정보를 수정하시려면 비밀번호를 입력하세요</td>
            </tr>
            <tr>
				<td>
					<input type="password" id="pw" style="width:70%;"/>
					<input type="button" id="pwChk" class="mybtn" value="확인" />
               </td>
            </tr>
	</table>
</div>
<jsp:include page="footer.jsp" /> 
</body>
</html>