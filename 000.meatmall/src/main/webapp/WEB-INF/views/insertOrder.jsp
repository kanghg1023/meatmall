<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

function allSum(){
	var sum = document.getElementsByClassName("order_money");
	var a;
	var total = 0;
	var i;
	for(i=0;i<sum.length;i++){
		a = sum[i].value.replace(/,/gi,"");
		total += eval(a);
	}
	
	var allSum = document.getElementsByClassName("totalSum");
	
	for(i=0;i<allSum.length;i++){
		allSum[i].innerHTML = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
}

$(function() {
	
	
	$(".myAddr").change(function(){
		var chk = $(".myAddr").is(":checked");
		
		if(chk){
			$(".addr").val("${ldto.user_addr}");
			$(".addrDetail").val("${ldto.user_addr_detail}");
		}else{
			$(".addr").val("");
			$(".addrDetail").val("");
		}
	});

	
	function changeBcount(num){
		var sell_price = num.parent().next("td").find(".fmtNum");
		var sum = num.parent().next().find(".order_money");
		var totalAmount = sum.html().replace(/,/gi,"");
		var amount = sell_price.val().replace(/,/gi,"");
		var totalAmount = (eval(num.val())*eval(amount));
		
		sum.html(totalAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		allSum();
	};
	
	$(document).ready(function() {
		allSum();
	});
	
	$("#jusoApi").click(function(){
		window.open("getAddr.do","","width=500px,height=500px");
	});
	
	$("#coupon").click(function(){
		window.open("couponList.do?user_num=${ldto.user_num}","","width=500px,height=500px");
	});
});

</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>주문/결제</h1>
	<h3>구매자 정보</h3>
		<form action="insertOrder.do" method="post">
			<input type="hidden" name="user_num" value="${ldto.user_num}">
			<table border="1">
				<tr>
					<th>이름</th>
					<td>${ldto.user_name}</td>
				</tr>
				<tr>
					<th>배송 주소 <input type="checkbox" value="주소와 배송지 동일" class="myAddr"/></th>
					<td>
						<input type="text" id="user_addr" name="addr" class="addr" />
						<input type="button" id="jusoApi" value="주소검색" />
					</td>
				</tr>
				<tr>
					<th>상세 주소</th>
					<td><input type="text" id="user_addr_detail" name="addrDetail" class="addrDetail" /></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${ldto.user_ph}</td>
				</tr>
			</table>
			
		<h3>주문 정보</h3>
			<table border="1">
				<thead>
				<tr>
					<th scope="colgroup" colspan="3">상품정보</th>
					<th>상품금액</th>
					<th>배송비</th>
				</tr>
				</thead>
				<c:forEach items="${basketList}" var="dto">
					<tr align="center">
						<td align="left" ><img src="${dto.goods_img_title}" style="width:78px; height:78px;"></td>
						<td>
							${dto.goods_title} / ${dto.option_name} / ${dto.option_weight}G
						</td>
						<td>
							<input type="hidden" name="seller_num" class="seller_num" value="${dto.seller_num}" />
							<input type="hidden" name="goods_num" value="${dto.goods_num}" />
							<input type="hidden" name="option_num" class="option_num" value="${dto.option_num}" />
							<input type="hidden" name="option_count" class="option_count" value="${dto.basket_count}" />
							${dto.basket_count}개
						</td>
						<td>
							<input type="hidden" class="order_money" name="order_money" value="<fmt:formatNumber value="${(dto.option_weight/100*dto.goods_cost)}" maxFractionDigits="0" />" />
							<strong><fmt:formatNumber value="${(dto.option_weight/100*dto.goods_cost)*dto.basket_count}" maxFractionDigits="0" /></strong><strong> 원</strong>
						</td>
						<td>무료</td>
					</tr>
				</c:forEach>
			</table>
			
		<h3>결제 정보</h3>
		<table border="1">
			<tr>
				<th>총 상품 가격</th>
				<td>
					<strong class="totalSum"><fmt:formatNumber value="0" maxFractionDigits="0" /></strong><strong> 원</strong>
				</td>
			</tr>
			<tr>
				<th>할인 쿠폰</th>
				<td>0원<input type="button" id="coupon" value="선택" />
					<input type="hidden" id="user_coupon_num" name="user_coupon_num" value="" />
				</td>
<!-- 				팝업에서 오프너 위치구해서 한줄더만들고 태그포함 삽입  -->
			</tr>
			<tr>
				<th>배송비</th>
				<td>0원</td>
			</tr>
			<tr>
				<th>총 결제 금액</th>
				<td>
					<strong class="realSum"><fmt:formatNumber value="0" maxFractionDigits="0" /></strong><strong> 원</strong>
				</td>
			</tr>
		</table>
		<input type="submit" value="결제하기" >
	</form>
</body>
</html>