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
	
	var detail_img_count = 1;
	
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
		
		//대표이미지 미리보기
		$("#goods_img_title").change(function(){
			   if(this.files && this.files[0]) {
			    var reader = new FileReader;
			    reader.onload = function(data) {
					$(".select_title_img img").attr("src", data.target.result).width(400);
					$(".select_title_img img").attr("src", data.target.result).height(380);  
			    }
			    reader.readAsDataURL(this.files[0]);
			   }
			  });
		
		//상세이미지 미리보기
		$("#goods_img_detail").change(function(){
			var preview = document.querySelector('#deImg');
			var files = document.querySelector('#goods_img_detail').files;
			var br = "<br />";
			preview.innerHTML = "";
			
			function readAndPreview(file) {
				var reader = new FileReader();
				
				reader.addEventListener("load", function () {
					var image = new Image();
					image.width = 800;
					image.height = 580;
					image.title = file.name;
					image.src = this.result;
					preview.appendChild( image );
					
					if(detail_img_count > 1){
						preview.innerHTML += br;
					}
				}, false);
				reader.readAsDataURL(file);
			}
			if (files) {
				[].forEach.call(files, readAndPreview);
			}
			
			detail_img_count++;
		});
	});
</script>
</head>
<body>

	<jsp:include page="header.jsp" />

<h1>상품 추가</h1>
<form action="insertGoods.do" method="post" enctype="multipart/form-data">
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
 				<label for="goods_img_title">대표이미지</label>
 				<input type="file" id="goods_img_title" name="title_file" />
 				<div class="select_title_img">
					<img src="" />
 				</div>
			</div>
		</td>
	</tr>
	<tr>
		<th>상품종류</th>
		<td>
			<c:if test="${!empty kList}" >
  				<select name="kind_num" style="width:80px;">
  					<option value="">부위 선택</option>
      				<c:forEach var="kList" items="${kList}" varStatus="i">
         				<option value="${kList.kind_num}">${kList.kind_name}</option>
      				</c:forEach>
   				</select>
   			</c:if>	
		</td>
	</tr>
	<tr>
		<th>상품이력번호</th>
		<td><input type="text" name="goods_history" /></td>
	</tr>
	<tr>
		<th>100g당 가격</th>
		<td><input type="text" name="goods_cost" /></td>
	</tr>
	<tr>
		<th>상세이미지</th>
		<td>
			<div class="inputArea">
 				<label for="goods_img_detail">상세이미지</label>
 				<input multiple="multiple" type="file" id="goods_img_detail" name="detail_file" />
 				<div class="select_detail_img" id="deImg"></div>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="목록" onclick="location.href='allGoods.do'" class="button"/>
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
<jsp:include page="footer.jsp" /> 
</body>
</html>