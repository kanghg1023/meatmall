<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<!-- ckeditor 사용을 위해 js 파일 연결 -->
<script type="text/javascript" src="/meatmall/ckeditor/ckeditor.js"></script>
<style type="text/css">
	img{max-width: 700px; height: auto;}
</style>

<title></title>
<script type="text/javascript">

	function answerinsert(){
		$("#awswerForm").toggle();
	}
	
	function questionupdateForm(question_num){
		location.href="questionupdateform.do?question_num="+question_num
	}
	
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<h1>1:1문의하기</h1>
<div style="width:800px;">
<table border="1">
	<col width="100px">
	<col width="100px">
	<col width="100px">
	<col width="500px">
	
	<tr>
		<th>작성자</th>
		<td>${qdto.user_num}</td>
		<th>작성일</th>
		<td><fmt:formatDate value="${qdto.question_regdate}" pattern="yyyy년MM월dd일"/></td>
	</tr>
	<tr>
		<th>문의 제목</th>
		<td colspan="3">${qdto.question_title}</td>
	</tr>
	<tr>
		<th>문의 내용</th>
		<td colspan="3" style="height: 400px;">
			<div style="height: 100%;overflow: auto;">
				${qdto.question_content}
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<c:choose>
				<c:when test="${ldto.user_role eq 'ADMIN'}">
					<input type="button" value="목록" 
					          onclick="location.href='questionlist.do'"/>	
					<button onclick="answerinsert()">문의 답글 달기</button>
				</c:when>
				<c:otherwise>
					<c:if test="${qdto.question_status == 0}">
					<button onclick="questionupdateForm(${qdto.question_num})">수정</button>
					<input type="button" value="삭제"
					          onclick="location.href='questiondelete.do?question_num=${qdto.question_num}'" />
					</c:if>
					<input type="button" value="목록"
					          onclick="location.href='questionlist.do?user_num=${qdto.user_num}'"/>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>
</div>

<div id="awswerForm" style="display: ${qdto.question_status == 2 ? '' : 'none'};">
<h1>1:1문의답글</h1>
	<form action="answerinsert.do" method="post" >
		<input type="hidden" name="question_num" value="${qdto.question_num}"/>
		<div style="width:800px;">
		<table border="1">
			<col width="100px">
			<col width="700px">
			<c:choose>
				<c:when test="${qdto.question_status == 2}">
					<tr>
						<th>작성날짜</th>
						<td colspan="3">
							<fmt:formatDate value="${qdto.answer_regdate}" pattern="yyyy년MM월dd일"/>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>관리자</td>
					</tr>
					<tr>
						<th>답변내용</th>
						<td colspan="3" style="height: 400px;">
							<div style="height: 100%;overflow: auto;">
								${qdto.question_answer}
							</div>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th>작성자</th>
						<td>관리자</td> 
					</tr>
					<tr>
						<th>답변내용</th>
						<td>
							<textarea name="question_answer" id="ckeditor"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="등록"/>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
	</form>
</div>
<script>
//id가 ckeditor인 태그에 ckeditor를 적용시킴
CKEDITOR.replace("ckeditor",{
    filebrowserUploadUrl : "/meatmall"+"/imageUpload.do",			//,width : '800px'
    width : '800px' , height : '500px'
}); //이미지 업로드 기능을 추가하기위한 코드
</script>
<jsp:include page="footer.jsp" /> 
</body>
</html>