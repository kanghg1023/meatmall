<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>보유 쿠폰목록</title>
<style type="text/css">

.list-table, .list-table th , .list-table td{         

  text-align: center;
  padding:10px;               
}

.list-table th{
   height:40px;
   width: 400px;
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

.list-table .list:hover td{
   background-color: #eee;
   cursor : pointer;
}

.list-table .notice:hover td{
   background-color: #eee;
   cursor : pointer;
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

.couponSelect {
    width: 50px;
    height: 27px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
    transition: background-color .4s ease-out;
}
</style>
<script type="text/javascript">
	
	$(function(){
		$(".couponSelect").click(function(){
			var couponNum = $(this).prev().val();
			var user_coupon_num = $("#user_coupon_num",opener.document);
			var coupon_money = $("#coupon_money",opener.document);
			
			var name = $(this).parent().prev().prev().prev().html();
			var money = $(this).parent().prev().prev().children().children().filter("span").html();
			
			user_coupon_num.parent().parent().prev().children().filter("td").html("<strong>"+name+"</strong>");
			user_coupon_num.val(couponNum);
			coupon_money.html(money+" 원");
			
			var totalSum = $("#totalSum",opener.document).html().replace(/,/gi,"");
			var realSum = $("#realSum",opener.document);
			var total = eval(totalSum)-eval(money.replace(/,/gi,""));
			
			realSum.html(total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			
			self.close();
		});
		
		$("body").on("click","a",function(){
		 	var addr = $("#user_addr",opener.document);
		 	var addr_detail = $("#user_addr_detail",opener.document);
		 	
		 	addr.val($(this).text());
		 	$(opener.location).attr("href", "javascript:addrChkfun();");
		 	addr_detail.focus();
			
		 	self.close();
		});
	});
	
</script>
</head>
<body>
<table class="list-table">
	<tr>
		<th>이미지</th>
		<th>쿠폰명</th>
		<th>할인금액</th>
		<th>유효기간</th>
	</tr>
	<c:forEach items="${clist}" var="dto">
		<tr>
			<td><img src="${dto.coupon_img}" style="width:250px;height: 100px;"/></td>
			<td>${dto.coupon_name}</td>
			<td>
				<strong>
					<span>
						<fmt:formatNumber value="${dto.coupon_money}" maxFractionDigits="0" />
					</span> 원
				</strong>
			</td>
			<td><fmt:formatDate value="${dto.user_coupon_date}" pattern="yyyy년MM월dd일"/> 까지</td>
			<td>
				<input type="hidden" value="${dto.user_coupon_num}" />
				<input type="button" class="couponSelect" value="선택"/>
			</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>