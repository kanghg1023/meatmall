<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %> <!-- 요청할때 utf-8로 -->
<%response.setContentType("text/html; charset=UTF-8"); %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-1.9.1.min.js"
  integrity="sha256-wS9gmOZBqsqWxgIVgA8Y9WcQOa7PgSIX+rPA0VL2rbQ="
  crossorigin="anonymous"></script>
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
		//content 클래스를 가진 div를 표시/숨김(토글)
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
	<c:choose>
		<c:when test="${ldto.user_role eq 'USER' || ldto.user_role eq 'LICENSE'}">
			<input type="button" value="1:1문의" 
			onclick="location.href='questionlist.do?pnum=1'">
		</c:when>
		<c:when test="${ldto.user_role eq 'ADMIN'}">
			<input type="button" value="1:1답변" 
			onclick="location.href='allqnalist.do?pnum=1'">
		</c:when>
	</c:choose>
<div class=layer1>
	<h2>자주묻는질문</h2>
	<p style="border-bottom:3px solid blue"></p>
	<c:forEach items="${flist}" var="flist">
		<div class="heading" >
	<%-- 		<td>${list.faq_num}</td> --%>
			<p>${flist.faq_title}</p>
		</div>
		<div class="content" id="content">
			<pre>${flist.faq_content}</pre>
		<c:if test="${ldto.user_role eq 'ADMIN'}">
			<input type="button" value="글 수정" 
				       onclick="location.href='faqupdateform.do?faq_num=${flist.faq_num}'"/>
			<input type="button" value="글 삭제" 
				       onclick="location.href='faqdelboard.do?seq=${flist.faq_num}'"/>
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