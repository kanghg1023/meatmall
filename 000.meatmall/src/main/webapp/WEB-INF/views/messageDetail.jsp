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
<title>받은쪽지 상세보기</title>
</head>
<script type="text/javascript">
	$(function(){
		
		$("#insert").click(function(){
			var user_num = $(this).prev().prev().val();
			var user_nick = $(this).prev().val();
			
			location.href = "messageForm.do?user_num="+user_num+"&user_nick="+user_nick;
		});
		
		$("#delete").click(function(){
			var message_num = $(this).prev().val();
			
			$.ajax({
				url:"deleteMessage.do",
				data:{"message_num":message_num
					, "fromTo":1},
				method:"post",
				datatype:"json",
				async:false,
				success:function(isDelete){
					if(isDelete){
						opener.location.reload();
						self.close();
					}else{
						alert("삭제 실패");
					}
				},
				error:function(){
					alert("서버통신에러: 관리자에게 문의주세요");
				}
			});
			
		});
	});
</script>
<body>
<table border="1">
	<tr>
		<th>보낸 사람</th>
		<td>${mdto.user_nick}</td>
	</tr> 
	<tr>
		<th>받은시간</th>
		<td><fmt:formatDate value="${mdto.message_regdate}" pattern="yy-MM-dd [hh:mm]" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${mdto.message_content}</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="hidden" value="${mdto.message_from_num}" />
			<input type="hidden" value="${mdto.user_nick}" />
			<input type="button" id="insert" value="답장"/>
			<input type="hidden" value="${mdto.message_num}" />
			<input type="button" id="delete" value="삭제"/>
		</td>
	</tr>
</table>
</body>
</html>