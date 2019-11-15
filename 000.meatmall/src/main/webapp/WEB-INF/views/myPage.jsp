<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>마이페이지</title>
<script type="text/javascript">
	$(function(){
		$("#pwChk").click(function(){
			var aCount = $("#pwChk");
			var user_id = "${ldto.user_id}";
			var pw = $("#pw").val();
			
			$.ajax({
				url:"pwChk.do",
				data:{"user_id":user_id
					,"pw":pw},
				method:"post",
				datatype:"json",
				async:false,
				success:function(isPW){
					if(isPW){
						location.href="userInfo.do";
					}else{
						aCount.after("<div class='chkFalse'>"
										+"다시 입력해 주십시오."
									+"</div>");
					}
				},
				error:function(){
					alert("서버통신에러: 관리자에게 문의주세요");
				}
			});
		});
	});
</script>
</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<c:if test="${updateSuccess != null}">
	<script type="text/javascript">
		alert("${updateSuccess}");
	</script>
</c:if>
<dl>
	<dt>마이페이지</dt>
	<dd>
		<a href="myPage.do" class="myPage"><span>내 정보보기</span></a>
	</dd>
	<dd>
		<a href="orderList.do?user_num=${ldto.user_num}" class="orderList"><span>구매내역</span></a>
	</dd>
	<c:if test="${ldto.user_role ne 'USER'}">
		<dd>
			<a href="selOrderList.do?user_num=${ldto.user_num}" class="selOrderList"><span>판매내역</span></a>
		</dd>	
	</c:if>
	<dd>
		<a href="loginRecord.do" class="loginRecord"><span>접속기록</span></a>
	</dd>
</dl>


<table border="1">
	<tr>
		<td>정보를 수정하시려면 비밀번호를 입력하세요</td>
	</tr>
	<tr>
		<td>
			<input type="password" id="pw" />
			<input type="button" id="pwChk" value="확인" />
		</td>
	</tr>
</table>

</body>
</html>