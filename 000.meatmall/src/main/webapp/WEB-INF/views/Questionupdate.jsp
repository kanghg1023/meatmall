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
<form action="questionupdate.do" method="post">
	<input type="hidden" name="question_num" value="${qdto.question_num}"/>
	<table border="1">
		<tr>
			<th>문의제목</th>
			<td><input type="text" name="question_title" value="${qdto.question_title}"/></td>
		</tr>
		<tr>
			<th>문의내용</th>
			<td><textarea name="question_content" id="ckeditor">${qdto.question_content}</textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정완료"/>
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