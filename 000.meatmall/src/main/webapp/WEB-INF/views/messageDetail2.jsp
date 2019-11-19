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
			
			
		});
		
		$("#delete").click(function(){
			var message_num = $(this).prev().val();
			
			$.ajax({
				url:"deleteMessage.do",
				data:{"message_num":message_num
					, "fromTo":0},
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

.list-table .butt{
   text-align:right;
   padding:10px 0;
   border-bottom:1px solid #CCC; height:20px;
   font-size: 14px 
}

</style>

<body>
<table class="list-table">
	<col width="200px" />
	<col width="500px" />
	<tr>
		<th>받는 사람</th>
		<td>${mdto.user_nick}</td>
	</tr> 
	<tr>
		<th>보낸 시간</th>
		<td><fmt:formatDate value="${mdto.message_regdate}" pattern="yy-MM-dd [hh:mm]" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${mdto.message_content}</td>
	</tr>
	<tr>
		<td colspan="2" class="butt">
			<input type="hidden" value="${mdto.message_num}" />
			<input type="button" class="buttonsignup actionbutton" id="delete" value="삭제"/>
		</td>
	</tr>
</table>
</body>
</html>