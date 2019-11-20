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
<style type="text/css">
.list-table {
    margin:100px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  text-align: center;
  padding:10px;               
}

.list-table th{
   height:40px;
   width: 400px;
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
#moneybtn {
    width: 50%;
    height: 50px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
    transition: background-color .4s ease-out;
}

.orderbtn {
    width: 10%;
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
		window.open("getAddr.do","","width=400px,height=500px");
	});
	
	$("#coupon").click(function(){
		window.open("couponList.do?user_num=${ldto.user_num}","","width=800px,height=500px");
	});
	
	$("form").submit(function(){
		var realSum = $("#realSum");
		
		var cost = realSum.val().replace(/,/gi,"");
		
		if(${ldto.license_level} > 1){
			
			$.ajax({
				url:"levelChk.do",
				data:{"license_level":"${ldto.license_level}"},
				method:"post",
				datatype:"text",
				async:false,
				success:function(discount){
					alert("여기1");
					var total = round((eval(cost)*(100-eval(discount))/100)/10)*10;
					alert("여기2");
					var totalSum = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					alert("여기3");
					alert("고객님의 사업자 등급에 따라 "+discount+"% 할인이 적용되어"
							+"총 "+totalSum+"원이 결제됩니다.");
					return false;
				},
				error:function(){
					alert("서버통신에러: 관리자에게 문의주세요");
					return false;
				}
			});
		}else{
			alert("총 "+realSum.value+"원이 결제됩니다.");
		}
		return false;
	});
	
	
});

</script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="ps-products-wrap pt-80 pb-80" style="width:70%;margin: 0 auto;">
<h1 style="margin:0px 0px 80px 0px;">주문/결제</h1>
	<h3 style="margin-bottom: -60px;">주문 정보</h3>
	<form action="insertOrder.do" method="post">
			<input type="hidden" name="user_num" value="${ldto.user_num}">
			<table class="list-table" style="width:100%;">
			<col width="25%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
				<thead>
				<tr>
					<th style="border-top:2px solid #2AC37D;">상품정보</th>
					<th style="border-top:2px solid #2AC37D;">수량</th>					
					<th style="border-top:2px solid #2AC37D;">상품금액</th>
					<th style="border-top:2px solid #2AC37D;">배송비</th>
				</tr>
				</thead>
				<c:forEach items="${basketList}" var="dto">
					<tr align="center">
						<td align="left" ><img src="${dto.goods_img_title}" style="width:78px; height:78px;">	
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
			
		<h3 style="margin-bottom: -60px;">결제 정보</h3>
		<table class="list-table" style="width:100%;">
			<col width="20%">
			<col width="5%">
			<col width="20%">
			<col width="20%">
			<tr>
				<th style="border-top:2px solid #2AC37D;">총 상품 가격</th>
				<th style="border-top:2px solid #2AC37D;"></th>
				<th style="border-top:2px solid #2AC37D;">할인 쿠폰</th>
				<th style="border-top:2px solid #2AC37D;">총 결제 금액</th>				
			</tr> 			
			<tr>
				<td>
					<strong id="totalSum">0</strong><strong> 원</strong>
				</td>
				<td><img src="img/결제마이너스.png" alt=""/></td>			
				<td><strong><span id="coupon_money">-</span></strong>
					<input type="button" id="coupon" value="선택" class="orderbtn" />
					<input type="hidden" id="user_coupon_num" name="user_coupon_num" value="0" />
				</td>
				<td>
					<strong id="realSum"><fmt:formatNumber value="0" maxFractionDigits="0" /></strong><strong> 원</strong>
				</td>
			</tr>
		</table>		
	
	<h3 style="margin-bottom: -60px;">구매자 정보</h3>
		
			<table class="list-table" style="width:100%;">
				<tr>
					<th style="border-top:2px solid #2AC37D;">이름</th>
					<td style="border-top:2px solid #2AC37D;">${ldto.user_name}</td>				
				</tr>
				<tr>
					<th style="width:30%;">주소 <input type="checkbox" value="주소와 배송지 동일" class="myAddr"/></th>
					<td style="width:70%;">
						<input type="text" id="user_addr" name="addr" class="addr" style="width:60%;"/>
						<input type="button" id="jusoApi" value="주소검색" style="width:10%;" class="orderbtn"/>
					</td>
				</tr>
				<tr>
					<th>상세 주소</th>
					<td><input type="text" id="user_addr_detail" name="addrDetail" class="addrDetail" style="width:70%;"/></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${ldto.user_ph}</td>
				</tr>
				<tr>
					<td style="border-bottom: none;"><input type="submit" value="결제하기" id="moneybtn"></td>
				</tr>
			</table>		
	</form>
</div>
</body>
</html>