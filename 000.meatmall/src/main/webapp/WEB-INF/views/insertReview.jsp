<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %> <!-- 요청할때 utf-8로 -->
<%response.setContentType("text/html; charset=UTF-8"); %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>리뷰작성</title>
</head>
<body>
	<table border="1">
		<tr>
			<td align="left" ><img src="${odto.goods_img_title}" style="width:78px; height:78px;"></td>
			<td>${odto.goods_title}<br />(${odto.option_name})</td>
		</tr>
	</table>
	<form action="addReview.do" method="post">
		<input type="hidden" name="order_num" value="${odto.order_num}" />
		<input type="hidden" name="goods_num" value="${odto.goods_num}" />
		<input type="hidden" name="user_num" value="${odto.order_seller}" />
		<input type="hidden" name="user_id" value="${ldto.user_id}" />
		<div class="row">
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 ">
				<div class="form-group">
					<label>별점<span></span></label>
					<select class="ps-rating" name="review_score">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
			</div>
			<div class="col-lg-8 col-md-8 col-sm-6 col-xs-12 ">
				<div class="form-group">
					<label>리뷰 내용</label>
					<textarea class="form-control" name="review_content" rows="6"></textarea>
				</div>
				<div class="form-group">
					<input type="submit" value="등록" id="btn" class="ps-btn ps-btn--sm"/>
				</div>
			</div>
		</div>
	</form>
</body>
</html>