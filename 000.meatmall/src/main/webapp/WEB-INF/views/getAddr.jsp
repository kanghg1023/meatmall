<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title>주소 검색</title>
<style type="text/css">
#keyword {
   height: 24px;
    width: 65%;
    padding:0 5px;
    margin-bottom:10px;
    border: 1px solid #9da3a6;
    background: #fff;
    border-radius: 5px;
    margin: 0;
}

#addr { 
   width: 30%;
    height: 30px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
}
#juso {
   width : 350px;
   height : 110px;
   padding : 1px 0px 5px 10px;
   margin-top : 10px;
   background-color: #F7F9FA;
}
#zipNo {
   color: red;
   font-size: 15px;
   margin: 5px;
}
#alink {
   font-size: 14px;
   margin: 5px;
}
img {
   width : 40px;
   height : 12px;
   margin: 0px;
   padding: 0px;
}
#jibun {
   font-size: 14px;
}
</style>
<script type="text/javascript">
function getAddr(){
   // 적용예 (api 호출 전에 검색어 체크)    
   if (!checkSearchedWord(document.form.keyword)) {
      return ;
   }

   $.ajax({
       url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
      ,type:"post"
      ,data:$("#form").serialize()
      ,dataType:"jsonp"
      ,crossDomain:true
      ,success:function(jsonStr){
         $("#list").html("");
         var errCode = jsonStr.results.common.errorCode;
         var errDesc = jsonStr.results.common.errorMessage;
         if(errCode != "0"){
            alert(errCode+"="+errDesc);
         }else{
            if(jsonStr != null){
               makeListJson(jsonStr);
            }
         }
      }
       ,error: function(xhr,status, error){
          alert("에러발생");
       }
   });
}

function makeListJson(jsonStr){
   var htmlStr = "";
   $(jsonStr.results.juso).each(function(){
      htmlStr += "<div id='juso'>";      
      htmlStr += "<p id='zipNo'>"+this.zipNo+"</p>";
      htmlStr += "<img src='img/도로명.png'><a href='#' id='alink'>"+this.roadAddr+"</a><br />";
      htmlStr += "<p id='jibun'><img src='img/지번.png'>"+this.jibunAddr+"</p>";
      htmlStr += "</div>";
   });
   $("#list").html(htmlStr);
}

//특수문자, 특정문자열(sql예약어의 앞뒤공백포함) 제거
function checkSearchedWord(obj){
   if(obj.value.length >0){
      //특수문자 제거
      var expText = /[%=><]/ ;
      if(expText.test(obj.value) == true){
         alert("특수문자를 입력 할수 없습니다.") ;
         obj.value = obj.value.split(expText).join(""); 
         return false;
      }
      
      //특정문자열(sql예약어의 앞뒤공백포함) 제거
      var sqlArray = new Array(
         //sql 예약어
         "OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC",
                    "UNION",  "FETCH", "DECLARE", "TRUNCATE" 
      );
      
      var regex;
      for(var i=0; i<sqlArray.length; i++){
         regex = new RegExp( sqlArray[i] ,"gi") ;
         
         if (regex.test(obj.value) ) {
             alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
            obj.value =obj.value.replace(regex, "");
            return false;
         }
      }
   }
   return true ;
}

function enterSearch() {
   var evt_code = (window.netscape) ? ev.which : event.keyCode;
   if (evt_code == 13) {    
      event.keyCode = 0;  
      getAddr(); //jsonp사용시 enter검색 
   } 
}

$(function(){
   $("body").on("click","a",function(){
       var addr = $("#user_addr",opener.document);
       var addr_detail = $("#user_addr_detail",opener.document);
       
       addr.val($(this).text());
       $(opener.location).attr("href", "javascript:addrChkfun();");
       addr_detail.focus();
      
       self.close();
   });
});

</script>
</head>
<body>
<form name="form" id="form" method="post">
   <input type="hidden" name="currentPage" value="1"/> <!-- 요청 변수 설정 (현재 페이지. currentPage : n > 0) -->
   <input type="hidden" name="countPerPage" value="10"/><!-- 요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100) -->
   <input type="hidden" name="resultType" value="json"/> <!-- 요청 변수 설정 (검색결과형식 설정, json) --> 
   <input type="hidden" name="confmKey" value="devU01TX0FVVEgyMDE5MTAyOTE1MjkwNDEwOTE0NzQ="/><!-- 요청 변수 설정 (승인키) -->
   <input type="text" name="keyword" id="keyword" value="" onkeydown="enterSearch();"/><!-- 요청 변수 설정 (키워드) -->
   <input id="addr" type="button" onClick="getAddr();" value="주소검색하기"/>
   <div id="list" ></div><!-- 검색 결과 리스트 출력 영역 -->
</form>

</body>
</html>