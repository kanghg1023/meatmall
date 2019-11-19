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
<title>쪽지 보내기</title>
<script type="text/javascript">
	$(function(){
		
		$("#insert").click(function(){
			var message_from_num = $("#message_from_num").val();
			var user_num = $("#user_num").val();
			var message_content = $("#message_content").val();
			
			$.ajax({
				url:"insertMessage.do",
				data:{"message_from_num":message_from_num
					, "user_num":user_num
					, "message_content":message_content},
				method:"post",
				datatype:"json",
				async:false,
				success:function(isInsert){
					if(isInsert){
						alert("쪽지를 보냈습니다.");
						self.close();
					}else{
						alert("쪽지보내기 실패");
					}
				},
				error:function(){
					alert("서버통신에러: 관리자에게 문의주세요");
				}
			});
		});
	});
</script>

<style type="text/css" media="screen">

.list-table {
    margin:50px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  padding:10px;
                 
}

.list-table th{
   height:40px;
   
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 17px;
   
}
.list-table td{
   
   padding:15px 0;
   border-bottom:1px solid #2AC37D; height:20px;
   font-size: 14px
   
    
}

.list-table .buttonsignup {
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

.list-table .actionbutton {
	margin-top:0%;
}
</style>

</head>
<body>
<input type="hidden" id="message_from_num" value="${ldto.user_num}">
<input type="hidden" id="user_num" value="${user_num}">
<table class="list-table">
	<col width="200px" />
	<col width="500px" />
	<tr>
		<th>받는 사람</th>
		<td>${user_nick}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" id="message_content" class="inputval"></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" id="insert" class="buttonsignup actionbutton" value="쪽지 보내기"/>
		</td>
	</tr>
</table>
</body>
</html>