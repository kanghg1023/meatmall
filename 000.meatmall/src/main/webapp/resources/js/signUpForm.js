/**
 * 
 */

var idChk;
var pwChk;
var pw2Chk;
var nameChk;
var nickChk;
var phoneChk;
var addrChk;
var addrDetailChk;
var emailChk;
var businessnumChk;

var falseMsg="<div class='chkFalse'>"
				+"필수 정보입니다."
			+"</div>";

//아이디 체크
function idChkfun(){
	var aCount = $("#user_id");
	var id = aCount.val();
	
	aCount.next("div").remove();
	
	if(id==""){
		aCount.after(falseMsg);
		idChk = false;
	}else{
		$.ajax({
			url:"idChk.do",
			data:{"user_id":id},
			method:"post",
			datatype:"json",
			async:false,
			success:function(isS){
				if(isS){
					aCount.after("<div class='chkFalse'>"
									+"이미 사용중이거나 탈퇴한 아이디입니다."
								+"</div>");
					idChk = false;
				}else {
					aCount.after("<div class='chkTrue'>"
									+"사용 가능한 아이디입니다."
								+"</div>");
					idChk = true;
				}
			},
			error:function(){
				alert("서버통신에러: 관리자에게 문의주세요");
			}
		});
	}
}

//비밀번호 체크
function pwChkfun(){
	var aCount=$("#user_pw");
	var pw = aCount.val();
	aCount.next("div").remove();
	
	if(pw==""){
		aCount.after(falseMsg);
		pwChk = false;
	}else{
		pwChk = true;
	}
}

//비밀번호확인 체크
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

//이름 체크
function nameChkfun(){
	var aCount=$("#user_name");
	var name = aCount.val();
	aCount.next("div").remove();
	
	if(name==""){
		aCount.after(falseMsg);
		nameChk = false;
	}else{
		nameChk = true;
	}
}

//닉네임 체크
function nickChkfun(){
	var aCount = $("#user_nick");
	var nick = aCount.val();
	
	aCount.next("div").remove();
	
	if(nick==""){
		aCount.after(falseMsg);
		nickChk = false;
	}else{
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

//전화번호 체크
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

//도로명주소 체크
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

//상세주소 체크
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

//이메일 체크
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

//사업자 등록번호
function businessnumChkfun(){
	var aCount=$("#user_businessnum");
	var businessnum = aCount.val();
	
	aCount.next("div").remove();
	
	if(businessnum==""){
		aCount.after(falseMsg);
		businessnumChk = false;
	}else{
		businessnumChk = true;
	}
}

$(function(){
	$("#user_id").blur(function(){
		idChkfun();
	});
	
	$("#user_pw").blur(function(){
		pwChkfun();
		if($("#user_pw2").val() != ""){
			pw2Chkfun();
		}
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
		if($("#user_businessnum").val() == undefined){
			businessnumChk = true;
		}
		
		if(idChk && pwChk && pw2Chk && nameChk && nickChk 
				&& phoneChk && addrChk && addrDetailChk && emailChk && businessnumChk){
			return true;
		}else{
			idChkfun();
			pwChkfun();
			pw2Chkfun();
			nameChkfun();
			nickChkfun();
			phoneChkfun();
			addrChkfun();
			addrDetailChkfun();
			emailChkfun();
			businessnumChkfun();
			
			if(pw2Chk && nickChk && phoneChk && addrChk && addrDetailChk && emailChk){
				return true;
			}else{
				return false;
			}
		}
	});
});