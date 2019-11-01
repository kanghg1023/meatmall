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
<title>Insert title here</title>

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
<h1>1:1문의하기</h1>
<table border="1">
	<tr>
		<th>작성자</th>
		<td>${qdto.user_num}</td>
		<th>작성일</th>
		<td>${qdto.question_regdate}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td colspan="3">${qdto.question_title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td colspan="3"><textarea rows="10" cols="60" >${qdto.question_content}</textarea> </td>
	</tr>
	<tr>
		<td colspan="3">
			<c:choose>
				<c:when test="${ldto.user_role eq 'ADMIN'}">
					<input type="button" value="목록" 
					          onclick="location.href='questionlist.do'"/>	
					<button onclick="answerinsert()">문의 답글 달기</button>
				</c:when>
				<c:otherwise>
					<button onclick="questionupdateForm(${qdto.question_num})">수정</button>
					<input type="button" value="삭제"
					          onclick="location.href='questiondelete.do?question_num=${qdto.question_num}'" />
					<input type="button" value="목록"
					          onclick="location.href='questionlist.do?user_num=${qdto.user_num}'"/>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>

<div id="awswerForm" style="display: ${qdto.question_status eq 'Y' ? '' : 'none'};">
<h1>1:1문의답글</h1>
	<form action="answerinsert.do" method="post" >
		<input type="hidden" name="question_num" value="${qdto.question_num}"/>
		<table border="1">
			<c:if test="${qdto.question_status eq 'N'}">
				<tr>
					<th>작성자</th>
					<td>관리자</td> 
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="60" name="answer_content"></textarea></td>
				</tr>
			</c:if>
			<c:if test="${qdto.question_status eq 'Y'}">
				<tr>
					<th>작성날짜</th>
					<td colspan="3">
						<fmt:formatDate value="${adto.answer_regdate}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>관리자</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="10" cols="60" readonly="readonly">${adto.answer_content}</textarea></td>
				</tr>
			</c:if>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록"/>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>