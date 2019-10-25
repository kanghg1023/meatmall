<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<a href="main.do" class="main"><span>홈</span></a>
<c:choose>
	<c:when test="${ldto == null}">
		<c:if test="${loginError != null}">
			<script type="text/javascript">
				alert("${loginError}");
			</script>
		</c:if>
		<a href="loginPage.do" class="login">로그인</a> | 
		<a href="registPage.do" class="regist">회원가입</a>
	</c:when>
	<c:otherwise>
		${ldto.user_nick}님 | 
		<a href="logout.do" class="logout">로그아웃</a> | 
		<c:if test="${ldto.user_role eq 'ADMIN'}">
			<a href="logout.do" class="logout">관리자 페이지</a> |
		</c:if>
		<a href="myPage.do" class="myPage">마이페이지</a> | 
		<a href="logout.do" class="logout">장바구니</a>
	</c:otherwise>
</c:choose>
<div>
<div>
<dl>
	<dt>메뉴</dt>
	<dd>
		<a href="allGoods.do" class="allGoods"><span>전체상품</span></a>
	</dd>
	<dd>
		<a href="category.do" class="category"><span>부위별 상품</span></a>
	</dd>
	<dd>
		<a href="faqlist.do" class="faqlist"><span>1대1 문의</span></a>
	</dd>
	<dd>
		<a href="boardlist.do?pnum=1" class="boardlist"><span>게시판</span></a>
	</dd>
</dl>
</div>
</div>
</body>
</html>