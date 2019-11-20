<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<style type="text/css">
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
     margin:20px auto 20px auto; 
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
   font-size: 14px;
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
</style>
<script type="text/javascript">
$(function(){
	
	$("#banner_img_name").change(function(){
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".select_title_img img").attr("src", data.target.result).width(400);
				$(".select_title_img img").attr("src", data.target.result).height(380);  
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	
	$("form").submit(function(){
		var isSubmit = confirm("배너 등록시 기본 7일동안 적용되며 먼저 등록된 배너가\n4장 이상 존재할경우 메인 화면에 표현되지 않을 수 있습니다.\n"
				+"배너를 등록하시겠습니까?");
		
		if(isSubmit){
			return true;
		}else{
			return false;
		}
	});
	
});

</script>
</head>
<body>
<jsp:include page="header.jsp" />
<form action="insertBanner.do" method="post" enctype="multipart/form-data">
<table class="list-table">
	<col width="120px" />
	<col width="550px" />
	<tr>
		<th>배너명</th>
		<td><input type="text" name="banner_name" class="inputval" /></td>
	</tr>
	<tr>
		<th>배너이미지</th>
		<td>
			<div class="inputArea">
 				<label for="banner_img_name">대표이미지</label>
 				<input type="file" id="banner_img_name" name="title_file" />
 				<div class="select_title_img">
					<img src="" />
 				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="목록" onclick="location.href='bannerList.do'" class="buttonsignup actionbutton"/>
			<input type="submit" value="등록" class="buttonsignup actionbutton"/>
		</td>
	</tr>
</table>
</form>
<jsp:include page="footer.jsp" />
</body>
</html>