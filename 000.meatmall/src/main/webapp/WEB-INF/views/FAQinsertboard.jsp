<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<jsp:include page="header.jsp" />
<style type="text/css">
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

.list-table .faqbtn {
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

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){	
	$("form").submit(function(){
		var bool = true;
		var input = $(this).find("td").children().filter("[name]");
		
		input.each(function(i){
			if($(this).val()==""){
				alert($(this).parent().prev().text()+"를 입력하세요");
				$(this).focus();
				bool = false;
				return false;
			}
		});
		return bool;
	});
});
</script>
</head>
<body>
<form action="faqinsertboard.do" method="post" style="margin-bottom: 70px;" >
	<table class="list-table" style="width:70%;">
		<tr>
			<th>FAQ 제목</th>
			<td><input type="text" name="faq_title" maxlength="30" /></td>
		</tr>
		<tr>
			<th>FAQ 내용</th>
			<td><textarea rows="10" cols="102" id="textarea" name="faq_content" wrap="hard"></textarea> </td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="글등록" class="faqbtn"/>
				<input type="button" value="목록" onclick="location.href='faqlist.do'" class="faqbtn"/>
			</td>
		</tr>
	</table>
</form>
<jsp:include page="footer.jsp" />
</body>
</html>