<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>정보보기</title>
<script type="text/javascript">
function pw2Chkfun(){
	var aCount=$("#user_pw2");
	var pw = $("#user_pw").val();
	var pw2 = aCount.val();
	aCount.next("div").remove();
	
	if(pw2==""){
		aCount.after(falseMsg);
		pw2Chk = false;
	}else{
		if(pw == pw2){
			aCount.after("<div class='chkTrue'>"
							+"비밀번호가 일치합니다."
						+"</div>");
			pw2Chk = true;
		}else {
			aCount.val("");
			aCount.after("<div class='chkFalse'>"
							+"비밀번호가 일치하지 않습니다."
						+"</div>");
			pw2Chk = false;
		}
	}
}
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>

<form action="userUpdate.do">
	<input type="hidden" name="user_num" value="${ldto.user_num}" />
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>${ldto.user_id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${ldto.user_name}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${ldto.user_nick}</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="user_pw" id="user_pw" /></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="user_pw2" id="user_pw2" /></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="user_ph" value="${ldto.user_ph}"/></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="user_addr" value="${ldto.user_addr}"/></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="user_email" value="${ldto.user_email}"/></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="정보수정"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>