<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>비밀번호 찾기</title>
<script type="text/javascript">
	$(function(){
		$("form").submit(function(){
			var user_id = $("#user_id").val();
			var user_email = $("#user_email").val();
			var submit;
			
			$.ajax({
				url:"inquiryChk.do",
				data:{"user_id":user_id
					,"user_email":user_email},
				method:"post",
				datatype:"json",
				async:false,
				success:function(isChk){
					if(isChk){
						submit = true;
					}else{
						alert("정보를 확인해주세요.");
						submit = false;
					}
				},
				error:function(){
					alert("서버통신에러: 관리자에게 문의주세요");
				}
			});
			return submit;
		});
	});
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="inquiryHeader.jsp" />
</div>
<h2>비밀번호 찾기</h2>
<c:choose>
	<c:when test="${pwSuccess == null}">
		가입하신 아이디와 회원정보에 등록된 이메일을 입력해 주세요
		<form action="pwInquiry.do" method="post">
			<table border="1">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="user_id" id="user_id" /></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="user_email" id="user_email" /></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="확인" />
					</td>
				</tr>
			</table>
		</form>
	</c:when>
	<c:otherwise>
		이메일로 임시 비밀번호가 발송되었습니다.<br />
		<a href="loginPage.do" class="login">로그인하기</a>
	</c:otherwise>
</c:choose>
		
</body>
</html>