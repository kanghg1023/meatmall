<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
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
	
	
	$("#basket").click(function() {
		if($("#optionSelect").val() == "") {
			alert("옵션을 선택해주세요!");
			return false;
		}
		
		var option_num = $(".option_num").get();
		var basket_count = $(".basket_count").get();
		
		alert(basket_count[0].value+","+option_num[0].value);
		
		var optionArray = [];
		var countArray = [];
        
        $(option_num).each(function(i){//체크된 리스트 저장
        	optionArray.push($(this).val());
        });
        
        $(basket_count).each(function(i){//체크된 리스트 저장
        	countArray.push($(this).val());
        });
        
		$.ajax({
			url:"insertBasket.do",
			data:{"user_num":${ldto.user_num}
			, "goods_num":${gDto.goods_num}
			, "option_num":optionArray
			, "basket_count":countArray},
			method:"post",
			datatype:"json",
			async:false,
			success:function(isInsert){
				if(isInsert){
					alert("추가했습니다.");
				}else {
					alert("추가실패");
				}
			},
			error:function(){
				alert("서버통신실패!!");
			}
		});
	});
	
	$("#buy").click(function(){
		if($("#optionSelect").val() == "") {
			alert("옵션을 선택해주세요!");
			return false;
		}
	});
	
	$("#optionSelect").change(function(){
		var aCount = document.getElementById("optionSelect");
		var atext = document.getElementById(aCount.value);
		var optionChk = document.getElementsByName("option_num");
		var optionChoice = document.getElementById("optionChoice");
		
		for(var i=0;i<optionChk.length;i++){
			if(aCount.value == optionChk[i].value){
				alert("이미 선택된 옵션입니다.");
				return;
			}
		}
		optionChoice.innerHTML += "<em>"+atext.text+"</em>"
		optionChoice.innerHTML += "<input type='hidden' name='option_num' class='option_num' value='"+aCount.value+"' />"
		optionChoice.innerHTML += "<input type='text' name='basket_count' class='basket_count' value='1' />"
		
	});
	
});	
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>상품 상세</h1>
<div>
<table border="1">
	<col width="150px" />
	<col width="400px" />
	<tr>
		<td colspan="2">
			<button onclick="location.href='upGoodsForm.do?goods_num=${gDto.goods_num}'">수정</button>
			<button onclick="location.href='delCateGoods.do?chk=${gDto.goods_num}&kind_num=${gDto.kind_num}&pnum=${pnum}'">삭제</button>
		</td>
	</tr>
	<tr>
		<th>대표이미지</th>
		<td><img src="${gDto.goods_img_title}" style="width:400px; height:380px;" ></td>
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
			<select id="optionSelect">
				<option value="">옵션 선택</option>
				<c:forEach items="${oList}" var="olist">
					<option id="${olist.option_num}" value="${olist.option_num}">${olist.option_name}</option>
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
			<button id="buy" onclick="">바로구매</button>
				<button id="basket">장바구니</button>
				<button 
				onclick="window.open
				('https://www.mtrace.go.kr/mtracesearch/cattleNoSearch.do?btsProgNo=0109008401&btsActionMethod=SELECT&cattleNo=002117250633'
				,'beef traceability system','width=800px,height=900px,location=no,status=no,scrollbars=no')">축산물이력정보</button>
				<button onclick="location.href='categoryGoods.do?pnum=${pnum}&kind_num=${gDto.kind_num}'">제품목록</button>
	<tr>
		<th>상세이미지</th>
		<td>${gDto.goods_img_detail}</td>
	</tr>
	<tr>
		<th>후기</th>
		<td><textarea rows="10" cols="60" readonly="readonly">쩔어요~~</textarea></td>
	</tr>
</table>
</div>
<div id="optionChoice">
	
</div>
</body>
</html>