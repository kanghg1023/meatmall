<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>주문목록/배송조회</title>
<script type="text/javascript">

	$(function(){
		$(".stateUpdate").click(function(){
			var order_num = $(this).next().val();
			location.href="stateUpdate.do?order_num="+order_num;
		});
		
		$(".reviewForm").click(function(){
			var order_num = $(this).next().val();
			location.href="reviewForm.do?order_num="+order_num;
		});
		
	});
	
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<h3>구매한 상품</h3>
<table border="1" class="table">
	<tr>
		<td colspan="2">상품명</td>
		<td>결제금액</td>
		<td>주문일</td>
		<td>상태</td>
	</tr>
	<c:choose>
		<c:when test="${empty olist}">
			<tr>
				<td colspan="5">구매한 상품이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${olist}" var="dto">
				<tr>
					<td><img src="${dto.goods_img_title}" style="width:78px; height:78px;" /></td>
					<td>${dto.goods_title} / ${dto.option_name} / ${dto.order_count}개</td>
					<td>
						<fmt:formatNumber value="${dto.order_money}" maxFractionDigits="0" /> 원
					</td>
					<td><fmt:formatDate value="${dto.order_date}" pattern="yyyy년MM월dd일"/></td>
					<c:choose>
						<c:when test="${dto.order_state == 1}">
							<td>준비중</td>
						</c:when>
						<c:when test="${dto.order_state == 2}">
							<td>배송중
								<input type="button" class="stateUpdate" value="상품수령" />
								<input type="hidden" value="${dto.order_num}" />
							</td>
						</c:when>
						<c:when test="${dto.order_state == 3}">
							<td>배송완료
								<input type="button" class="reviewForm" value="후기작성" />
								<input type="hidden" value="${dto.order_num}" />
							</td>
						</c:when>
						<c:otherwise>
							<td>완료(후기O)</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>