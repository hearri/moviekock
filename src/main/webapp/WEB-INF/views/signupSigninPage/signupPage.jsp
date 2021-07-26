<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" /> -->
<link rel="stylesheet" href="/movie/assets/style/singupSigninPageCss/signupPage.css" />
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<!-- 버튼 부트스트랩 -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">1 -->
<!-- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" ></script> -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="signupPage_top_logo">
			<a href="mainPage.do"><img class="top_logo" alt="회원가입페이지 상단로고"
				src="/movie/assets/images/logo.jpg" /></a>
		</div>
		<div id="main-wrap">
			<form method="post">
				<div class="top_text txt">무비콕 정보를 입력해주세요</div>
				<div class="main">
					<div class="label_text txt">
						<label for="id"> 아이디</label><br />
					</div>
					<input type="text" name="id" id="id" class="inp_txt" placeholder="아이디를 입력해주세요." onkeyup="idRegCheck()" /> 
					<input type="button" id="idCheckbtn" class="inp_btn" value="중복확인" onclick="fn_idCheck(this.form)" /><br /> 
					<span class="normal" id="idRegBox"></span>

					<div class="label_text txt">
						<label for="pw"> 비밀번호</label><br /> 
					</div>
					<input type="password" name="pw" id="pw" class="inp_txt" placeholder="비밀번호를 입력해주세요." onkeyup="pwRegCheck()" /><br/>
					<span class="normal" id="pwRegBox"></span>
					<div class="label_text txt">
						<label for="pw2"> 비밀번호 확인</label>
					</div>
					<span id="pwCheck"></span>
					<input type="password" id="pw_check" class="inp_txt" placeholder="비밀번호를 확인해주세요." onkeyup="pwEqualCheck()" />
					<span id="pwCheck2"></span>
					<div id="pwConfirm" class="normal" style="display: none;"> 비밀번호가 일치하지 않습니다.</div>

					<div class="label_text txt">
						<label for="nickname"> 닉네임</label>
					</div>
					<input type="text" name="nickName" id="nickname" class="inp_txt" placeholder="닉네임을 확인해주세요." onkeyup="nickCheck()" /> 
					<input type="button" id="nickNameCheckbtn" class="inp_btn" value="중복확인" onclick="fn_nickCheck(this.form)" />

					<div class="label_text txt">
						<label for="name"> 이름</label>
					</div>
					<input type="text" name="name" id="name" class="inp_txt" placeholder="이름을 입력해주세요." />

					<div class="label_text txt">
						<label for="email"> 이메일</label>
					</div>
					<input type="text" name="email" id="email" class="inp_txt" placeholder="이메일을 입력해주세요." onkeyup="emailRegCheck()" /> 
					<input type="button" id="emailCheckbtn" class="inp_btn" value="중복확인" onclick="fn_emailCheck(this.form)" /><br/>
					<span class="normal" id="emailRegBox"> </span>
					<div class="label_text txt">
						<label for="phone"> 휴대전화</label>
					</div>
					<input type="text" name="phone" id="phone" class="inp_txt" placeholder="핸드폰 번호를 입력해주세요." />
				</div>
				<div class="bot_btn">
					<input type="button" class="inp_btn_bot" value="취소하기" onclick="fn_cancle(this.form)" /> 
					<input type="button" class="inp_btn_bot" onclick="fn_finish(this.form)" value="가입완료" />
				</div>
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		function fn_cancle(f) {
			/*(confirm("회원가입을 취소하시겠습니까?") == true) {  */
			if (confirm("회원가입을 취소하시겠습니까?") == true) {
				history.back();
			}
		}

		function fn_idCheck(f) {

			const userId = $('#id').val();

			if (!idRegCheck()) {
				swal({
				    title: "warning",
				    text: "아이디 양식에 맞춰주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				return;
			}
			if (userId != null && userId != '') {

				$.ajax({
					url : 'userIdCheck/' + userId,
					type : 'post',
					dataType : 'json',
					success : function(responseJSON) {
						if (responseJSON.idCheckResult == 'yes') {
							swal({
							    title: "OK",
							    text: "이 아이디는 사용 가능합니다",
							    icon: "info" //"info,success,warning,error" 중 택1
							});
							$('#idCheckbtn').attr('disabled', 'true');
							$('#pw').focus();
							return true;
						} else {
							swal({
							    title: "warning",
							    text: "사용 중인 아이디입니다.",
							    icon: "warning" //"info,success,warning,error" 중 택1
							});
							$('#id').focus();
							return false;
						}
					},
					error : function() {
						swal({
						    title: "Error",
						    text: "오류",
						    icon: "error" //"info,success,warning,error" 중 택1
						});
					}
				});
				return true;
			} else {
				swal({
				    title: "warning",
				    text: "아이디를 입력해주세요",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#id').focus();
				return false;
			}
		}
		function fn_nickCheck(f) {
			const userNick = $('#nickname').val();
			if (userNick != null && userNick != '') {
				$.ajax({
					url : 'userNickCheck/' + userNick,
					type : 'post',
					dataType : 'json',
					success : function(responseJSON) {
						if (responseJSON.nickCheckResult == 'yes') {
							swal({
							    title: "OK",
							    text: "이 닉네임은 사용 가능합니다.",
							    icon: "info" //"info,success,warning,error" 중 택1
							});
							$('#nickNameCheckbtn').attr('disabled', 'true');
							$('#name').focus();
							return true;
						} else {
							swal({
							    title: "warning",
							    text: "사용 중인 닉네임입니다.",
							    icon: "warning" //"info,success,warning,error" 중 택1
							});
							$('#nickname').focus();
							return false;
						}
					},
					error : function() {
						swal({
						    title: "Error",
						    text: "오류",
						    icon: "error" //"info,success,warning,error" 중 택1
						})
					}
				});
				return true;
			} else {
				swal({
				    title: "warning",
				    text: "닉네임을 입력해주세요",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#nickname').focus();
				return false;
			}
		}
		function fn_emailCheck(f) {
			const userEmail = $('#email').val();
			if (!emailRegCheck()) {
				swal({
				    title: "warning",
				    text: "이메일 양식에 맞춰주세요",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				return;
			}
			if (userEmail != null && userEmail != '') {
				$.ajax({
					url : 'userEmailCheck/' + userEmail + '/',
					type : 'post',
					dataType : 'json',
					success : function(responseJSON) {
						if (responseJSON.emailCheckResult == 'yes') {
							swal({
							    title: "OK",
							    text: "이 이메일은 사용 가능합니다.",
							    icon: "info" //"info,success,warning,error" 중 택1
							});
							$('#emailCheckbtn').attr('disabled', 'true');
							$('#phone').focus();
							return true;
						} else {
							swal({
							    title: "warning",
							    text: "사용 중인 이메일입니다..",
							    icon: "warning" //"info,success,warning,error" 중 택1
							});
							$('#email').focus();
							return false;
						}
					},
					error : function() {
						swal({
						    title: "Error",
						    text: "오류",
						    icon: "error" //"info,success,warning,error" 중 택1
						})
					}
				});
				return true;
			} else {
				swal({
				    title: "warning",
				    text: "이메일을 입력해주세요",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#email').focus();
				return false;
			}
		}
		
		function nickCheck() {
			$('#nickNameCheckbtn').removeAttr('disabled');
		}
		
		function idRegCheck() {
			const regId = /[0-9a-z]{5,20}$/;
			const idVal = $('#id').val();
			$('#idCheckbtn').removeAttr('disabled');
			if (regId.test(idVal)) {
				$('#idRegBox').attr('class', 'possible');
				$('#idRegBox').text('중복확인을 진행해 주세요.');
				return true;
			} else {
				$('#idRegBox').attr('class', 'impossible');
				$('#idRegBox').text('5~20자 사이의 소문자나 숫자를 사용해주세요.');
				return false;
			}
		}

		function pwRegCheck() {

			const regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
			const pwVal = $('#pw').val();
			pwEqualCheck();
			if (regPw.test(pwVal)) {
				$('#pwRegBox').attr('class', 'possible');
				$('#pwRegBox').text('사용 가능한 비밀번호 입니다.');
				return true;
			} else {
				$('#pwRegBox').attr('class', 'impossible');
				$('#pwRegBox').text('비밀번호는 8자 이상, 숫자/문자/특수문자를 모두 포함해야 합니다.');
				return false;
			}
		}

		function pwEqualCheck() {

			const pwVal = $('#pw').val();
			const pw_check = $('#pw_check').val();
			const pwConfirm = $('#pwConfirm');
			if (pw_check == '') {
				pwConfirm.css('display', 'none');
				return false;
			}
			if (pwVal != pw_check) {
				pwConfirm.css('display', 'block').text('비밀번호가 일치하지 않습니다.')
						.attr('class', 'impossible');
				return false;
			} else {
				pwConfirm.css('display', 'block').text('비밀번호가 일치합니다').attr(
						'class', 'possible');
				return true;
			}
		}

		function emailRegCheck() {
			const regEmail = /^[a-z0-9-_]+@[a-zA-Z0-9]{3,}(\.[a-zA-Z]{2,6}){1,2}$/;

			const emailVal = $('#email').val();
			$('#emailCheckbtn').removeAttr('disabled');

			if (regEmail.test(emailVal)) {
				
				$('#emailRegBox').attr('class', 'possible');
				$('#emailRegBox').text('중복확인을 진행해 주세요.');
				return true;
			} else {
				$('#emailRegBox').attr('class', 'impossible');
				$('#emailRegBox').text('이메일주소를 다시 확인해주세요.');
				return false;
			}
		}

		function fn_finish(f) {

			if ($('#idCheckbtn').attr('disabled') != 'disabled') {
				
				swal({
				    title: "Check!",
				    text: "아이디 중복확인을 진행해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#id').focus();
				return;
			}
			if (!pwRegCheck()) {
			
				swal({
				    title: "Check!",
				    text: "비밀번호를 확인해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#pw').focus();
				return;
			}
			if (!pwEqualCheck()) {

				swal({
				    title: "Check!",
				    text: "비밀번호를 확인해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#pw').focus();
				return;
			}
			if ($('#nickNameCheckbtn').attr('disabled') != 'disabled') {
		
				swal({
				    title: "Check!",
				    text: "닉네임 중복확인을 진행해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#nickname').focus();
				return;
			}
			if ($('#name').val() == '') {
				
				swal({
				    title: "Check!",
				    text: "이름을 입력해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#name').focus();
				return;
			}
			if ($('#emailCheckbtn').attr('disabled') != 'disabled') {
			
				swal({
				    title: "Check!",
				    text: "이메일 중복확인을 진행해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#email').focus();
				return;
			}
			if ($('#phone').val() == '') {
			
				swal({
				    title: "Check!",
				    text: "휴대폰 번호를 입력해 주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				$('#phone').focus();
				return;
			}
			f.action = 'userSignUp.do';
			f.submit();
		}

		function init() {
		}

		init();
	</script>
</body>
</html>