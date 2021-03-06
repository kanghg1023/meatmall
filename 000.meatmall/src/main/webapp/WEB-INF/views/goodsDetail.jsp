<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<style type="text/css">
.zoom{
height : 600px;
}
p.abc{
color: blue;
margin-bottom : 0px;
font-size: 20px;
font-weight : bold;
}
.def{
margin-bottom : 0px;
font-size: 20px;
}
.goodsbtn { 
   width: 40%;
    height: 40px;
    padding: 0;
    margin-bottom: 15px;
    margin-left: 4px;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
}

.leftright {
    width: 100%;
    height: 200px;   
}
#left {
    width: 45%;
    float: left;          
}
#right {
    width: 55%;
    float: right;        
}
#btn {
   width: 150px;
}
.ps-select button.btn{
   width:340px;
}
.basket_count{
margin:10px;
}
.bt_down{
   cursor:pointer;
}

.bt_up{
   cursor:pointer;
}


</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function() {
   
   $("#basket").click(function() {
	  if(${ldto.user_num == gdto.user_num}){
		  alert("본인이 등록한 상품은 담을 수 없습니다.");
		  return false;
	  }
	  
	  if(${ldto.user_id == null}){
	     location.href = "loginPage.do";
	     return false;
	  }
	  
      if($("#optionSelect").val() == "") {
         alert("옵션을 선택해주세요!");
         return false;
      }
      
      var option_num = $(".option_num").get();
      var basket_count = $(".basket_count").get();
      
      var optionArray = [];
      var countArray = [];
        
        $(option_num).each(function(i){//체크된 리스트 저장
           optionArray.push($(this).val());
        });
        
        $(basket_count).each(function(i){
           countArray.push($(this).val());
        });
        
      $.ajax({
         url:"insertBasket.do",
         data:{"user_num":"${ldto.user_num}"
         , "goods_num":"${gdto.goods_num}"
         , "option_num":optionArray
         , "basket_count":countArray},
         method:"post",
         datatype:"text",
         async:false,
         success:function(insertBasket){
        	 var a = insertBasket.split(",");
            if(a[0]){
               var basketCount = $("#basketCount").html();
               if(eval(basketCount)==eval(a[1])){
            	   alert("이미 장바구니에 담긴 옵션입니다.")
               }else{
            	   alert("추가했습니다.");
                   $("#basketCount").html(a[1]);    
               }
            }else {
               alert("error:추가실패");
            }
         },
         error:function(){
            alert("서버통신실패!!");
         }
      });
   });
   
 	$("form").submit(function(){
 		if(${ldto.user_num == gdto.user_num}){
 			  alert("본인이 등록한 상품은 구매할 수 없습니다.");
 			  return false;
 		  }
 		
		if(${ldto.user_id == null}){
			location.href = "loginPage.do";
			return false;
		}
	  
		if($("#optionSelect").val() == "") {
			alert("옵션을 선택해주세요!");
			return false;
		}
		
	});
   
   $("#optionSelect").change(function(){
      var aCount = document.getElementById("optionSelect"); //onum
      if(aCount.value == ""){
         return;
      }
      var option = aCount.value.split(",");
      var atext = document.getElementById(option[0]);
      var optionChk = document.getElementsByName("option_num");
      var optionChoice = document.getElementById("optionChoice");
      var sum = document.getElementById("sum");
      
      for(var i=0;i<optionChk.length;i++){
         if(option[0] == optionChk[i].value){
            alert("이미 선택된 옵션입니다.");
            return;
         }
      }
      
      
      optionChoice.innerHTML += "<em style='margin-right:20px;font-style:normal;font-size:18px;font-weight:bold;'>"+atext.text+"</em>"
      optionChoice.innerHTML += "<input type='hidden' name='option_num' class='option_num' value='"+option[0]+"' />";
      optionChoice.innerHTML += "<input type='hidden' name='option_weight' class='option_weight' value='"+option[1]+"' />";
      optionChoice.innerHTML += "<img src='img/minus.png' alt='수량감소' stlye='width:10px;height:10px;' class='bt_down' />";
      optionChoice.innerHTML += "<input type='text' name='basket_count' value='1' class='basket_count' style='width:30px;text-align:center;'/>";
      optionChoice.innerHTML += "<img src='img/plus.png' alt='수량증가' stlye='width:8px;height:8px;' class='bt_up'/>"
      optionChoice.innerHTML += "<input type='hidden' value='"+option[2]+"' /><br/>";
      
      if(sum.value == ""){
         sum.value = 0;
      }
      
      sum.value = eval(sum.value)+(option[1]/100*${gdto.goods_cost});
   });
   
   $("body").on("click",".bt_up",function(){
	  var count = $(this).next().val();
      var num = $(this).prev();
      var weight = $(this).prev().prev().prev().val();
      
      if(num.val() == count){
    	  alert("최대 구매 수량은 "+count+"개 입니다.");
    	  return;
      }
      
      num.val(parseInt(num.val())+1);
      var sum = $("#sum");
      
      sum.val(eval(sum.val())+(weight/100*${gdto.goods_cost}));
   });
   
   $("body").on("click",".bt_down",function(){
      var num=$(this).next();
      if(num.val() == 1){
         return;
      }
      var weight = $(this).prev().val();
      num.val(parseInt(num.val())-1);
      var sum = $("#sum");
      
      sum.val(eval(sum.val())-(weight/100*${gdto.goods_cost}));
   });
   
   $("body").on("change",".basket_count",function(){
		var num = $(this);
		var count = $(this).next().next().val();
		
		var str = /^[0-9]+$/;
		if(!(str.test(num.val()))){
			num.val(1);
		}
		
		if(num.val() > count){
			alert("최대 구매 수량은 "+count+"개 입니다.");
			num.val(count);
		}
		
	});
   
});   
</script>
</head>
<body>
<jsp:include page="header.jsp" />

