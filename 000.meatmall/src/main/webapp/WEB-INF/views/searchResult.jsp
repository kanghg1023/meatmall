<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style type="text/css" media="screen">

.list-table {
    margin:0px auto 50px auto;
}

.list-table, .list-table th , .list-table td{         

  padding:10px;
                 
}

.list-table th{
   height:40px;
   
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 17px;
   
}
.list-table td{
   
   padding:15px 0;
   border-bottom:1px solid #2AC37D; height:20px;
   font-size: 14px
   
    
}

</style>

</head>
<body>
<jsp:include page="header.jsp" />

<h3 style="text-align: center;">"${search_word}" 검색 결과입니다.</h3>

<h4 style="text-align: center;">카테고리</h4>
<table class="list-table">
	<c:choose>
		<c:when test="${empty caList}">
			<tr>
				<td>결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${caList}" var="dto">
				<tr>
					<td><a href="allGoods.do?kind_num=${dto.kind_num}">${dto.kind_name}</a></td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<h4 style="text-align: center;">상품</h4>
<table class="list-table">
	<c:choose>
		<c:when test="${empty goodsList}">
			<tr>
				<td>결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${goodsList}" var="dto">
				<tr>
					<td><img src="${dto.goods_img_title}"  style="width:250px; height:230px;" ></td>
					<td><a href="goodsDetail.do?goods_num=${dto.goods_num}&pnum=${pnum}">${dto.goods_title}</a></td>
					<td>${dto.goods_cost}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<h4 style="text-align: center;">게시판</h4>
<table class="list-table">
	<c:choose>
		<c:when test="${empty bList}">
			<tr>
				<td>결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${bList}" var="dto">
				<tr>
					<td><a href="boarddetail.do?board_num=${dto.board_num}">${dto.board_title}</a></td>
					<td>${dto.user_nick}</td>
					<td>${dto.board_content}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<jsp:include page="footer.jsp" /> 
</body>
</html>