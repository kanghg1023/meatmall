<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h1>상품 상세</h1>
<div> 
<table border="1">
	<col width="150px" />
	<col width="400px" />
	<tr>
		<td colspan="2">
			<button onclick="location.href='upGoodsForm.do?goods_num=${gDto.goods_num}'">수정</button>
			<button onclick="location.href='delAllGoods.do?chk=${gDto.goods_num}&pnum=${pnum}'" name="delBtn">삭제</button>
		</td>
	</tr>
	<tr>
		<th>대표이미지 이름</th>
		<td><img src="${gDto.goods_img_title}" ></td>
	</tr>
	<tr>
		<th>판매자</th>
		<td>${gDto.user_num}</td>
	</tr>
	<tr>
		<th>상품이름</th>
		<td>${gDto.goods_title}</td>
	</tr>
	<tr>
		<th>100g당 가격</th>
		<td>${gDto.goods_cost}</td>
	</tr>
	<tr>
		<th>옵션</th>
		<td>
			<select>
				<c:forEach items="${oDto}" var="dto">
					<option>${dto.option_name}</option>
				</c:forEach>
			</select>
		</td>	
	</tr>
	<tr>
		<th>합계</th>
		<td>
			더해진 값 올꺼임
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<button onclick="">바로구매</button>
			<button onclick="">장바구니</button>
			<button 
				onclick="window.open
				('https://www.mtrace.go.kr/mtracesearch/cattleNoSearch.do?btsProgNo=0109008401&btsActionMethod=SELECT&cattleNo=002117250633'
				,'beef traceability system','width=800px,height=900px,location=no,status=no,scrollbars=no')">축산물이력정보</button>
			<button onclick="location.href='allGoods.do?pnum=${pnum}'">제품목록</button>
		</td>
	</tr>
	<tr>
		<th>상품 상세보기</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${iDto.detail_img_name}</textarea></td>
	</tr>
	<tr>
		<th>후기</th>
		<td><textarea rows="10" cols="60" readonly="readonly">쩔어요~~</textarea></td>
	</tr>	
</table>	
</div>
</body>
</html>