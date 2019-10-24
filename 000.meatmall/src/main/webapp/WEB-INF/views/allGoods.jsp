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
<script type="text/javascript">
function allSel(ele) {
	$("input[name=chk]").prop("checked", $(ele).prop("checked"));
}

$(function() {
	$("#pmoveBtn").click(function() {
		var pNum = $("#pmove").val();
		var endPage = ${map.endPage};
		if(pNum > endPage){
			pNum = endPage;
		}
		location.href = "BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum="+pNum;
	});
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
<h1>전체 상품</h1>
	<form action="BoardController.do" method="post">
		<input type="hidden" name="command" value="muldel" />
			<table border="1" class="table">
				<col width="30px" />
				<col width="70px" />
				<col width="300px" />
				<col width="60px" />
				<col width="90px" />
				<col width="120px" />
				<col width="100px" />
				<tr>
					<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
					<th>상품번호</th>
					<th>상품이름</th>
					<th>판매자</th>
					<th>도소매 구분</th>
					<th>대표이미지이름</th>
					<th>100g당 가격</th>
				</tr>
				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="10">----상품이 없습니다.----</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="dto">
							<tr align="center">
								<td id="chk"><c:if test="${dto.user_num == ldto.user_num}">
										<input type="checkbox" name="chk" value="${dto.goods_num}" />
									</c:if></td>
								<td>${dto.goods_num}</td>
								<c:choose>
									<c:when test="${dto.goods_enabled eq 'N'}">
										<td id="goods1">----삭제된 상품입니다.----</td>
									</c:when>
									<c:otherwise>
										<td align="left" id="goods2">
											<a href="goodsdetail.do?goods_num=${dto.goods_num}">${dto.goods_title}</a>
										</td>
									</c:otherwise>
								</c:choose>
<!-- 								나중에 닉네임으로 바꿔 -->
								<td id="nick">${dto.user_num}</td>
<%-- 									<jsp:setProperty property="emailNick" name="util" value="${dto.email}" /> --%>
<%-- 									<jsp:getProperty property="emailNick" name="util" /> --%>
								
								<td id="DOSO">${dto.goods_doso}</td>
								<td id="img_title">${dto.goods_img_title}</td>
								<td id="cost">${dto.goods_cost}</td>
							</tr>
						</c:forEach>
<!-- 						<tr> -->
<!-- 							<td colspan="6" align="center"> -->
<%-- 								<a href="allgoods.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${map.prePageNum}">◀</a> --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${pNum==null || pNum==''}"> --%>
<!-- 										<input type="text" id="pmove" value="1" /> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<%-- 										<input type="text" id="pmove" value="${pNum}" /> --%>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
<%-- 								&nbsp;/&nbsp;${map.endPage} --%>
<%-- 								<a href="BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${map.nextPageNum}">▶</a> --%>
<!-- 								<input type="button" id="pmoveBtn" value="이동" /> -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</c:otherwise>
				</c:choose>
				<c:if test="${ldto.user_role eq 'ADMIN'}">
				<tr>
					<td colspan="7">
						<input type="button" value="상품추가" onclick="location.href='insertGoodsForm.do'" />
						<input type="submit" value="상품삭제" />
					</td>
				</tr>
				</c:if> 
			</table>
	</form>
</body>
</html>