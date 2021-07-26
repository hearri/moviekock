<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<body>

	<form id="signUpAction" method="post" action="signupChoicePage.do">
		<input type="hidden" name="no" value="${loginUser.user_no }">
	</form>

<script>

	if(${signUp}){
		swal({
		    title: "Info",
		    text: "${loginUser.user_nickname}님 환영합니다.",
		    icon: "info" //"info,success,warning,error" 중 택1
		});
		
		document.querySelector('#signUpAction').submit();
	}else if (${loginResult}) {
		swal({
		    title: "Info",
		    text: "${loginUser.user_nickname}님 환영합니다.",
		    icon: "info" //"info,success,warning,error" 중 택1
		});
		location.href='index.do';
	}else{
		/*  swal({
		    title: "Warning",
		    text: "일치하는 회원이 없습니다.",
		    alert("일치하는 회원이 없습니다.");
		    icon: "warning" //"info,success,warning,error" 중 택1
		});*/
		
		  alert("일치하는 회원이 없습니다.");
		location.href='loginPage.do';
	}
	
	
</script>
</body>
</html>

