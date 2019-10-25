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
<title></title>
<script type="text/javascript">

	$(function(){
		
		$("#like").click(function(){
			var aCount = $(this);
		
			$.ajax({
				url:"likechange.do",
				data:{"board_num":"${dto.board_num}"
					, "user_num":"${ldto.user_num}"},
				method:"post",
				datatype:"text",
				async:false, // t=비동기 (되는대로 실행) / f=동기 (순서대로 실행)
				success:function(likechange){
					var a = likechange.split(",");
					if(eval(a[0])){
						aCount.val("<img alt='좋아요' src='img/heart1.png'>a[1]");
					}else {
						aCount.val("<img alt='좋아요' src='img/heart2.png'>a[1]");
					}
				},
				error:function(){
					alert("서버통신실패!!");
				}
			});
		});
	});
	
</script>
</head>
<body>
<h1>게시글상세보기</h1>
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
		<td>${dto.board_title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.board_content}</textarea> </td>
	</tr>
	
	
			
	<tr>
		<td colspan="2">
			<button onclick="updateForm(${dto.board_num})">수정</button>
			<button onclick="delBoard(${dto.board_num})">삭제</button>
			<button onclick="location.href='boardlist.do?pnum=1'">글목록</button>
			
			<c:choose>
				<c:when test="${dto != null}">			
					<a href="" id="like"><img alt="좋아요" src="img/heart${like ? '2' : '1'}.png">${likecount}</a>								
				</c:when>
				<c:otherwise>
					<img alt="좋아요" src="img/heart1.png">${likecount}
				</c:otherwise>
			</c:choose>
			
		</td>
	</tr>

</table>
	

	

</body>
<script type="text/javascript">
	//글삭제하기
	function delBoard(board_num){
		location.href="delboard.do?board_num="+board_num;
	}
	//글수정하기
	function updateForm(board_num){
		location.href="updateform.do?board_num="+board_num;
	}
</script>
</html>