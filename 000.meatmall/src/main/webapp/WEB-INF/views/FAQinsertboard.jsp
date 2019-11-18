<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
<h1>자주묻는글 추가하기</h1>
<form action="faqinsertboard.do" method="post" >
	<table border="1">
		<tr>
			<th>FAQ 제목</th>
			<td><input type="text" name="faq_title" maxlength="15" /></td>
		</tr>
		<tr>
			<th>FAQ 내용</th>
			<td><textarea rows="10" cols="102" id="textarea" name="faq_content" wrap="hard"></textarea> </td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="글등록"/>
				<input type="button" value="목록" onclick="location.href='faqlist.do'" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>