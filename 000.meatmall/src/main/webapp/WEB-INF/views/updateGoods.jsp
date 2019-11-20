<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<style type="text/css">
	.select_img img {width:500px; margin:20px;}
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

<style type="text/css">
	.select_img img {margin:20px;}
	

.inputArea label { 
	display: inline-block;
	padding: .5em .75em; 
	color: #fff; 
	font-size: inherit; 
	
	line-height: normal; 
	vertical-align: middle; 
	background-color: #2AC37D; 
	cursor: pointer; 
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
}

.inputArea input[type="file"] {
 /* 파일 필드 숨기기 */ 
 	position: absolute;
 	width: 1px; 
 	height: 1px; 
 	padding: 0; 
 	margin: -1px; 
 	overflow: hidden; 
 	clip:rect(0,0,0,0); 
 	border: 0; 
}

.list-table {
    margin:0px auto 0px auto;
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

.list-table .buttonsignup {
    width: 80px;
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

/*  */

.list-table2 {
    margin:0px 50% 0px auto;
}

.list-table2, .list-table2 th , .list-table2 td{         

  padding:10px;
                 
}

.list-table2 th{
   height:40px;
   
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 17px;
   
}

.list-table2 td{
   
   padding:15px 0;
   border-bottom:1px solid #2AC37D; height:20px;
   font-size: 14px
   
    
}

.list-table2 .buttonsignup {
    width: 80px;
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

.list-table2 .actionbutton {
	margin-top:0%;
}

input{
    width: 100%;
    
}
	
</style>

</head>
<body>

	<jsp:include page="header.jsp" />

<h1 style="text-align: center;">상품 수정</h1>
<form action="upGoods.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="goods_num" value="${gdto.goods_num}"/>
<input type="hidden" name="user_num" value="${gdto.user_num}"/>
<table class="list-table">
	<col width="150px" />
	<col width="400px" />
	<tr>
		<th>상품명</th>
		<td><input type="text" name="goods_title" class="inputval" value="${gdto.goods_title}" /></td>
	</tr>
	<tr>
		<th>대표이미지</th>
		<td>
			<div class="inputArea">
 				<label for="goods_img_title">대표이미지</label>
 				<input type="file" id="goods_img_title" name="title_file" />
 				<div class="select_img"><img src="${gdto.goods_img_title}" /></div>
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
		<td><input type="text" name="goods_history" placeholder="12자리" value="${gdto.goods_history}"/></td>
	</tr>
	<tr>
		<th>100g당 가격</th>
		<td><input type="text" name="goods_cost" value="${gdto.goods_cost}"/></td>
	</tr>
	<tr>
		<th>상세이미지</th>
		<td>
			<div class="inputArea">
 				<label for="goods_img_detail">상세이미지</label>
 				<input multiple="multiple" type="file" id="goods_img_detail" name="detail_file" />
 				<div class="select_detail_img" id="deImg">${gdto.goods_img_detail}</div>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="수정취소" onclick="location.href='goodsDetail.do?goods_num=${gdto.goods_num}'" class="buttonsignup actionbutton"/>
			<input type="submit" value="완료" class="buttonsignup actionbutton"/>
		</td>
	</tr>
</table>
<table class="list-table2">
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
			<input type="button" value="추가" id="asd" class="buttonsignup actionbutton"/>
		</td>
	</tr>
</table>
</form>
<br/><br/>
<jsp:include page="footer.jsp" /> 
</body>
</html>