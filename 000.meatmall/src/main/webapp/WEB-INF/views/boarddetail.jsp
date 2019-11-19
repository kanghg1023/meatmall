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
				data:{"board_num":"${boarddto.board_num}"
					, "user_num":"${ldto.user_num}"},
				method:"post",
				datatype:"text",
				async:false,
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
		//대댓글의 들여쓰기 기능
		$(".boardlist123").each(function(){
			if($(this).children().eq(0).is("li")){
				$(this).css("padding-left","30px");		
			}
		})
		
		
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
			var aCount = $(this).parent();
			aCount.after("<li id='recomment' class='boardlist123'>"
							+"<textarea rows='2' cols='55' id='content2' ></textarea>"
							+"<input type='button' id='recommentBtn' value='등록' />"
						+"</li>");
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
			location.href="recomment.do?&board_num=${boarddto.board_num}&comment_num="
					+comment_num+"&comment_content="+content.val();
		});
		
		$("body").on("click",".updatecommentForm",function(){
			$(".cancelBtn1").attr('class','updatecommentForm');
			comment_num = $(this).val();
			var aCount = $(this).parent();
			var recomment = aCount.children(".recomment");
			var txt=recomment.text();
			recomment.text("");
			recomment.append("<textarea rows='2' cols='55' id='content2' >"
					+txt+"</textarea>"
					+"<input type='button' id='updatecommentBtn' value='수정' />"
					);
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
			location.href="updatecomment.do?&board_num=${boarddto.board_num}&comment_num="
					+comment_num+"&comment_content="+content.val();
		});				
	});
			
	function delcomment(comment_num){
		location.href="delcomment.do?&comment_num="+comment_num+"&board_num=${boarddto.board_num}";
	}
	
</script>
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
<style type="text/css">
#im img{width: 12px; height: 12px;}



.list-table {
    margin:100px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  padding:10px;
                 
}

.list-table th{
   height:40px;
   
   border-bottom:1px solid #2AC37D;
   font-weight: bold;
   font-size: 17px;
   
}
.list-table td{
   
   padding:15px 0;
   border-bottom:1px solid #2AC37D; height:20px;
   font-size: 14px
   
    
}

.list-table .buttonsignup {
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

.list-table .actionbutton {
	margin-top:0%;
}

.commentlist{         
/* 	text-align: center; */
}



.boardlist123 li{
	list-style: none;
	
	border-left	:1px solid #2AC37D;
	border-left-style:dotted;	
	
}


.boardlist123{ 
	width: 600px;
	background-color : #f9f9f9; 
	border-width: 1px 0;
	border-bottom:1px solid #2AC37D;
	
 	border-collapse: collapse;
 	
	margin: 0 auto;
	border-bottom-style:dotted;
		
}

.buttonsignup2 {
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

.actionbutton2 {
	margin-top:0%;
	margin-left:85% 
}

</style>
</head>
<body>


<jsp:include page="header.jsp" />

<div id="container">

<table class="list-table">
	<col width="100px">
	<col width="500px">
	
	
	<tr>
		<th>번호</th>
		<td>${boarddto.board_num}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${boarddto.user_nick}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${boarddto.board_title}</td>
	</tr>
	<tr>
		
		<td colspan="4" style="height: 200px;">
			<div style="height: 100%;overflow: auto;">
				${boarddto.board_content}
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<c:if test="${boarddto.user_num eq ldto.user_num or ldto.user_role eq 'ADMIN'}">
				<button class="buttonsignup actionbutton" onclick="updateForm(${boarddto.board_num})">수정</button>
				<button class="buttonsignup actionbutton" onclick="delBoard(${boarddto.board_num})">삭제</button>
			</c:if>					
			<button class="buttonsignup actionbutton" onclick="location.href='boardlist.do?pnum=${pnum}'">글목록</button>
			<button id="commentBtn" class="buttonsignup actionbutton" >댓글</button>
			<c:choose>
				<c:when test="${boarddto != null}">			
					<a href="" id="like"><img id="im" alt="좋아요" src="img/heart${like ? '2' : '1'}.png">${likecount}</a>								
				</c:when>
				<c:otherwise>
					<img alt="좋아요" src="img/heart1.png">${likecount}
				</c:otherwise>
			</c:choose>			
		</td>
	</tr>
</table>
<br/>
<div id="commentForm" class="commentlist" >
	<form action="addcomment.do" method="post">		
		<input type="hidden" name="board_num" value="${boarddto.board_num}" />
		<c:if test="${boarddto != null || clist != null}">
				
			<c:if test="${clist != null}">
				<c:forEach items="${clist}" var="cdto" varStatus="dto">
					<div class="boardlist123" >
						<c:choose>
							<c:when test="${clist[dto.index+1].comment_re_check > 0 && cdto.comment_delflag == 0 && cdto.comment_re_check == 0}">
								<p style="font-size: 15px">&nbsp;삭제된 댓글입니다</p>
							</c:when>
							<c:when test="${cdto.comment_re_check > 0 && cdto.comment_delflag > 0}">
								
								<li class="comm">								
									<strong>&nbsp;${dto.user_num}</strong>
									<fmt:formatDate value="${cdto.comment_regdate}" pattern="yyyy-MM-dd HH:mm"/>
									<c:if test="${cdto.user_num eq ldto.user_num}">
										<button type="button" onclick="delcomment(${cdto.comment_num})">삭제</button>
										<button type="button" class="updatecommentForm" value="${cdto.comment_num}">수정</button>
									</c:if>
								<p class="recomment">&nbsp;${cdto.comment_content}</p>
								</li>
								&nbsp;
							</c:when>							
							<c:when test="${cdto.comment_re_check == 0 && cdto.comment_delflag > 0}">
									<strong>&nbsp;${cdto.user_nick}</strong>
									<fmt:formatDate value="${cdto.comment_regdate}" pattern="yyyy-MM-dd HH:mm"/>
									<c:if test="${ldto != null}">
										<button type="button" class="recommentForm" value="${cdto.comment_num}">답글</button>
									</c:if>
									<c:if test="${cdto.user_num eq ldto.user_num}">
										<button type="button" onclick="delcomment(${cdto.comment_num})">삭제</button>
										<button type="button" class="updatecommentForm" value="${cdto.comment_num}">수정</button>
									</c:if>
								<p class="recomment" style="border-bottom : 0px solid #2AC37D;">&nbsp;${cdto.comment_content}</p>
								
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
			</c:if>
			<br/>
			<c:if test="${boarddto != null}">
				<div style="width: 600px; margin: 0 auto;" >
					<textarea rows="2" cols="75" name="comment_content" ></textarea>
					<input type="submit" value="등록" id="btn" class="buttonsignup2 actionbutton2" />
				</div>
			</c:if>
		</c:if>
	</form>
</div>
</div>
<br/><br/>
<jsp:include page="footer.jsp" /> 
</body>
</html>