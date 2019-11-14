<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function() {
	
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
			data:{"user_num":${ldto != null ? ldto.user_num : '0'}
			, "goods_num":"${gDto.goods_num}"
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
		var aCount = document.getElementById("optionSelect"); //onum
		var option = aCount.value.split(",");
		var atext = document.getElementById(option[0]);
		var optionChk = document.getElementsByName("option_num");
		var optionChoice = document.getElementById("optionChoice");
		var sum = document.getElementById("sum");
		
		for(var i=0;i<optionChk.length;i++){
			if(option[0] == optionChk[i].value){
				alert("이미 선택된 옵션입니다.");
				return;
			}
		}
		
		
		optionChoice.innerHTML += "<em>"+atext.text+"</em>"
		optionChoice.innerHTML += "<input type='hidden' name='option_num' class='option_num' value='"+option[0]+"' />";
		optionChoice.innerHTML += "<input type='hidden' name='option_weight' class='option_weight' value='"+option[1]+"' />";
		optionChoice.innerHTML += "<img src='img/minus.png' alt='수량감소' width='10' height='10' class='bt_down' />";
		optionChoice.innerHTML += "<input type='text' name='basket_count' value='1' class='basket_count' />";
		optionChoice.innerHTML += "<img src='img/plus.png' alt='수량증가' width='10' height='10' class='bt_up'/>";
		
		if(sum.value == ""){
			sum.value = 0;
		}
		
		sum.value = eval(sum.value)+(option[1]/100*${gDto.goods_cost});
	});
	
	$("body").on("click",".bt_up",function(){ 
		var num = $(this).prev();
		var weight = $(this).prev().prev().prev().val();
		num.val(parseInt(num.val())+1);
		var sum = $("#sum");
		
		sum.val(eval(sum.val())+(weight/100*${gDto.goods_cost}));
	});
	
	$("body").on("click",".bt_down",function(){
		var num=$(this).next();
		if(num.val() == 1){
			return;
		}
		var weight = $(this).prev().val();
		num.val(parseInt(num.val())-1);
		var sum = $("#sum");
		
		sum.val(eval(sum.val())-(weight/100*${gDto.goods_cost}));
	});
	
	
});	
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>상품 상세</h1>
<form action="insertOrderForm.do" method="post">
	<input type="hidden" name="user_num" value="${ldto.user_num}" />
	<input type="hidden" name="goods_num" value="${gDto.goods_num}" />
	<div>
		<table border="1">
			<col width="150px" />
			<col width="400px" />
			<tr>
				<td colspan="2">
					<input type="button" onclick="location.href='upGoodsForm.do?goods_num=${gDto.goods_num}'" value="수정" />
					<input type="button" onclick="location.href='delAllGoods.do?chk=${gDto.goods_num}&pnum=${pnum}'" name="delBtn" value="삭제" />
				</td>
			</tr>
			<tr>
				<th>대표이미지</th>
				<td><img src="${gDto.goods_img_title}" style="width:400px; height:380px;" ></td>
			</tr>
			<tr>
				<th>판매자</th>
				<td>${gDto.user_nick}</td>
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
						<c:forEach items="${oList}" var="dto">
							<option id="${dto.option_num}" value="${dto.option_num},${dto.option_weight}">${dto.option_name}</option>
						</c:forEach>
					</select>
				</td>	
			</tr>
			<tr>
				<th>합계</th>
				<td>
					<input type="text" id="sum" name="sum" size="11" readonly>원
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" id="buy" value="바로구매" />
						<input type="button" id="basket" value="장바구니" />
						<input type="button" 
						onclick="window.open
						('https://www.mtrace.go.kr/mtracesearch/cattleNoSearch.do?btsProgNo=0109008401&btsActionMethod=SELECT&cattleNo=002117250633'
						,'beef traceability system','width=800px,height=900px,location=no,status=no,scrollbars=no')" value="축산물이력정보" />
						<input type="button" onclick="location.href='allGoods.do?pnum=${pnum}'" value="제품목록" />
				</td>
			<tr>
				<th>상세이미지</th>
				<td>${gDto.goods_img_detail}</td>
			</tr>	
		</table>
	</div>
	<div id="optionChoice">
		
	</div>
</form>
<div id="reviewForm">
	<table border="1" class="reviewTable">
		<c:if test="${rList != null}">
			<c:forEach items="${rList}" var="rlist">
			<tr>
				<td>${rlist.user_id}</td>
				<td colspan="2">
					<fmt:formatDate value="${rlist.review_date}" pattern="yyyy-MM-dd HH:mm"/>
					<c:if test="${rlist.user_id eq ldto.user_id}">
						<button type="button" onclick="delReview(${rlist.review_num})">삭제</button>
						<button type="button" class="upReview" value="${rlist.review_num}">수정</button>
					</c:if>
					${rlist.review_score}
				</td>
			</tr>
			<tr style="white-space:pre;">
				<td colspan="3" class="conSel">${rlist.review_content}</td>
			</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
</body>
</html>