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
<h1>자주묻는질문 수정하기</h1>
<form action="faqupdateboard.do" method="post">
	<input type="hidden" name="faq_num" value="${fdto.faq_num}"/>
	<table border="1">
		<tr>
			<th>FAQ 제목</th>
			<td><input type="text" name="faq_title" value="${fdto.faq_title}" maxlength="15" /></td>
		</tr>
		<tr>
			<th>FAQ 내용</th>
			<td><textarea rows="10" cols="60" name="faq_content" wrap="hard">${fdto.faq_content}</textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정완료"/>
				<button type="button" onclick="location.href='faqlist.do'">글목록</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>