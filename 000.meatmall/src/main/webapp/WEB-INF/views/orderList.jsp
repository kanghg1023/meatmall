<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문목록/배송조회</title>
</head>
<body>
<jsp:include page="header.jsp" />
<c:if test="${ldto.user_role ne 'USER'}">
	<h3>판매 상품</h3>
	<table border="1" class="table">
		<tr>
			<td></td>
		</tr>
	</table>
</c:if>

<h3>구매한 상품</h3>
<table border="1" class="table">
	<c:choose>
		<c:when test="${empty olist}">
			<tr>
				<td>구매한 상품이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${olist}" var="dto">
				<tr>
					<td><img src="${dto.goods_img_title}" style="width:78px; height:78px;" /></td>
					<td>${dto.goods_title} / ${dto.option_name} / ${dto.order_count}개</td>
					<td>결제금액 : ${dto.order_money}</td>
					<td>주문일 : <fmt:formatDate value="${dto.order_date}" pattern="yyyy년MM월dd일"/></td>
					<c:choose>
						<c:when test="${dto.order_state eq 1}">
							<td>준비중</td>
						</c:when>
						<c:when test="${dto.order_state eq 2}">
							<td>배송중</td>
						</c:when>
						<c:when test="${dto.order_state eq 3}">
							<td>완료(후기X)</td>
						</c:when>
						<c:otherwise>
							<td>완료(후기O)</td>
						</c:otherwise>
					</c:choose>
				</tr>
			
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td></td>
	</tr>
</table>


</body>
</html>