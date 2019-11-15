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

body {
        font-family: "Montserrat", sans-serif; font-size:0.75em; color:#333

}

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



</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function allSel(ele) {
	$("input[name=chk]").prop("checked", $(ele).prop("checked"));
}

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
	

	$("body").on("click",".bt_up",function(){ 
		var num = $(this).prev();
		num.val(parseInt(num.val())+1);
		
		changeBcount(num);
	});
	$("body").on("click",".bt_down",function(){
		var num = $(this).next();
		if(num.val() == 1){
			return;
		}
		num.val(parseInt(num.val())-1);
		
		changeBcount(num);
	});
	
	$("body").on("change",".basket_count",function(){
		var num = $(this);
		changeBcount(num);
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
	
	$("body").on("click",".sumBtn",function(){
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
		
	});
	
	$(document).ready(function() {
		allSum();
	});
	
});

</script>
</head>
<body>

	<jsp:include page="header.jsp" />

<h1 style="text-align: center;">장바구니</h1>
<form action="delBasket.do" method="post">
<table  class="list-table">
		<colgroup>
			<col width="50px" />
			<col width="80px" />
			<col width="*" />
			<col width="90px" />
			<col width="90px" />
		</colgroup>	
			<thead>
				<tr>
					<td colspan="6"></td>
				</tr>
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
								<input type="text" name="basket_count" value="${dto.basket_count}" class="basket_count" />개
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
							<td colspan="6">
								총 상품가격 
								<strong class="totalSum"><fmt:formatNumber value="0" maxFractionDigits="0" /></strong><strong> 원</strong>
								+ 배송비 무료 = 주문금액
								<strong class="totalSum"><fmt:formatNumber value="0" maxFractionDigits="0" /></strong><strong> 원</strong>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<input type="button" value="구매하기" class="buttonsignup actionbutton" onclick="location.href='insertOrderForm.do?user_num=${ldto.user_num}'">
								<input type="submit" value="삭제" class="buttonsignup actionbutton"/>
							</td>
						</tr>
				</c:otherwise>
			</c:choose>	
</table>
</form>
<jsp:include page="footer.jsp" />
</body>
</html>
