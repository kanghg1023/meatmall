<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/meatmall/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<script type="text/javascript" src="js/formCheck.js"></script>

<script type="text/javascript">
$(function(){	
	$("form").submit(function(){
		var bool = true;
		var input = $(this).find("td").children().filter("[name]");
		
		input.each(function(i){
			
			if($(this).prop("tagName")=="TEXTAREA"){
				if(CKEDITOR.instances.ckeditor.getData() == ""){
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

<style type="text/css">

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

</style>

</head>
<body>

<jsp:include page="header.jsp" />


<form action="updateboard.do" method="post">
<input type="hidden" name="board_num" value="${dto.board_num}"/>
<table class="list-table">
	<tr>
		<th>번호</th>
		<td>${dto.board_num}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${dto.user_nick}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="board_title" value="${dto.board_title}"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="board_content" id="ckeditor">${dto.board_content}</textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" class="buttonsignup actionbutton" value="수정완료"/>
			<button type="button" class="buttonsignup actionbutton" onclick="location.href='boardlist.do'">글목록</button>
		</td>
	</tr>
</table>
</form>
<script>
//id가 board_content인 태그에 ckeditor를 적용시킴
CKEDITOR.replace("ckeditor",{
    filebrowserUploadUrl : "/meatmall"+"/imageUpload.do",			//,width : '800px'
    width : '800px' , height : '500px'
}); //이미지 업로드 기능을 추가하기위한 코드

</script>
<br/><br/>
<jsp:include page="footer.jsp" />
</body>
</html>