<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <link href="apple-touch-icon.png" rel="apple-touch-icon">
    <link href="favicon.png" rel="icon">
    <meta name="author" content="Nghia Minh Luong">
    <meta name="keywords" content="Default Description">
    <meta name="description" content="Default keyword">
<title>헤더</title>
 <!-- Fonts-->
    <link href="https://fonts.googleapis.com/css?family=Archivo+Narrow:300,400,700%7CMontserrat:300,400,500,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="plugins/ps-icon/style.css">
    <!-- CSS Library-->
    <link rel="stylesheet" href="plugins/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="plugins/owl-carousel/assets/owl.carousel.css">
    <link rel="stylesheet" href="plugins/jquery-bar-rating/dist/themes/fontawesome-stars.css">
    <link rel="stylesheet" href="plugins/slick/slick/slick.css">
    <link rel="stylesheet" href="plugins/bootstrap-select/dist/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="plugins/Magnific-Popup/dist/magnific-popup.css">
    <link rel="stylesheet" href="plugins/jquery-ui/jquery-ui.min.css">
    <link rel="stylesheet" href="plugins/revolution/css/settings.css">
    <link rel="stylesheet" href="plugins/revolution/css/layers.css">
    <link rel="stylesheet" href="plugins/revolution/css/navigation.css">
    <!-- Custom-->
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="ps-loading">
    <div class="header--sidebar"></div>
    <header class="header">
      <div class="header__top">
        <div class="container-fluid">
          <div class="row">
                <div class="col-lg-6 col-md-8 col-sm-6 col-xs-12 ">
                  <p>주소</p>
                </div>
                <div class="col-lg-6 col-md-4 col-sm-6 col-xs-12 ">
                <c:choose>
					<c:when test="${ldto == null}">
						<c:if test="${loginError != null}">
							<script type="text/javascript">
							</script> 
					    </c:if>
						<div class="header__actions"><a href="loginPage.do">로그인</a></div>
        				<div class="header__actions"><a href="signUpPage.do">회원가입</a></div>
					</c:when>
					<c:otherwise>
						<div class="header__actions"><a href="#" class="user_info">${ldto.user_nick}님</a></div>
						<div class="header__actions"><a href="logout.do" class="logout">로그아웃</a></div>
						<c:if test="${ldto.user_role eq 'ADMIN'}">
							<div class="header__actions"><a href="logout.do" class="logout">관리자 페이지</a></div>
						</c:if>
						 <c:if test="${ldto.user_num != null }">
                  			<div class="header__actions"><a href="myPage.do">마이페이지</a></div>
                  			<div class="header__actions"><a href="messageList.do?pnum=1">쪽지</a></div>
                  	
                  		</c:if>
					</c:otherwise>
				</c:choose>  	                                              	            	
           </div>
          </div>
        </div>
      </div>
      <nav class="navigation">
        <div class="container-fluid">
          <div class="navigation__column left">
            <div class="header__logo"><a class="ps-logo" href="main.do"><img src="img/logo9.png" alt=""></a></div>
          </div>
          <div class="navigation__column center">
                <ul class="main-menu menu">                  
                   <li class="menu-item"><a href="allGoods.do?pnum=1">전체상품보기</a></li>
                  <li class="menu-item menu-item-has-children dropdown"><a href="#">괴기한우(도매)</a>
                     <ul class="sub-menu">
                     	<c:forEach items="${category}" var="dto">
                       	 <li class="menu-item"><a href="category.do">${dto.kind_name}</a></li>
                     	</c:forEach>
                     </ul>
                  </li>
                  <li class="menu-item menu-item-has-children dropdown"><a href="#">괴기한우(소매)</a>
                 	 <ul class="sub-menu">
                     	<c:forEach items="${category}" var="dto">
                       	 <li class="menu-item"><a href="category.do">${dto.kind_name}</a></li>
                     	</c:forEach>
                    </ul>
                  </li>                  
                  <li class="menu-item menu-item-has-children dropdown"><a href="boardlist.do?pnum=1">커뮤니티</a></li>
                  <li class="menu-item"><a href="recipe.do">레시피</a></li>
                  <li class="menu-item menu-item-has-children dropdown"><a href="#">고객센터</a>
                    <ul class="sub-menu">
                       <li class="menu-item"><a href="faqlist.do">자주묻는 질문</a></li>
                       <li class="menu-item"><a href="questionlist.do">1 : 1 문의</a></li>
                    </ul>
                  </li>
                </ul>
          </div>
          <div class="navigation__column right">
            <form class="ps-search--header" action="search.do" method="post">
              <input class="form-control" type="text" placeholder="검색…">
              <button><i class="ps-icon-search"></i></button>
            </form>
            <div class="ps-cart"><a class="ps-cart__toggle" href="basketList.do?user_num=${ldto != null ? ldto.user_num : '0'}"><span><i id="basketCount">${basketCount != null ? basketCount : '0'}</i></span><i class="ps-icon-shopping-cart"></i></a>
              <div class="ps-cart__listing">                                              
            </div>
            <div class="menu-toggle"><span></span></div>
          </div>
        </div>
      </nav>
    </header>
<div class="header-services">
      <div class="ps-services owl-slider" data-owl-auto="true" data-owl-loop="true" data-owl-speed="7000" data-owl-gap="0" data-owl-nav="true" data-owl-dots="false" data-owl-item="1" data-owl-item-xs="1" data-owl-item-sm="1" data-owl-item-md="1" data-owl-item-lg="1" data-owl-duration="1000" data-owl-mousedrag="on">
        <c:choose>
        	<c:when test="${empty noticeList}">
        		<p class="ps-service"><i class="ps-icon-delivery"></i><strong>공지가 없습니다.</strong></p>
        		<p class="ps-service"><i class="ps-icon-delivery"></i><strong>공지가 없습니다.</strong></p>
        	</c:when>
        	<c:otherwise>
	        	<c:forEach items="${noticeList}" var="dto">
			        <p class="ps-service"><i class="ps-icon-delivery"></i><strong>[공지]</strong> ${dto.board_title}</p>
		      	</c:forEach>
        	</c:otherwise>
        </c:choose>
      </div>
</div>




 <!-- JS Library-->
    <script type="text/javascript" src="plugins/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="plugins/bootstrap/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="plugins/jquery-bar-rating/dist/jquery.barrating.min.js"></script>
    <script type="text/javascript" src="plugins/owl-carousel/owl.carousel.min.js"></script>
    <script type="text/javascript" src="plugins/gmap3.min.js"></script>
    <script type="text/javascript" src="plugins/imagesloaded.pkgd.js"></script>
    <script type="text/javascript" src="plugins/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="plugins/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="plugins/jquery.matchHeight-min.js"></script>
    <script type="text/javascript" src="plugins/slick/slick/slick.min.js"></script>
    <script type="text/javascript" src="plugins/elevatezoom/jquery.elevatezoom.js"></script>
    <script type="text/javascript" src="plugins/Magnific-Popup/dist/jquery.magnific-popup.min.js"></script>
    <script type="text/javascript" src="plugins/jquery-ui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAx39JFH5nhxze1ZydH-Kl8xXM3OK4fvcg&amp;region=GB"></script><script type="text/javascript" src="plugins/revolution/js/jquery.themepunch.tools.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/jquery.themepunch.revolution.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/extensions/revolution.extension.video.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
<script type="text/javascript" src="plugins/revolution/js/extensions/revolution.extension.actions.min.js"></script>
    <!-- Custom scripts-->
    <script type="text/javascript" src="js/main.js"></script>           
</body>
</html>