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
<style type="text/css">
.abcd{
	display: inline-block;
	margin-left: 60px;
}
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

<div class="ps-sidebar" data-mh="product-listing" style="text-align: center;">
	<aside class="ps-widget--sidebar ps-widget--category">
		<div class="ps-widget__header">
			<h3>상품 관리</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                
                <li class="abcd"><a href="myPage.do" class="myPage"><span>내 정보보기</span></a></li>
                <li class="abcd"><a href="orderList.do?user_num=${ldto.user_num}" class="category"><span>구매내역</span></a></li>
                <c:if test="${ldto.user_role ne 'USER'}">
                <li class="current abcd"><a href="selOrderList.do?user_num=${ldto.user_num}" class="category"><span>내 상품관리</span></a></li>
				</c:if>
                <li class="abcd"><a href="myboardlist.do?pnum=1" class="myboardlist"><span>내가 쓴 글 보기</span></a></li>
                <li class="abcd"><a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a></li>        
			</ul>
		</div>
	</aside>            
</div>

<c:if test="${ldto.user_role ne 'USER'}">
<div class="ps-products-wrap pt-80 pb-80" style="width:70%;margin: 0px 0px auto 15% ;">
	<h4 style="margin:-50px 0px -80px 0px;">배송대기중인 상품</h4>
	<table class="list-table">
		<tr>
			<th>상품명</th>
			<th>결제금액</th>
			<th>주문일</th>
			<th>상태</th>
		</tr>
		<c:choose>
			<c:when test="${empty dlist}">
				<tr>
					<td colspan="4">현재 배송 대기중인 상품이 없습니다.</td>
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
</div>
</c:if>
<c:if test="${ldto.user_role ne 'USER'}">
<div class="ps-products-wrap pt-80 pb-80" style="width:70%;margin: auto 0 auto 15% ;">
	<h4 style="margin:-50px 0px -80px 0px;">판매한 상품</h4>
	<table class="list-table">
		<tr>
			<th>상품명</th>
			<th>결제금액</th>
			<th>주문일</th>
			<th>상태</th>
		</tr>
		<c:choose>
			<c:when test="${empty slist}">
				<tr>
					<td colspan="4">판매한 상품이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${slist}" var="dto">
				<tr>
					<td><img src="${dto.goods_img_title}" style="width:78px; height:78px;" />
					${dto.goods_title} (${dto.option_name}) x ${dto.order_count}</td>
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
	</div>
</c:if>
<jsp:include page="footer.jsp" /> 
</body>
</html>