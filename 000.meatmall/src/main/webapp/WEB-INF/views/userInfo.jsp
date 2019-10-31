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

function nickChkfun(){
	var aCount = $("#user_nick");
	var nick = aCount.val();
	
	aCount.next("div").remove();
	
	if(nick==""){
		aCount.after(falseMsg);
		nickChk = false;
	}else if(nick == "${ldto.user_nick}") {
		nickChk = true;
	}else {
		$.ajax({
			url:"nickChk.do",
			data:{"user_nick":nick},
			method:"post",
			datatype:"json",
			async:false,
			success:function(isS){
				if(isS){
					aCount.after("<div class='chkFalse'>"
									+"이미 사용중인 별명입니다."
								+"</div>");
					nickChk = false;
				}else {
					aCount.after("<div class='chkTrue'>"
									+"사용 가능한 별명입니다."
								+"</div>");
					nickChk = true;
				}
			},
			error:function(){
				alert("서버통신에러: 관리자에게 문의주세요");
			}
		});
	}
}

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

function phoneChkfun(){
	var aCount = $("#user_ph");
	var phone = aCount.val();
	var regexPhone = /^[0-9]{3,11}$/g;
	
	aCount.next("div").remove();
	
	if(phone==""){
		aCount.after(falseMsg);
		phoneChk = false;
	}else{
		if(regexPhone.test(phone)) {
			phoneChk = true;
		}else{
			aCount.val("");
			aCount.after("<div class='chkFalse'>"
							+"전화번호 형식이 아닙니다."
						+"</div>");
			phoneChk = false;
		}
	}
}

function addrChkfun(){
	var aCount=$("#user_addr");
	var addr = aCount.val();
	aCount.next().next("div").remove();
	
	if(addr==""){
		aCount.next().after(falseMsg);
		addrChk = false;
	}else{
		addrChk = true;
	}
}

function addrDetailChkfun(){
	var aCount=$("#user_addr_detail");
	var addr = aCount.val();
	aCount.next("div").remove();
	
	if(addr==""){
		aCount.after(falseMsg);
		addrDetailChk = false;
	}else{
		addrDetailChk = true;
	}
}

function emailChkfun(){
	var aCount = $("#user_email");
	var email = aCount.val();
	var regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/g;
	aCount.next("div").remove();
	
	if(email==""){
		aCount.after(falseMsg);
		emailChk = false;
	}else{
		if(regexEmail.test(email)) {
			emailChk = true;
		}else{
			aCount.after("<div class='chkFalse'>"
							+"이메일 형식이 아닙니다."
						+"</div>");
			emailChk = false;
		}
	}
}

$(function(){
	$("#user_id").blur(function(){
		idChkfun();
	});
	
	$("#user_pw").blur(function(){
		pwChkfun();
	});
	
	$("#user_pw2").blur(function(){
		pw2Chkfun();
	});
	
	$("#user_name").blur(function(){
		nameChkfun();
	});
	
	$("#user_nick").blur(function(){
		nickChkfun();
	});
	
	$("#user_ph").blur(function(){
		phoneChkfun();
	});
	
	$("#user_addr").blur(function(){
		addrChkfun();
	});
	
	$("#user_addr_detail").blur(function(){
		addrDetailChkfun();
	});
	
	$("#user_email").blur(function(){
		emailChkfun();
	});
	
	$("#user_businessnum").blur(function(){
		businessnumChkfun();
	});
	
	$("form").submit(function(){
		
		if(pw2Chk && nickChk && phoneChk && addrChk && addrDetailChk && emailChk){
			return true;
		}else{
			pw2Chkfun();
			nickChkfun();
			phoneChkfun();
			addrChkfun();
			addrDetailChkfun();
			emailChkfun();
			
			if(pw2Chk && nickChk && phoneChk && addrChk && addrDetailChk && emailChk){
				return true;
			}else{
				return false;
			}
		}
	});
});
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
			<td><input type="text" name="user_nick" value="${ldto.user_nick}"/></td>
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
			<td>
				<input type="text" name="user_addr" value="${ldto.user_addr}" readonly="readonly"/>
				<input type="button" id="jusoApi" value="주소검색" />
			</td>
		</tr>
		<tr>
			<th>상세주소</th>
			<td><input type="text" name="user_addr_detail" value="${ldto.user_addr_detail}"/></td>
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