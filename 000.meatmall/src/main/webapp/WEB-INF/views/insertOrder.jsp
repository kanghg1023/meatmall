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
	
	var totalSum = document.getElementById("totalSum");
	var realSum = document.getElementById("realSum");
	
	totalSum.innerHTML = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	realSum.innerHTML = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
<jsp:include page="header.jsp" />
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
					<th>주소 <input type="checkbox" value="주소와 배송지 동일" class="myAddr"/></th>
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
							${dto.goods_title} / ${dto.option_name} / ${dto.option_weight}g
						</td>
						<td>
							<input type="hidden" name="seller_num" class="seller_num" value="${dto.seller_num}" />
							<input type="hidden" name="goods_num" value="${dto.goods_num}" />
							<input type="hidden" name="option_num" class="option_num" value="${dto.option_num}" />
							<input type="hidden" name="option_count" class="option_count" value="${dto.basket_count}" />
							${dto.basket_count}개
						</td>
						<td>
							<fmt:parseNumber var="money" value="${(dto.option_weight/100*dto.goods_cost)*dto.basket_count}" integerOnly="true" />
							<input type="hidden" class="order_money" name="order_money" value="${money}" />
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
					<strong id="totalSum">0</strong><strong> 원</strong>
				</td>
			</tr>
			<tr>
				<th rowspan="2">할인 쿠폰</th>
				<td></td>
			</tr>
			<tr>
				<td><strong><span id="coupon_money">-</span></strong>
					<input type="button" id="coupon" value="선택" />
					<input type="hidden" id="user_coupon_num" name="user_coupon_num" value="0" />
				</td>
			</tr>
			<tr>
				<th>총 결제 금액</th>
				<td>
					<strong id="realSum"><fmt:formatNumber value="0" maxFractionDigits="0" /></strong><strong> 원</strong>
				</td>
			</tr>
		</table>
		<input type="submit" value="결제하기" >
	</form>
</body>
</html>