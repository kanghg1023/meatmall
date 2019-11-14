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
	
	$("#coupon_img").change(function(){
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".select_title_img img").attr("src", data.target.result).width(400);
				$(".select_title_img img").attr("src", data.target.result).height(380);  
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
	
});

</script>
</head>
<body>

<form action="insertCoupon.do" method="post" enctype="multipart/form-data">
<table border="1" class="table">
	<tr>
		<th>쿠폰명</th>
		<td><input type="text" name="coupon_name" class="inputval" /></td>
	</tr>
	<tr>
		<th>쿠폰이미지</th>
		<td>
			<div class="inputArea">
 				<label for="coupon_img">대표이미지</label>
 				<input type="file" id="coupon_img" name="title_file" />
 				<div class="select_title_img">
					<img src="" />
 				</div>
			</div>
		</td>
	</tr>
	<tr>
		<th>할인 금액</th>
		<td><input type="text" name="coupon_money" /></td>
	</tr>
	<tr>
		<th>기간</th>
		<td><input type="text" name="coupon_period" /></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="목록" onclick="location.href='adminCouponList.do'" class="button"/>
			<input type="submit" value="완료" class="button"/>
		</td>
	</tr>
</table>
</form>

</body>
</html>