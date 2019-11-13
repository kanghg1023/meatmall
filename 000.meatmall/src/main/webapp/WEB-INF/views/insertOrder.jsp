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
	var sum = document.getElementsByClassName("sum");
	var a;
	var total = 0;
	var i;
	for(i=0;i<sum.length;i++){
		a = sum[i].innerHTML.replace(/,/gi,"");
		total += eval(a);
	}
	
	var allSum = document.getElementsByClassName("totalSum");
	
	for(i=0;i<allSum.length;i++){
		allSum[i].innerHTML = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
}

$(function() {
	$("form").submit(function() {
		var bool = true;
		var count = $(this).find("input[name=chk]:checked").length; //체크된 input태그의 개수
		if (count == 0) {
			alert("하나이상 선택하시오");
			bool = false;
		}else{
			var isDel = confirm(count+" 개 상품을 정말 삭제하시겠습니까?");
			if(!(isDel)){
				bool = false;
			}
		}
		return bool;
	});

	function changeBcount(num){
		var sell_price = num.parent().next("td").find(".fmtNum");
		var sum = num.parent().next().find(".sum");
		var totalAmount = sum.html().replace(/,/gi,"");
		var amount = sell_price.val().replace(/,/gi,"");
		var totalAmount = (eval(num.val())*eval(amount));
		
		sum.html(totalAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		allSum();
	};
	
	$(document).ready(function() {
		allSum();
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
		<form action=".do" method="post">
			<table border="1">
				<tr>
					<th>이름</th>
					<td>${uDto.user_name}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${uDto.user_email}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${uDto.user_ph}</td>
				</tr>
			</table>
			
		<h3>받는 사람 정보</h3>
			<table border="1">
				<tr>
					<th>이름</th>
					<td>
						<input type="hidden" name="user_num" value="${uDto.user_num}">
						<input type="text" value="${uDto.user_name}">
					</td>
				</tr>
				<tr>
					<th>배송 주소</th>
					<td><input type="text" name="order_addr" value="${uDto.user_addr}"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" value="${uDto.user_ph}"></td>
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
								<input type="hidden" name="goods_num" value="${dto.goods_num}" />
								${dto.goods_title} / ${dto.option_name} / ${dto.option_weight}G
							</td>
							<td>
								<input type="hidden" name="option_num" class="option_num" value="${dto.option_num}" />
								<input type="hidden" name="option_weight" class="option_weight" value="${dto.option_weight}" />
								${dto.basket_count}개
							</td>
							<td>
								<input type="hidden" class="fmtNum" name="sum" value="<fmt:formatNumber value="${(dto.option_weight/100*dto.goods_cost)}" maxFractionDigits="0" />" />
								<strong class="sum"><fmt:formatNumber value="${(dto.option_weight/100*dto.goods_cost)*dto.basket_count}" maxFractionDigits="0" /></strong><strong> 원</strong>
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
					<td>0원</td>
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
				<tr>
					<th>결제 방법</th>
					<td>
						<select>
							<option>카카오페이</option>
							<option>계좌이체</option>
							<option>신용/체크카드</option>
							<option>무통장입금(가상계좌)</option>
						</select>
					</td>
				</tr>
			</table>
			<input type="submit" value="결제하기" >
	</form>
</body>
</html>