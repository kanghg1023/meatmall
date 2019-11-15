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
<title>판매목록/판매관리</title>
<script type="text/javascript">

	$(function(){
		$(".stateUpdate").click(function(){
			var order_num = $(this).next().val();
			location.href="stateUpdate.do?order_num="+order_num;
		});
	});
	
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<c:if test="${ldto.user_role ne 'USER'}">
	<h3>배송대기중인 상품</h3>
	<table border="1" class="table">
		<tr>
			<td colspan="2">상품명</td>
			<td>결제금액</td>
			<td>주문일</td>
			<td>상태</td>
		</tr>
		<c:choose>
			<c:when test="${empty dlist}">
				<tr>
					<td>현재 배송 대기중인 상품이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${dlist}" var="dto">
				<tr>
					<td><img src="${dto.goods_img_title}" style="width:78px; height:78px;" /></td>
					<td>${dto.goods_title} (${dto.option_name}) x ${dto.order_count}</td>
					<td>
						<fmt:formatNumber value="${dto.order_money}" maxFractionDigits="0" /> 원
					</td>
					<td><fmt:formatDate value="${dto.order_date}" pattern="yyyy년MM월dd일"/></td>
					<td>준비중
						<input type="button" class="stateUpdate" value="상품발송" />
						<input type="hidden" value="${dto.order_num}" />
					</td>
				</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</c:if>
<c:if test="${ldto.user_role ne 'USER'}">
	<h3>판매한 상품</h3>
	<table border="1" class="table">
		<tr>
			<td colspan="2">상품명</td>
			<td>결제금액</td>
			<td>주문일</td>
			<td>상태</td>
		</tr>
		<c:choose>
			<c:when test="${empty slist}">
				<tr>
					<td>판매한 상품이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${slist}" var="dto">
				<tr>
					<td><img src="${dto.goods_img_title}" style="width:78px; height:78px;" /></td>
					<td>${dto.goods_title} (${dto.option_name}) x ${dto.order_count}</td>
					<td>
						<fmt:formatNumber value="${dto.order_money}" maxFractionDigits="0" /> 원
					</td>
					<td><fmt:formatDate value="${dto.order_date}" pattern="yyyy년MM월dd일"/></td>
					<c:choose>
						<c:when test="${dto.order_state == 2}">
							<td>배송중</td>
						</c:when>
						<c:otherwise>
							<td>배송완료</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</c:if>
<jsp:include page="footer.jsp" /> 
</body>
</html>