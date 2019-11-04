<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<style type="text/css">
	.select_img img {margin:20px;}
</style>
<script type="text/javascript">

	$(function(){
		
		//필수 입력
		$("form").submit(function(){
			var bool = true;
			var input = $(this).find("td").children().filter("[name]");
			input.each(function(i){
				if($(this).val()==""){
					alert($(this).parent().prev().text()+"를 입력하세요");
					$(this).focus();
					bool = false;
					return false;
				}
			});
			return bool;
		});
		
		//옵션 추가
		$("#asd").click(function(){
			var aCount = $("#asd");
			aCount.parent().parent().before( "<tr>"
												+"<th>옵션 이름</th>"
												+"<td><input type='text' name='option_name' /></td>"
											+"</tr>"
											+"<tr>"
												+"<th>재고</th>"
												+"<td><input type='text' name='option_count' /></td>"
											+"</tr>"
											+"<tr>"
												+"<th>무게(g)</th>"
												+"<td><input type='text' name='option_weight' /></td>"
											+"</tr>");
			
		});
		
		//이미지 미리보기
		$("#gdsImg").change(function(){
			   if(this.files && this.files[0]) {
			    var reader = new FileReader;
			    reader.onload = function(data) {
			     $(".select_img img").attr("src", data.target.result).width(500);        
			    }
			    reader.readAsDataURL(this.files[0]);
			   }
			  });
	});
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<h1>상품 수정</h1>
<form action="upGoods.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="goods_num" value="${gDto.goods_num}"/>
<table border="1" class="table">
	<tr>
		<th>상품명</th>
		<td><input type="text" name="goods_title" class="inputval" value="${gDto.goods_title}" /></td>
	</tr>
	<tr>
		<th>판매자</th>
		<td>
			<input type="text" name="user_num" class="inputval" value="${gDto.user_num}" />
		</td>
	</tr>
	<tr>
		<th>도소매구분</th>
		<td>
			<select name="goods_doso">
				<option value="DO">도매</option>
				<option value="SO">소매</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>대표이미지</th>
		<td>
			<div class="inputArea">
 				<label for="gdsImg">이미지</label>
 				<input type="file" id="gdsImg" name="file" />
 				<div class="select_img">
 				<img src="${gDto.goods_img_title}" />
 				</div>
			</div>
		</td>
	</tr>
	<tr>
		<th>상품종류</th>
		<td>
			<c:if test="${!empty kList}" >
  				<select name="kind_num" style="width:80px;">
      				<c:forEach var="kList" items="${kList}" varStatus="i">
         				<option value="${kList.kind_num}">${kList.kind_name}</option>
      				</c:forEach>
   				</select>
   			</c:if>	
		</td>
	</tr>
	<tr>
		<th>상품이력번호</th>
		<td><input type="text" name="goods_history" placeholder="12자리" value="${gDto.goods_history}"/></td>
	</tr>
	<tr>
		<th>100g당 가격</th>
		<td><input type="text" name="goods_cost" value="${gDto.goods_cost}"/></td>
	</tr>
	<tr>
		<th>상세이미지 이름</th>
		<td><input type="text" name="goods_img_detail" value="${gDto.goods_img_detail}"/></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="수정취소" onclick="location.href='goodsDetail.do?goods_num=${gDto.goods_num}'" class="button"/>
			<input type="submit" value="완료" class="button"/>
		</td>
	</tr>
</table>
<table border="1" class="table">
	<c:forEach items="${oDto}" var="dto">
	<tr>
		<th>옵션 이름</th>
		<td>
			<input type="text" name="option_name" value="${dto.option_name}" />
			<input type="hidden" name="option_num" value="${dto.option_num}" />
		</td>
	</tr>
	<tr>
		<th>재고</th>
		<td><input type="text" name="option_count" value="${dto.option_count}" /></td>
	</tr>
	<tr>
		<th>무게(g)</th>
		<td><input type="text" name="option_weight" value="${dto.option_weight}" /></td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="2">
			<input type="button" value="추가" id="asd" class="button"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>