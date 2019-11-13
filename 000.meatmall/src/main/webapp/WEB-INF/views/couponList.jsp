<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>보유 쿠폰목록</title>
<script type="text/javascript">
	
	$(".couponSelect").click(function(){
		var couponNum = $(this).prev().val();
		var user_coupon_num = $("#user_coupon_num",opener.document);
		user_coupon_num.val(couponNum);
		
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
</script>
</head>
<body>
<table border="1">
	<tr>
		<th>이미지</th>
		<th>쿠폰명</th>
		<th>할인금액</th>
		<th>유효기간</th>
	</tr>
	<c:forEach items="${clist}" var="dto">
		<tr>
			<td><img src="${dto.coupon_img}" /></td>
			<td>${dto.coupon_name}</td>
			<td>${dto.coupon_money}</td>
			<td>${dto.user_coupon_date}</td>
			<td>
				<input type="hidden" value="${dto.user_coupon_num}" />
				<input type="text" class="couponSelect" value="선택" />
			</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>