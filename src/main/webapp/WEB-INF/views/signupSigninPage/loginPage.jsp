<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
  <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
  <link rel="stylesheet" href="/movie/assets/style/singupSigninPageCss/loginPage.css"/>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body>
  <div class="main-wrapper">
  	
    <div class="logo">
     <a href="mainPage.do"><img class="loginPage_logo" src="assets/images/logo.jpg"/></a>
    </div>
  
    	<div class="header">
      	<div class="heading txt">로그인</div>
      	<div class="heading-contents txt">무비콕에 오신 걸 환영합니다.</div>
    	</div>
    	<div class="control-form">
     	 <form class="login-form" id="loginForm" name="loginForm" method="post">
        	<input type="text" class="login-input txt" id="id" name="id" placeholder="아이디" />
        	<input type="password" class="login-input txt" id="pw" name="pw" placeholder="비밀번호" onkeypress="if(event.keyCode == 13){ loginOk(); return; }" />
        	<input type="checkbox" name="rememberId" id="rememberId"/>
        	<label for="rememberId" class="txt">아이디 저장</label>
        	<input type="button" value="로그인" class="login-btn" onclick="fn_login(this.form)" />
      	</form>
    	</div>
    	<div class="footer">
      	<a href="/movie/findIdpwPage.do"><span class="footer-link id-pw txt">아이디 / 비밀번호 찾기</span></a>
      	<a href="#" data-target="#layerpop" data-toggle="modal"><span class="footer-link signUp txt">회원가입</span></a>
    	</div>
  </div>

<script type="text/javascript">
	
	
	// 아이디 저장 눌렀을때 아이디 기억하기
	window.onload = function(){
		if("${cookie.id.value}" != ""){
			document.querySelector('#id').value ="${cookie.id.value}";
			document.querySelector('#rememberId').checked = true;
		}
		
	}

	// 로그인 버튼을 직접 마우스로 눌렀을 때
	function fn_login(f){
		if(f.id.value == '' || f.pw.value == ''){
			swal({
			    title: "Warning",
			    text: "아이디와 비밀번호를 모두 입력하세요'.",
			    icon: "warning" //"info,success,warning,error" 중 택1
			});
	
			return;
		} else {
			f.action="login.do";
			f.submit();
		}
	}
	
	// 로그인 버튼을 enter key 로 바로 눌렀을때
	function loginOk() {

		var f = document.loginForm;


		if(f.id.value == '' ) {

			swal({
			    title: "Warning",
			    text: "아이디를 입력하세요.",
			    icon: "warning" //"info,success,warning,error" 중 택1
			});

		return false;

		}

		if(f.pw.value == '' ) {

			swal({
			    title: "Warning",
			    text: "비밀번호를 입력하세요.",
			    icon: "warning" //"info,success,warning,error" 중 택1
			});

		return false;

		}

		f.action="login.do";

		f.submit();

		}
	
</script>

  <!-- modal -->
  <div class="modal fade" id="layerpop" >
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- header -->
        <div class="modal-header">
          <!-- 닫기(x) 버튼 -->
          <button type="button" class="close btn btn-info" data-dismiss="modal">×</button>
          <!-- header title -->
          <h4 class="modal-title">개인 정보 수집 · 이용에 대한 동의</h4>
        </div>
        <!-- body -->
        <div class="modal-body">
            <%@ include file="privacyAgreementPage.jsp" %>
        </div>
        <!-- Footer -->
        <div class="modal-footer">
          <input type="button" id="close-btn" class="modal-close" data-dismiss="modal" value="닫기" />
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>