<main class="ps-main">
      <div class="test">
        <div class="container">
          <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 ">
                </div>
          </div>
        </div>
      </div>
      <div class="ps-product--detail pt-60">
        <div class="ps-container">
          <div class="row">
            <div class="col-lg-10 col-md-12 col-lg-offset-1">
              <div class="ps-product__thumbnail">
                <div class="ps-product__preview">
                  <div class="ps-product__variants">
                    <div class="item"><img src="${gdto.goods_img_title}" alt=""></div>              
                  </div><a class="popup-youtube ps-product__video" href="https://www.youtube.com/watch?v=CP3qzW16QKA"><img src="images/shoe-detail/1.jpg" alt=""><i class="fa fa-play"></i></a>
                </div>                                          
                <div class="ps-product__image">
                  <div class="item"><img class="zoom a" src="${gdto.goods_img_title}" alt="" data-zoom-image="${gdto.goods_img_title}"></div>
                </div>
              </div>
              <div class="ps-product__thumbnail--mobile">
                <div class="ps-product__main-img"><img src="${gdto.goods_img_title}" alt=""></div>
              </div>
              
           <form action="insertOrderForm.do" method="post">
           	<input type="hidden" name="user_num" value="${ldto.user_num}" /> 
              <div class="ps-product__info">
