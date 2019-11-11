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
		var num = $(this).prev();
		num.val(parseInt(num.val())+1);
		var sell_price = $(this).parent().next("td").find(".fmtNum");
		alert(sell_price.val());
		
		var sum = $(this).parent().next().find(".sum");
		var a = sum.html().replace(",","").replace(",","");
		var b = sell_price.val().replace(",","");
		var ab = (eval(a)+eval(b));
		sum.html(ab.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
// 		sum.val(eval(sum.val())+sell_price.val();
	});
	$("body").on("click",".bt_down",function(){
		var num=$(this).parent().find(".basket_count");
		num.val(parseInt(num.val())-1);
		var sell_price=$(this).parent().next("td").find("input[name=sell_price]").val();
		$(this).parent().next("td").find("input[name=sum]").val(sell_price*num.val());
	})
	
// 	var asd = $("#asd");
// 	var qwe = asd.html().replace(",","");
// 	b = 기존+얼마
// 	var zxc = eval(qwe)+123;
//  	var aaa = b.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// 	a.html(aaa);
// 	asd.html(aaa);
// 	alert(eval(qwe)+154);
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
								<input type="hidden" name="option_num" class="option_num" value="${dto.option_num}" />
								<input type="hidden" name="option_weight" class="option_weight" value="${dto.option_weight}" />
								<img src="img/minus.png" alt="수량감소" width="10" height="10" class="bt_down" />
								<input type="text" name="basket_count" value="${dto.basket_count}" class="basket_count" />
								<img src="img/plus.png" alt="수량증가" width="10" height="10" class="bt_up"/>
							</td>
							<td>
								<input type="hidden" class="fmtNum" name="sum" value="<fmt:formatNumber value="${(dto.option_weight/100*dto.goods_cost)}" maxFractionDigits="0" />" />
								<strong class="sum"><fmt:formatNumber value="${(dto.option_weight/100*dto.goods_cost)*dto.basket_count}" maxFractionDigits="0" /></strong><strong> 원</strong>
							</td>
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
</body>
</html>
