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
			<col width="30px" />
			<col width="600px" />
			<col width="100px" />
			<col width="100px" />
			<tr>
				<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
				<th>상품정보</th>
				<th>상품금액</th>
				<th>배송비</th>
			</tr>
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
							<td>${dto.goods_num} ${dto.option_num} ${dto.basket_count}</td>
						</tr>
					</c:forEach>
						<tr>
							<th>총 상품 가격</th>
							<td colspan="3">상품가격 00,000원 + 배송비 무료 = 주문금액 00,000원</td>
						</tr>
						<tr>
							<td colspan="4"><input type="submit" value="삭제" class="button"/></td>
						</tr>
				</c:otherwise>
			</c:choose>	
</table>
</form>
</body>
</html>