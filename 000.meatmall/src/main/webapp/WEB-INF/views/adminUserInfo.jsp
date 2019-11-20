<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<style type="text/css" media="screen">
.notice {
	color: red;
	text-decoration: none;
}

* {
    margin:0; padding:0

}



body {
        font-family: "Montserrat", sans-serif; font-size:0.75em; color:#333

}

.list-table {
    margin:100px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  text-align: center;
  padding:10px;               
}

.list-table th{
   height:40px;
   
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 17px;
}

.list-table td{
   text-align:left;
   padding:10px 0;
   border-bottom:1px solid #CCC; height:20px;
   font-size: 14px 
}



.list-table .buttonsignup {
    width: 16%;
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

.list-table .butt{
   text-align:right;
   padding:10px 0;
   border-bottom:1px solid #CCC; height:20px;
   font-size: 14px 
}

	
</style>
<script type="text/javascript">
	$(function(){
		$("#list").click(function(){
			location.href = "userAdmin.do";
		});
		
		$("#stop").click(function(){
			var user_enabled = $(this).next().val();
			
			if(user_enabled == 2){
				alert("이미 정지된 회원입니다.");
				return;
			}
			
			var isSubmit = confirm("해당 회원은 1분간 사용이 정지되며 정지된 기간이 지난후\n"
					+"해당유저가 정상적인 로그인을 진행하여야 해제됩니다."
					+"해당 회원을 정지하시겠습니까?");
			
			if(isSubmit){
				var user_num = $(this).prev().val();
				
				$.ajax({
					url:"userStop.do",
					data:{"user_num":user_num},
					method:"post",
					datatype:"json",
					async:false,
					success:function(isStop){
						if(isStop){
							location.reload();
						}else {
							alert("정지 실패오류");
						}
					},
					error:function(){
						alert("서버통신에러");
					}
				});
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="ps-sidebar" data-mh="product-listing" style="text-align: center;">
	<aside class="ps-widget--sidebar ps-widget--category">
		<div class="ps-widget__header">
			<h3>관리자페이지</h3>
		</div>
		<div class="ps-widget__content">
			<ul class="ps-list--checked">                 
                <li class="current abcd"><a href="userAdmin.do?pnum=1"><span>회원관리</span></a></li>
                <li class="abcd"><a href="category.do"><span>카테고리 관리</span></a></li>
                <li class="abcd"><a href="searchAdmin.do"><span>인기검색어 관리</span></a></li>
                <li class="abcd"><a href="adminCouponList.do?pnum=1"><span>쿠폰관리</span></a></li>
                <li class="abcd"><a href="bannerList.do?pnum=1"><span>배너관리</span></a></li>
			</ul>
		</div>
	</aside>            
</div>
<table class="list-table">
	<tr>
		<th>아이디</th>
		<td>${udto.user_id}</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${udto.user_name}</td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>${udto.user_nick}</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>${udto.user_ph}</td>
	</tr>
	<tr>
		<th>주소</th>
		<td>
			${udto.user_addr}<br>
			${udto.user_addr_detail}
		</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${udto.user_email}</td>
	</tr>
	<tr>
		<th>계정상태</th>
		<td>
			<c:choose>
				<c:when test="${udto.user_enabled == 1}">
					-
				</c:when>
				<c:otherwise>
					계정 정지
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<c:if test="${udto.user_stop_date != null}">
		<tr>
			<th>제재 기한</th>
			<td>
				<fmt:formatDate value="${udto.user_stop_date}" pattern="yy-MM-dd [hh:mm:ss]" /> 까지
			</td>
		</tr>
	</c:if>
	<tr>
		<td colspan="2" align="right" class="butt">
			<input type="hidden" value="${udto.user_num}" />
			<input type="button" id="stop" class="buttonsignup actionbutton" value="회원 정지"/>
			<input type="hidden" value="${udto.user_enabled}" />
			<input type="button" id="list" class="buttonsignup actionbutton" value="회원 목록"/>
		</td>
	</tr>
</table>
</body>
</html>