<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- ckeditor 사용을 위해 js 파일 연결 -->
<script type="text/javascript" src="/meatmall/ckeditor/ckeditor.js"></script>
</head>
<body>
<h1>1:1문의글 추가하기</h1>
<form action="questioninsert.do" method="post" >
	<input type="hidden" name="user_num" value="${ldto.user_num}"/>
	<input type="hidden" name="pnum" value="${pnum}"/>
		${pnum}
	<table border="1">
		<tr>
			<th>작성자</th>
			<td>${ldto.user_num}</td>
		</tr>
		<tr>
			<th>문의제목</th>
			<td><input type="text" name="question_title" /></td>
		</tr>
		<tr>
			<th>문의내용</th>
			<td><textarea name="question_content" id="ckeditor"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="글등록"/>
				<input type="button" value="목록" 
				          onclick="location.href='questionlist.do?user_num=${ldto.user_num}'"/>
			</td>
		</tr>
	</table>
</form>
<script>
//id가 ckeditor인 태그에 ckeditor를 적용시킴
CKEDITOR.replace("ckeditor",{
    filebrowserUploadUrl : "/meatmall"+"/imageUpload.do",			//,width : '800px'
    width : '800px' , height : '500px'
}); //이미지 업로드 기능을 추가하기위한 코드
</script>
</body>
</html>