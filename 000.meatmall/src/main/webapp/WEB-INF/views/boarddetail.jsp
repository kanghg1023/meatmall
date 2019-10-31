<%@page import="java.util.Map"%>
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
	
	$(function(){
		$("#commentBtn").click(function(){
			$("#commentForm").toggle(1000);
			var replyPosition = $("#commentForm").offset().top;
			$("#container").animate({
				"scrollTop":replyPosition
			},1000);
		});
		
		
		$("form").submit(function(){
			var content = $(this).find("textarea[name=comment_content]");
			if(content.val().length == 0){
				alert("내용을 입력하시오");
				content.focus();
				return false;
			}
		})
		
		var comment_refer;
		var comment_num
		
		$("body").on("click",".recommentForm",function(){
			$("#recomment").remove();
			$(".cancelBtn").attr('class','recommentForm');
			comment_num = $(this).val();
			var aCount = $(this).parent().parent().next();
			aCount.after("<tr id='recomment'>"+
					"<td></td>"+
					"<td colspan='2'><textarea rows='2' cols='55' id='content2' ></textarea>"+
					"<input type='button' id='recommentBtn' value='등록' />"+
					"</td></tr>");
			$(this).attr('class','cancelBtn');
		});
		
		$("body").on("click",".cancelBtn",function(){
			$("#recomment").remove();
 			$(this).attr('class','recommentForm');
		});
		
		$("body").on("click","#recommentBtn",function(){
			var content = $("#content2");
			if(content.val().length == 0){
				alert("내용을 입력하시오");
				content.focus();
				return false;
			}
			location.href="recomment.do?&board_num=${dto.board_num}&comment_num="+comment_num+"&comment_content="+content.val();
		});
		
// 		parent() children() append()
		
		$("body").on("click",".updatecommentForm",function(){
//			$("#updatecomment").remove();
			$(".cancelBtn1").attr('class','updatecommentForm');
			comment_num = $(this).val();
			var aCount = $(this).parent().parent().next();
				
			var txt=aCount.children('td').text();
			aCount.children('td').text("");
			aCount.children("td").append("<textarea rows='2' cols='55' id='content2' >"+txt+"</textarea>"+
					"<input type='button' id='updatecommentBtn' value='수정' />"
					);
// 			aCount.after("<tr id='updatecomment'>"+
// 					"<td></td>"+
// 					"<td colspan='2'><textarea rows='2' cols='55' id='content2' ></textarea>"+
// 					"<input type='button' id='updatecommentBtn' value='뭐지' />"+
// 					"</td></tr>");
			$(this).attr('class','cancelBtn1');
		});
		
		$("body").on("click",".cancelBtn1",function(){
			$("#updatecomment").remove();
 			$(this).attr('class','updatecommentForm');
		});
		
		$("body").on("click","#updatecommentBtn",function(){
			var content = $("#content2");
			if(content.val().length == 0){
				alert("내용을 입력하시오");
				content.focus();
				return false;
			}
			location.href="updatecomment.do?&board_num=${dto.board_num}&comment_num="+comment_num+"&comment_content="+content.val();
		});
		
	
		
								
	});
			
	function delcomment(comment_num){
		location.href="delcomment.do?&comment_num="+comment_num+"&board_num=${dto.board_num}";
	}
	
	
	
</script>

<style type="text/css">
	img{width: 12px; height: 12px;}
	
</style>
</head>
<%
Map<String,Integer>map=(Map<String,Integer>)request.getAttribute("pmap");
%>
<body>
<div id="container">
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
			<c:if test="${dto.user_num eq ldto.user_num}">
			<button onclick="updateForm(${dto.board_num})">수정</button>
			<button onclick="delBoard(${dto.board_num})">삭제</button>
			</c:if>					
			<button onclick="location.href='boardlist.do?pnum=${pnum}'">글목록</button>			
			
			<button id="commentBtn">댓글</button>
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
<div id="commentForm">
	<form action="addcomment.do" method="post">		
		<input type="hidden" name="board_num" value="${dto.board_num}" />
		<c:if test="${dto != null || clist != null}">
			<table border="1" class="commentTable">
				<c:if test="${dto != null}">
					<tr>
						<td colspan="3">
							<textarea rows="2" cols="75" name="comment_content" ></textarea>
							<input type="submit" value="등록" id="btn"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${clist != null}">
					<c:forEach items="${clist}" var="cdto">
					<tr>
						<c:if test="${cdto.comment_refer > 0}">
							<td rowspan="2" class="arrowSel"><img src="img/arrow.png" alt="답글" /></td>
						</c:if>
						<td>${cdto.user_num}</td>
						<td colspan="2">
							<fmt:formatDate value="${cdto.comment_regdate}" pattern="yyyy-MM-dd HH:mm"/>
							<c:if test="${dto != null}">
								<button type="button" class="recommentForm" value="${cdto.comment_num}">답글</button>
							</c:if>
							<c:if test="${cdto.user_num eq ldto.user_num}">
								<button type="button" onclick="delcomment(${cdto.comment_num})">삭제</button>
								<button type="button" class="updatecommentForm" value="${cdto.comment_num}">수정</button>
							</c:if>
						</td>
					</tr>
					<tr style="white-space:pre;">
						<td colspan="3" class="conSel">${cdto.comment_content}</td>
					</tr>
					</c:forEach>
				</c:if>
			</table>
		</c:if>
	</form>
</div>	
</div>	
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