<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
$(function(){
	$("form").submit(function(){
				var bool=true;
				//[input,input,textarea]
				var inputs=$(this).find("td").children().filter("[name]");
				inputs.each(function(){
					if($(this).val()==""){
						alert($(this).parent().prev().text()+"를 입력하세요");
						$(this).focus();
						bool=false;
						return false;
					}
				});
				return bool;
			});
		})
</script>
</head>
<body>
<h1>게시글수정하기</h1>
<form action="updateboard.do" method="post">
<input type="hidden" name="board_num" value="${dto.board_num}"/>
<table border="1">
	<tr>
		<th>번호</th>
		<td>${dto.board_num}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${dto.user_num}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="board_title" value="${dto.board_title}"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="board_content">${dto.board_content}</textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정완료"/>
			<button type="button" onclick="location.href='boardlist.do'">글목록</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>