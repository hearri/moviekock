<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>계정 찾기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/movie/assets/style/common.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/movie/assets/style/singupSigninPageCss/findIdpwPage.css"	/>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<script type="text/javascript">
	function fn_findId(f){
		if(f.user_name.value == '' || f.user_email.value == ''){
			
			swal({
			    title: "Check!",
			    text: "필요한 정보를 전부 입력 해주시기 바랍니다.",
			    icon: "warning" //"info,success,warning,error" 중 택1
			});
			
			return;
		} else {
			f.action="findId.do";
			f.submit();
		}
	}
	
	function fn_findPw(f){
		if(f.user_name.value == '' || f.user_email.value == '' || f.user_id.value == ''){
			
			swal({
			    title: "Check!",
			    text: "필요한 정보를 전부 입력 해주시기 바랍니다.",
			    icon: "warning" //"info,success,warning,error" 중 택1
			});
			
			return;
		} else {
			f.action="findPw.do";
			f.submit();
		}
	}
</script>
	<div class="id-pw-main-wrapper">


    <div class="logo-wrapper">
      <div class="logo-px">
        <a href="mainPage.do"><img class="findPage_logo" src="assets/images/logo.jpg"/></a>
      </div>
    </div>


		<div class="contents-wrapper">
			<div class="id-pw-form-box">

				<div class="id-section">
					<div class="id-section-header section-header txt">아이디 찾기</div>
					<div class="id-form-control-box section-form">
						<form method="post">
							<input type="text" class="input-id inputs" id="input-name" name="user_name" placeholder="이름을 입력해 주세요." autocomplete="off" />
							<input type="text" class="input-id-email inputs" id="input-id-email" name="user_email" placeholder="이메일을 입력해 주세요." autocomplete="off" />
							<input type="button" class="inp_btn" onclick="fn_findId(this.form)" value="아이디 찾기" />
						</form>
					</div>
				</div>

				<div class="pw-section">
					<div class="pw-section-header section-header txt">비밀번호 찾기</div>
					<div class="pw-form-control-box section-form">
						<form method="post">
							<input class="input-pw-name inputs" name="user_name" placeholder="이름을 입력해 주세요." autocomplete="off" />
							<input type="text" class="input-pw-email inputs" name="user_email" placeholder="이메일을 입력해 주세요." autocomplete="off" />
							<input type="text" class="input-pw-id inputs" name="user_id" placeholder="아이디를 입력해 주세요." autocomplete="off" />
							<input type="button" class="inp_btn" onclick="fn_findPw(this.form)" value="비밀번호 찾기" />
						</form>
					</div>
				</div>

			</div>

		</div>


	</div>

	<%@ include file="../template/footer.jsp"%>