<!--  별점 -->
<!--                 <div class="ps-product__rating"> -->
<!--                   <select class="ps-rating"> -->
<!--                     <option value="1">1</option> -->
<!--                     <option value="1">2</option> -->
<!--                     <option value="1">3</option> -->
<!--                     <option value="1">4</option> -->
<!--                     <option value="2">5</option> -->
<!--                   </select><a href="#">(Read all 8 reviews)</a> -->
<!--                 </div> -->
                <h1>${gdto.goods_title}</h1>
                <br />
                <div>
                <div id="left" class="leftright">
                   <p class="abc">판매자</p>
                   <p class="abc">100g당 가격</p>
                   <p class="abc">브랜드</p>
                   <hr style="border: none;border: 2px solid red;margin-bottom: 20px;"/>
                   <p class="abc">총 상품금액</p> 
                </div>
                <div id="right" class="leftright">
                   <p class="def">${gdto.user_nick}</p>
                   <p class="def">${gdto.goods_cost}</p>
                   <p class="def">${gdto.user_nick}</p>                   
                   <hr style="border: none;border: 2px solid red;margin-bottom: 20px;width:145px;"/> 
                   <input type="text" id="sum" name="sum" size="11" readonly="readonly" style="width:130px;border: none;font-size:20px;"><span>원</span>                 
                </div>                                     
                </div>  
                <div class="ps-product__block ps-product__size">             
            <select class="ps-select selectpicker" id="optionSelect">
               <option value="" style="width: 340px;">옵션 선택</option>
            <c:forEach items="${oList}" var="dto">
            	<c:choose>
            		<c:when test="${dto.option_count < 1}">
            			<option id="${dto.option_num}" value="품절" disabled>${dto.option_name} 품절</option>
            		</c:when>
            		<c:otherwise>
            			<option id="${dto.option_num}" value="${dto.option_num},${dto.option_weight},${dto.option_count}">${dto.option_name}</option>
            		</c:otherwise>
            	</c:choose>
            </c:forEach>
            </select>
            <div id="optionChoice">
            </div>                             
                </div>
                
                <div class="ps-product__shopping">
                   <input type="button" id="basket" class="goodsbtn" value="장바구니 담기">
                   <input type="submit" id="buy" class="goodsbtn" value="바로구매">              
                </div>
                <div>
               <input type="button" 
               onclick="window.open
               ('https://www.mtrace.go.kr/mtracesearch/cattleNoSearch.do?btsProgNo=0109008401&btsActionMethod=SELECT&cattleNo=002117250633'
               ,'beef traceability system','width=800px,height=900px,location=no,status=no,scrollbars=no')" class="goodsbtn" value="축산물이력정보"> 
            <input type="button" onclick="location.href='allGoods.do?pnum=${pnum}'" class="goodsbtn" value="제품목록"> 
                </div>
                <div>
                <c:if test="${gdto.user_num == ldto.user_num || ldto.user_role eq 'ADMIN'}">
                   <input type="button" onclick="location.href='upGoodsForm.do?goods_num=${gdto.goods_num}'" class="goodsbtn" value="상품 수정">
             		<input type="button" onclick="location.href='delAllGoods.do?chk=${gdto.goods_num}&pnum=${pnum}'" name="delBtn" class="goodsbtn" value="상품 삭제">
                </c:if>
                </div>
              </div>
           </form>
           
              <div class="clearfix"></div>
              <div class="ps-product__content mt-50">
                <ul class="tab-list" role="tablist">
                  <li class="active"><a href="#tab_01" aria-controls="tab_01" role="tab" data-toggle="tab">상세 내용</a></li>
                  <li><a href="#tab_02" aria-controls="tab_02" role="tab" data-toggle="tab">리뷰</a></li>
                </ul>
              </div>
              <div class="tab-content mb-60">
                <div class="tab-pane active" role="tabpanel" id="tab_01">
                  <p style="text-align: center;">${gdto.goods_img_detail}</p>
                </div>
                <div class="tab-pane" role="tabpanel" id="tab_02">
                  <div class="ps-review">
                    <div class="ps-review__thumbnail"><img src="images/user/1.jpg" alt=""></div>
                    <c:choose>
                    	<c:when test="${empty rList}">
                    		
                    	</c:when>
                    	<c:otherwise>
                    		<c:forEach items="${rList}" var="dto">
                    			<div class="ps-review__content">
			                      <header>
			                        <select class="ps-rating">
			                        	<c:forEach var="i" begin="1" end="5" step="1" >
			                        		<c:choose>
			                        			<c:when test="${i==dto.review_score}">
			                        				<option value="${i}" selected>${i}</option>
			                        			</c:when>
			                        			<c:otherwise>
			                        				<option value="${i}">${i}</option>
			                        			</c:otherwise>
			                        		</c:choose>
			                        	</c:forEach>
			                        </select>
			                        <p>By<a href="#">${dto.user_nick}</a><fmt:formatDate value="${dto.review_date}" pattern="yy-MM-dd [hh:mm]"/></p>
			                      </header>
			                      <p>${dto.review_content}</p>
			                    </div>
                    		</c:forEach>
                    	</c:otherwise>
                    </c:choose>
                  </div>
                </div>               
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
<jsp:include page="footer.jsp" />     
</body>
</html>