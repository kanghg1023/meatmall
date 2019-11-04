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
<h1>상품 추가</h1>
<form action="insertCateGoods.do" method="post" enctype="multipart/form-data">
<table border="1" class="table">
	<tr>
		<th>상품명</th>
		<td><input type="text" name="goods_title" class="inputval" /></td>
	</tr>
	<tr>
		<th>판매자</th>
		<td><input type="text" name="user_num" value="${ldto.user_num}" /></td>
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
 				<img src="" />
 				</div>
			</div>
		</td>
	</tr>
	<tr>
		<th>상품종류</th>
		<td><input type="text" name="kind_num" value="${kind_num}" class="inputval" /></td>
	</tr>
	<tr>
		<th>상품이력번호</th>
		<td><input type="text" name="goods_history" class="inputval" /></td>
	</tr>
	<tr>
		<th>100g당 가격</th>
		<td><input type="text" name="goods_cost" class="inputval" /></td>
	</tr>
	<tr>
		<th>상세이미지</th>
		<td><input type="text" name="goods_img_detail" class="inputval" /></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="목록" onclick="location.href='categoryGoods.do?kind_num=${kind_num}'" class="button"/>
			<input type="submit" value="완료" class="button"/>
		</td>
	</tr>
</table>
<table border="1" class="table">
	<tr>
		<th>옵션 이름</th>
		<td><input type="text" name="option_name" /></td>
	</tr>
	<tr>
		<th>재고</th>
		<td><input type="text" name="option_count" /></td>
	</tr>
	<tr>
		<th>무게(g)</th>
		<td><input type="text" name="option_weight" /></td>
	</tr>
	<tr>
		<td>
			<input type="button" value="추가" id="asd" class="button"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>