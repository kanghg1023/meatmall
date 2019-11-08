<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.basket_count {width:30px;}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function allSel(ele) {
	$("input[name=chk]").prop("checked", $(ele).prop("checked"));
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
	
	$("body").on("click",".bt_up",function(){
		var n = $(".bt_up").index(this);
	    var num = $(".basket_count:eq("+n+")").val();
	    num = $(".basket_count:eq("+n+")").val(num*1+1); 
	})
	$("body").on("click",".bt_down",function(){
		var n = $(".bt_down").index(this);
	    var num = $(".basket_count:eq("+n+")").val();
	    num = $(".basket_count:eq("+n+")").val(num*1-1); 
	})
	
});	
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>장바구니</h1>
<form action="delBasket.do" method="post">
<table border="1" class="table">
		<colgroup>
			<col width="50px" />
			<col width="80px" />
			<col width="*" />
			<col width="90px" />
			<col width="90px" />
		</colgroup>	
			<thead>
				<tr>
					<th scope="colgroup" colspan="4">상품정보</th>
					<th>상품금액</th>
					<th>배송비</th>
				</tr>
			</thead>
			<tr>
			<c:choose>
				<c:when test="${empty basketList}">
					<tr>
						<td colspan="10">----상품이 없습니다.----</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${basketList}" var="dto">
						<tr align="center">
							<td id="chk">
								<input type="checkbox" name="chk" value="${dto.option_num}" />
							</td>
							<td align="left" ><a href="goodsDetail.do?goods_num=${dto.goods_num}&pnum=${pnum}" ><img src="${dto.goods_img_title}" style="width:78px; height:78px;"></a></td>
							<td><a href="goodsDetail.do?goods_num=${dto.goods_num}&pnum=${pnum}" >${dto.goods_title} / ${dto.option_name} / ${dto.option_weight}</a>G</td>
							<td>
								${dto.goods_cost} <br>
								<img src="img/minus.png" alt="수량감소" width="10" height="10" class="bt_down" />
								<input type='hidden' name='option_num' class='option_num' value="${dto.option_num}" />
								<input type='text' name='basket_count' value='1' class='basket_count' />
								<img src='img/plus.png' alt='수량증가' width='10' height='10' class='bt_up'/>
							</td>
							<td>수량에 따른 합계</td>
							<td>무료</td>
						</tr>
					</c:forEach>
						<tr>
							<th>총 상품 가격</th>
							<td colspan="5">상품가격 00,000원 + 배송비 무료 = 주문금액 00,000원</td>
						</tr>
						<tr>
							<td colspan="6"><input type="submit" value="삭제" class="button"/></td>
						</tr>
				</c:otherwise>
			</c:choose>	
</table>
</form>
<body onload="init();">
<script language="JavaScript">

var sell_price;
var amount;

function init () {
	sell_price = document.form.sell_price.value;
	amount = document.form.amount.value;
	document.form.sum.value = sell_price;
	change();
}

function add () {
	hm = document.form.amount;
	sum = document.form.sum;
	hm.value ++ ;

	sum.value = parseInt(hm.value) * sell_price;
}

function del () {
	hm = document.form.amount;
	sum = document.form.sum;
		if (hm.value > 1) {
			hm.value -- ;
			sum.value = parseInt(hm.value) * sell_price;
		}
}

function change () {
	hm = document.form.amount;
	sum = document.form.sum;

		if (hm.value < 0) {
			hm.value = 0;
		}
	sum.value = parseInt(hm.value) * sell_price;
}  

</script>

<form name="form" method="get">
수량 : <input type=hidden name="sell_price" value="5500">
<input type="text" name="amount" value="1" size="3" onchange="change();">
<input type="button" value=" + " onclick="add();"><input type="button" value=" - " onclick="del();"><br>

금액 : <input type="text" name="sum" size="11" readonly>원
</form>
</body>
</html>