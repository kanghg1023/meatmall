<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	
	.layer1 {
	
	position:absolute; left:50%; top:20%; transform:translateX(-50%);
	width: 500px;
	}
	
	.heading {
	margin: 1px;
	color: black;
	padding: 3px 10px;
	cursor: pointer;
	background-color:white;
	border-bottom:1px solid blue;>
	height: 30px;
	}
	
	.content {
	padding: 5px 10px;
	background-color:#E2E2E2;
	}
	
	p { padding: 5px 0; }
	
</style>
<script type="text/javascript">

	$(document).ready(function() {
		$(".content").hide();
		
		$(".heading").click(function(){
			var content = $(this).next(".content");
			$(".content").not(content).hide();
			content.slideToggle(300);
		});	
	});
	
</script>

</head>
<body>
<div id="header" class="header" style="outline: none;">
	<jsp:include page="header.jsp" />
</div>
<input type="button" value="1:1문의" onclick="location.href='questionlist.do?pnum=1'">
<div class=layer1>
	<h2>자주묻는질문</h2>
	<p style="border-bottom:3px solid blue"></p>
	<c:forEach items="${faqlist}" var="dto">
		<div class="heading" >
			<p>${dto.faq_title}</p>
		</div>
		<div class="content" id="content">
			<pre>${dto.faq_content}</pre>
			<c:if test="${ldto.user_role eq 'ADMIN'}">
				<input type="button" value="글 수정" 
					       onclick="location.href='faqupdateform.do?faq_num=${dto.faq_num}'"/>
				<input type="button" value="글 삭제" 
					       onclick="location.href='faqdelboard.do?faq_num=${dto.faq_num}'"/>
			</c:if>
		</div>
	</c:forEach>
	<c:if test="${ldto.user_role eq 'ADMIN'}">	
		<div>
			<input type="button" value="자주묻는글 추가" 
				       onclick="location.href='faqinsertform.do'"/>		
		</div>
	</c:if>
</div>
</body>
</html>