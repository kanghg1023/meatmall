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

<style type="text/css" media="screen">

.list-table {
    margin:100px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  padding:10px;
                 
}

.list-table th{
   height:40px;
   border-top:2px solid #2AC37D;
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 17px;
   
}
.list-table td{
   
   padding:15px 0;
   border-bottom:1px solid #2AC37D; height:20px;
   font-size: 14px
   
    
}

.buttonsignup {
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

.actionbutton {
	margin-top:0%;
}
</style>

</head>
<body>
<jsp:include page="header.jsp" />
	<table class="list-table">
	<col width="300px" />
	<col width="100px" />
		<tr>
			<td align="left" ><img src="${odto.goods_img_title}" style="width:300px; height:300px;"></td>
			<td>${odto.goods_title}<br />(${odto.option_name})</td>
		</tr>
	</table>
	<form action="addReview.do" method="post">
		<input type="hidden" name="order_num" value="${odto.order_num}" />
		<input type="hidden" name="goods_num" value="${odto.goods_num}" />
		<input type="hidden" name="user_num" value="${odto.order_seller}" />
		<input type="hidden" name="user_id" value="${ldto.user_id}" />
		<div class="row">
			<div>
				<div class="form-group" style="text-align: center;">
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
			<div>
				<div class="form-group" style="text-align: center;">
					<label>리뷰 내용</label>
					<textarea class="form-control" name="review_content" rows="6"  style="width: 50%; margin: auto;"></textarea>
				</div>
				<div class="form-group" style="text-align: center;">
					<input type="submit" value="등록" id="btn" class="buttonsignup actionbutton"/>
				</div>
			</div>
		</div>
	</form>
</body>
</html>