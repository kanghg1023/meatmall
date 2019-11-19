<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
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

<form action="insertBanner.do" method="post" enctype="multipart/form-data">
<table border="1" class="table">
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
			<input type="button" value="목록" onclick="location.href='bannerList.do'" class="button"/>
			<input type="submit" value="등록" class="button"/>
		</td>
	</tr>
</table>
</form>

</body>
</html>