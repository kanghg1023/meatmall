<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>게시글 추가폼</title>
<!-- ckeditor 사용을 위해 js 파일 연결 -->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<!-- <script type="text/javascript" src="js/formCheck.js"></script> -->

<script type="text/javascript">
$(function(){	
	$("form").submit(function(){
		var bool = true;
		var input = $(this).find("td").children().filter("[name]");
		input.each(function(i){
			if($(this).prop("tagName")=="TEXTAREA"){
				if(CKEDITOR.instances.ckeditor.getData()==""){
					alert("내용을 입력하세요");
					bool = false;
					return false;
				}
			}else{
				if($(this).val()==""){
					alert($(this).parent().prev().text()+"를 입력하세요");
					$(this).focus();
					bool = false;
					return false;
				}
				
			}
		});
		return bool;
	});
});
</script>

<style type="text/css" media="screen">

.list-table {
    margin:100px auto 0px auto;
}

.list-table, .list-table th , .list-table td{         

  padding:10px;
                 
}

.list-table th{
   height:40px;
   border-top:2px solid #2AC37D;
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
</style>
</head>
<body>

<jsp:include page="header.jsp" />

<form action="insertboard.do" method="post" >
<input type="hidden" name="user_num" value="${ldto.user_num}">

<table class="list-table">
	<tr>
		<th>제목</th>
		<td><input type="text" name="board_title" id="board_title" autocomplete="off" placeholder="제목을 작성하세요" class="inputval"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="board_content" id="ckeditor" autocomplete="off" placeholder="내용을 입력하세요" class="inputval"></textarea></td>
	</tr>
	<tr>
		<td colspan="3" >
			<input type="submit" value="글등록" class="buttonsignup actionbutton" />&nbsp;
			<input type="button" value="목록" class="buttonsignup actionbutton" onclick="location.href='boardlist.do?pnum=1'"/>
			<c:if test="${ldto.user_num == 1}">
				<label><input type="checkbox" name="board_notice" value="1" />공지</label>
			</c:if>
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
<jsp:include page="footer.jsp" /> 
</body>
</html>











