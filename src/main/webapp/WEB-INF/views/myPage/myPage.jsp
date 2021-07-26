<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"	prefix="c" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
<jsp:include page="../template/header.jsp">
	<jsp:param value="마이페이지" name="title" />
</jsp:include>

<link rel="stylesheet" href="/movie/assets/style/myPageCss/myPage.css"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.search-btn {
	top: 7px !important;
}
</style>


        <div class="big-box">
        	<div class="coverBox">
                <!-- 초기 값은 커버사진 추가하기 버튼 -->
                <form id="userControllCover"  method="post" enctype="multipart/form-data">
               		<input type="file"  id="addCoverBtn" value="커버사진 추가하기" Accept="image/*"/>
          			<label for="addCoverBtn" class="coverAddLabel"></label>
                </form>
            </div>
            <div class="profileBox">
                <form  id="userControllProfile" method="post" enctype="multipart/form-data">
             		<input type="file"  id="addProfileBtn" value="프로필 추가하기" Accept="image/*" />
             	  <label for="addProfileBtn" class="profileAddLabel"></label>
                </form>
            </div>
            
			<div class="card_box">
				<div class="small-box" id="card-box1">
					<c:if test="${empty loginUser }">
						없음
					</c:if>
				
				<c:if test="${not empty loginUser }">
					<div class="info_box">
						<span class="info_txt">닉네임: </span><input type="text" class="inp_txt" id="nickName" value="${loginUser.user_nickname }" readonly onkeyup="nickCheck()"/>
						<input type="button" id="nickNameCheckbtn" class="check_btn inp_btn none" value="중복체크" onclick="fn_nickCheck()"/><br>
						<span class="info_txt"> 비밀번호 : <input type="password" id="pw" class="inp_txt" placeholder="현재 비밀번호를 입력하세요" readonly />
						<input type="button" id="pwCheckbtn" class="check_btn inp_btn none" value="확인" onClick="passWord()"/></span><br>
						<div class="pwCheck" style="display: none;">
							<span class="info_txt"> 새 비밀번호 : <input type="password" name="newpw" id="newPw1" placeholder="변경할 비밀번호를 입력하세요" onkeyup="pwRegCheck()"  /></span><br>
							<span class="normal" id="pwRegBox"></span><br> 
							<span class="info_txt"> 새 비밀번호 확인 : <input type="password" id="newPw2" placeholder="비밀번호를 확인해주세요." onkeyup="pwEqualCheck()"/></span><br>
							<div id="pwConfirm" class="normal" style="display: none; color=red;">비밀번호가 일치하지 않습니다.</div> <br>  
						</div>
						
						
						<span class="info_txt">이름: </span><input type="text" class="inp_txt" id="name" value="${loginUser.user_name }" readonly/><br>
						<span class="info_txt">이메일: </span><input type="text" class="inp_txt" id="email" value="${loginUser.user_email }" readonly onkeyup="emailCheck()"/>
						<input type="button" id="emailCheckbtn" class="check_btn inp_btn none" value="중복체크" onclick="fn_emailCheck()"/><br>
						<span class="info_txt">휴대폰 번호: </span><input type="text" class="inp_txt" id="phone" value="${loginUser.user_phone }" readonly/><br>
						<span class="info_txt">가입일: </span><input type="text" class="inp_txt" id="date" value="${loginUser.user_date }" readonly/><br>
					</div>
				</c:if>
				
				<input type="button" id="update" class="inp_btn update_btn none" value="수정하기" onclick="fn_userUpdate()">
				<input type="button" id="alter" class="inp_btn alter_btn" value="수정" onclick="fn_userAlter()">
				</div>
				<div class="small-box"  id="card-box2">
					위시리스트<br>
					<i class="fas fa-heart fa-2x"></i> + <span id="wishListCount">${wishListCount }</span>
				</div>
				<div class="small-box"  id="card-box3">
					내가 쓴 글<br>
					<i class="fas fa-pen fa-2x"></i> + <span id="commentListCount">${commentListCount }</span>
				</div>
				</div>
			</div>
    <%@ include file="../template/footer.jsp" %>
<script type="text/javascript">

function passWord() {
	
		const pw =$('#pw').val();
		
		const shaPw =SHA256(pw); 
 		  	 
			if(shaPw=='${loginUser.user_pw}'){
				swal({
				    title: "OK",
				    text: "비밀번호 확인에 성공했습니다. 비밀번호 변경을 진행해주세요",
				    icon: "success" //"info,success,warning,error" 중 택1
				});
				
					if($('.pwCheck').css("display")=="none"){
						$('.pwCheck').show();		
				}
   		 	}else{
   		 		swal({
				    title: "Failed",
				    text: "비밀번호 확인에 실패했습니다. 비밀번호를 확인해주세요.",
				    icon: "warning" //"info,success,warning,error" 중 택1
					});
		
	}
			
	
}


/* 비밀번호 유효성 체크  */
function pwRegCheck() {


	const regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	const pwVal = $('#newPw1').val();
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

	const pwVal = $('#newPw1').val();
	const pwCheck = $('#newPw2').val();
	const pwConfirm = $('#pwConfirm');
	if (pwCheck == '') {
		pwConfirm.css('display', 'none');
		return false;
	}
	
	 if (pwVal != pwCheck) {
		pwConfirm.css('display', 'block').text('비밀번호가 일치하지 않습니다.')
				.attr('class', 'impossible');
		return false;
	} else {
		pwConfirm.css('display', 'block').text('비밀번호가 일치합니다').attr(
				'class', 'possible');
		return true;
	}
}

	/* 유저정보 */
	let userNo = ${loginUser.user_no};
	
	let newPw1;
	let newPw2;
	let Pw;
	let nickName;
	let name;
	let email;
	let phone;
	
	function initValue(){
		
		pw = 	document.querySelector('#pw');	
		newPw1 = 	document.querySelector('#newPw1');	
		newPw2 = 	document.querySelector('#newPw2');
		nickName = document.querySelector('#nickName');
		name = document.querySelector('#name');
		email = document.querySelector('#email');
		phone = document.querySelector('#phone');
	}
	
	/* 기존 유저 정보 */
	
	let orPw;
	let orNewPw1;
	let orNewPw2;
	let orNickName;
	let orName;
	let orEmail;
	let orPhone;
	
	/* 버튼정보 */
	
	const updateBtn = document.querySelector('#update');
	const alterBtn = document.querySelector('#alter');
	const nickCheckBtn = document.querySelector('#nickNameCheckbtn');
	const emailCheckBtn = document.querySelector('#emailCheckbtn');
	const pwCheckbtn = document.querySelector('#pwCheckbtn');

	function valueClassReadOnly(controll){
		
		if(controll == 'remove'){
			alterBtn.value = '취소';

			updateBtn.classList.remove('none');
			nickCheckBtn.classList.remove('none');
			emailCheckBtn.classList.remove('none');
			pwCheckbtn.classList.remove('none');
	
			
		
			pw.removeAttribute('readonly');
			nickName.removeAttribute('readonly');
			name.removeAttribute('readonly');
			email.removeAttribute('readonly');
			phone.removeAttribute('readonly');
		}else{
			alterBtn.value = '수정';

			updateBtn.classList.add('none');
			nickCheckBtn.classList.add('none');
			emailCheckBtn.classList.add('none');
			pwCheckbtn.classList.add('none');
	
			
			
		
			pw.setAttribute('readonly','readonly');
			nickName.setAttribute('readonly','readonly');
			name.setAttribute('readonly' ,'readonly');
			email.setAttribute('readonly','readonly');
			phone.setAttribute('readonly','readonly');
		}
	}
	
	function fn_userAlter(){
		
		initValue();
		
		if(alterBtn.value == '수정'){
			
			
			orPw=pw.value;
			orNewPw1 = newPw1.value;
			/* orNewPw2 = newPw2.value; */
			orNickName = nickName.value;
			orName = name.value;
			orEmail = email.value;
			orPhone = phone.value;
			valueClassReadOnly('remove');
			
		}else{
			
			newPw1.value = orNewPw1;
			/* newPw2.value = orNewPw2; */
			pw.value = orPw;
			nickName.value = orNickName;
			name.value = orName;
			email.value = orEmail;
			phone.value = orPhone;
			
			valueClassReadOnly();
		}
		
	}

	
	/* 닉네임 체크 */
	function fn_nickCheck(){
			
			const userNick = nickName.value;
			
			if(orNickName == userNick){
				swal({
					   title: "CHeck!",
					   text: "기존 정보와 동일합니다.",
					   icon: "info" //"info,success,warning,error" 중 택1
					});
			/* 	alert('기존 정보와 동일합니다.'); */
				$('#nickNameCheckbtn').attr('disabled','true');
				return true;
			}
			
			
			if(userNick != null && userNick != ''){
			
				$.ajax({
					url: 'userNickCheck/' + userNick,
					type: 'post',
					dataType: 'json',
					success: function(responseJSON){
						if(responseJSON.nickCheckResult == 'yes'){
							swal({
								   title: "CHeck!",
								   text: "이 닉네임은 사용 가능합니다.",
								   icon: "info" //"info,success,warning,error" 중 택1
								});
							/* alert('이 닉네임은 사용 가능합니다.'); */
							$('#nickNameCheckbtn').attr('disabled','true');
							return true;
						}else{
							swal({
								   title: "CHeck!",
								   text: "사용 중인 닉네임입니다.",
								   icon: "info" //"info,success,warning,error" 중 택1
								});
							/* alert('사용 중인 닉네임입니다.'); */
							$('#nickname').focus();
							return false;
						}
					},
					error: function(){
						swal({
							   title: "CHeck!",
							   text: "오류.",
							   icon: "error" //"info,success,warning,error" 중 택1
							});
						
					}
					
				});
				
				return true;
			}
			
			if(userNick == ''){
				swal({
					   title: "CHeck!",
					   text: "닉네임을 입력해주세요.",
					   icon: "error" //"info,success,warning,error" 중 택1
					});
				/* alert('닉네임을 입력해주세요'); */
				$('#nickname').focus();
				return false;
			}
			
		}
	
	/* 텍스트 입력 시 disabled 해제 */
	function nickCheck(){
		$('#nickNameCheckbtn').removeAttr('disabled');
	}
	
	/* 이메일 체크 */
	function fn_emailCheck(){
		
		
		const userEmail = $('#email').val();
		
		if(orEmail == userEmail){
			swal({
				   title: "CHeck!",
				   text: "기존 정보와 동일합니다.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('기존 정보와 동일합니다.'); */
			$('#emailCheckbtn').attr('disabled','true');
			return true;
		}
		
		if(userEmail != null && userEmail != ''){
			
		
			$.ajax({
				url: 'userEmailCheck/' + userEmail + '/',
				type: 'post',
				dataType: 'json',
				success: function(responseJSON){
					if(responseJSON.emailCheckResult == 'yes'){
						swal({
							   title: "CHeck!",
							   text: "이 이메일은 사용 가능합니다.",
							   icon: "info" //"info,success,warning,error" 중 택1
							});
						/* alert('이 이메일은 사용 가능합니다.'); */
						$('#emailCheckbtn').attr('disabled','true');
						$('#phone').focus();
						return true;
					}else{
						swal({
							   title: "CHeck!",
							   text: "사용 중인 이메일입니다.",
							   icon: "info" //"info,success,warning,error" 중 택1
							});
						/* alert('사용 중인 이메일입니다.'); */
						$('#email').focus();
						return false;
					}
				},
				error: function(){
					swal({
						   title: "CHeck!",
						   text: "오류.",
						   icon: "error" //"info,success,warning,error" 중 택1
						});
				/* 	alert('오류'); */
				}
				
			});
		
			return true;
		}else{
			swal({
				   title: "CHeck!",
				   text: "이메일을 입력해주세요.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('이메일을 입력해주세요'); */
			$('#email').focus();
			return false;
		}
	}
	
	function emailCheck(){
		$('#emailCheckbtn').removeAttr('disabled');
	}
	
	
	function fn_userUpdate(){
		
		
		if($('#nickNameCheckbtn').attr('disabled') != 'disabled'){
			swal({
				   title: "CHeck!",
				   text: "닉네임 중복확인을 진행해 주세요.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('닉네임 중복확인을 진행해 주세요.'); */
			$('#nickName').focus();
			return;
		}
		
		if($('#name').val() == ''){
			swal({
				   title: "CHeck!",
				   text: "이름을 입력해 주세요.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('이름을 입력해 주세요'); */
			$('#name').focus();
			return;
		}
		
		if($('#emailCheckbtn').attr('disabled') != 'disabled'){
			swal({
				   title: "CHeck!",
				   text: "이메일 중복확인을 진행해 주세요.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('이메일 중복확인을 진행해 주세요.'); */
			$('#email').focus();
			return;
		}
		
		if($('#phone').val() == ''){
			swal({
				   title: "CHeck!",
				   text: "핸드폰 번호를 입력해 주세요.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('핸드폰 번호를 입력해 주세요'); */
			$('#phone').focus();
			return;
		}
		
		if($('#newPw1').val() == ''){
			swal({
				   title: "CHeck!",
				   text: "변경할 비밀번호를 입력해 주세요.",
				   icon: "info" //"info,success,warning,error" 중 택1
				});
			/* alert('변경할 비밀번호를 입력해 주세요'); */
			$('#newPw1').focus();
			return;
		}
		
		const sendUserObj = {
				"user_pw" : newPw1.value,
				"user_no": userNo,
				"user_nickname": nickName.value,
				"user_name": name.value,
				"user_email": email.value,
				"user_phone": phone.value
		}
		
/* 	if(confirm('정보를 변경하시겠습니까?')){
			$.ajax({
				url: "userUpdate.do",
				type: "post",
				data: JSON.stringify(sendUserObj),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function(responseObj){
					
					if(responseObj.updateResult){
						swal({
							   title: "CHeck!",
							   text: "정보가 수정되었습니다",
							   icon: "info" //"info,success,warning,error" 중 택1
							});
						/* alert('정보가 수정되었습니다.'); */
 /* 						newPw1.value = $('#newPw1').val();
						nickName.value = $('#nickName').val();
							name.value = $('#name').val();
						   email.value = $('#email').val();
						   phone.value = $('#phone').val();
						   valueClassReadOnly();
						   
					}else{
						swal({
							   title: "CHeck!",
							   text: "정보가 변경되지 않았습니다.",
							   icon: "error" //"info,success,warning,error" 중 택1
							});
					}
				}, 
				error: function(){
					swal({
						   title: "CHeck!",
						   text: "오류.",
						   icon: "error" //"info,success,warning,error" 중 택1
						});
				}
				
				
			}); */
	/* 	} */ 
		swal({
		    title: "Y/N?",
		    text: "정보를 변경하시겠습니까?",
		    icon: "warning",
		    buttons: ["NO", "YES"]
		}).then((YES) => {
		    if (YES) {
				$.ajax({
						url: "userUpdate.do",
						type: "post",
						data: JSON.stringify(sendUserObj),
						contentType: "application/json; charset=utf-8",
						dataType: "json",
						success: function(responseObj){
							
							if(responseObj.updateResult){
								swal({
									   title: "Success!",
									   text: "정보가 수정되었습니다",
									   icon: "success" //"info,success,warning,error" 중 택1
									});
								/* alert('정보가 수정되었습니다.'); */
		 						newPw1.value = $('#newPw1').val();
								nickName.value = $('#nickName').val();
									name.value = $('#name').val();
								   email.value = $('#email').val();
								   phone.value = $('#phone').val();
								   valueClassReadOnly();
								   
							}else{
								swal({
									   title: "CHeck!",
									   text: "정보가 변경되지 않았습니다.",
									   icon: "error" //"info,success,warning,error" 중 택1
									});
							}
						}, 
						error: function(){
							swal({
								   title: "CHeck!",
								   text: "오류.",
								   icon: "error" //"info,success,warning,error" 중 택1
								});
						}
						
						
					});				     
		    }else{
		        swal({
		    title: "Error",
		    text: "정보를 수정하지 못했습니다.",
		    icon: "error"		});
		    }
		});
		
	}
	
	/* 프로필 */
	$('#addProfileBtn').on('change',handleProfileAdd);
	
	function handleProfileAdd(event){
		console.log(123);
		let coverBox = document.querySelector('.profileBox');
		
		let formData = new FormData(document.querySelector('#userControllProfile'));

	    let filesTempArr = [];
		
		let files = event.target.files;
	    let filesArr = Array.prototype.slice.call(files);
	    let filesArrLen = filesArr.length;
	    filesTempArr.push(filesArr[0]);
	    
	    formData.append("userProfile", filesTempArr[0]);
	    formData.append("addProfile", 'true');
	    
	    let fileSize = event.target.files[0].size;
	    let maxSize = 10 * 1024 * 1024;//10MB
	    
	    
	    if(fileSize < maxSize){
	    	
		    $.ajax({
		    	url: 'userControllProfile.do',
		    	type: 'post',
		    	data: formData,
		    	processData: false,
		        contentType: false,
		        dataType: 'json',
		        success : function(responseObj) {
		            if(responseObj.result){
		            	let filename = decodeURI(responseObj.filename);
		                coverBox.style.backgroundImage = 'url(/movie/assets/images/userProfile/'+decodeURI(responseObj.filename) +')';
		        		document.querySelector('.profileAddLabel').innerText = '';
		            }else{
		                alert('123');
		            }
		        },
		        error : function(err) {
		            alert(err.status);
		        }
	
	
		    });
	    }else{
	    	swal({
	    		   title: "CHeck!",
	    		   text: "첨부 파일 사이즈 10MB 이내로 등록 가능합니다.",
	    		   icon: "warning" //"info,success,warning,error" 중 택1
	    		});
	    }

	}
	
	if('${loginUser.user_profile_name}' != 'none'){
		document.querySelector('.profileAddLabel').innerText = '';
		let filename = decodeURIComponent('${loginUser.user_profile_name}');
		document.querySelector('.profileBox').style.backgroundImage = 'url(/movie/assets/images/userProfile/' + filename+ ')';
	}
	
	/* 커버 */
		$('#addCoverBtn').on('change',handleCoverAdd);
	function handleCoverAdd(event){
		let coverBox = document.querySelector('.coverBox');
		
		let formData = new FormData(document.querySelector('#userControllCover'));

	    let filesTempArr = [];
		
		let files = event.target.files;
		console.log(files);
	    let filesArr = Array.prototype.slice.call(files);
		console.log(filesArr);
	    let filesArrLen = filesArr.length;
		console.log(filesArrLen);
	    filesTempArr.push(filesArr[0]);
	    
	    formData.append("userCover", filesTempArr[0]);
	    formData.append("addCover", 'true');
	    
	    let fileSize = event.target.files[0].size;
	    let maxSize = 10 * 1024 * 1024;//10MB
	    
	    
	    if(fileSize < maxSize){
	    	
		    $.ajax({
		    	url: 'userControllCover.do',
		    	type: 'post',
		    	data: formData,
		    	processData: false,
		        contentType: false,
		        dataType: 'json',
		        success : function(responseObj) {
		            if(responseObj.result){
		            	let filename = decodeURIComponent(responseObj.filename);
		                coverBox.style.backgroundImage = 'linear-gradient( rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3) ),url(/movie/assets/images/userCover/'+filename +')';
		        		document.querySelector('.coverAddLabel').innerText = '';
		            }else{
		                alert('123');
		            }
		        },
		        error : function(err) {
		            alert(err.status);
		        }
	
	
		    });
	    }else{
	    	swal({
	    		   title: "CHeck!",
	    		   text: "첨부 파일 사이즈 10MB 이내로 등록 가능합니다.",
	    		   icon: "warning" //"info,success,warning,error" 중 택1
	    		});
	    }

	}
	
	if('${loginUser.user_image_name}' != 'none'){
		document.querySelector('.coverAddLabel').innerText = '';
		let filename = decodeURIComponent('${loginUser.user_image_name}');
		document.querySelector('.coverBox').style.backgroundImage = 'linear-gradient( rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3) ), url(/movie/assets/images/userCover/' + filename+ ')';
	}
	
	
	// 내가쓴글
	$('#card-box3').on('click',handleMyWrite);
	
	function handleMyWrite(){
		
		if($('#commentListCount').text() == '0'){
			swal({
	    		   title: "Check!",
	    		   text: "등록된 코멘트가 없습니다!",
	    		   icon: "warning" //"info,success,warning,error" 중 택1
    		});
		}else{
			
			location.href='myWritePage.do';
		}
	}
	
	// 위시리스트
	$('#card-box2').on('click',handleMyWishList);
	
	function handleMyWishList(){
		
		if($('#wishListCount').text() == '0'){
			swal({
	    		   title: "Check!",
	    		   text: "등록된 위시리스트가 없습니다!",
	    		   icon: "warning" //"info,success,warning,error" 중 택1
    		});
		}else{
			location.href='wishList.do';
		}
	}
	
	
	/*sha256 적용 함수  */
function SHA256(s){
    
    var chrsz   = 8;
    var hexcase = 0;
  
    function safe_add (x, y) {
        var lsw = (x & 0xFFFF) + (y & 0xFFFF);
        var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
        return (msw << 16) | (lsw & 0xFFFF);
    }
  
    function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
    function R (X, n) { return ( X >>> n ); }
    function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
    function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
    function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
    function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
    function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
    function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
  
    function core_sha256 (m, l) {
         
        var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,
            0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
            0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,
            0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
            0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,
            0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
            0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,
            0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
            0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,
            0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
            0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);

        var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 
                   0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);

        var W = new Array(64);
        var a, b, c, d, e, f, g, h, i, j;
        var T1, T2;
  
        m[l >> 5] |= 0x80 << (24 - l % 32);
        m[((l + 64 >> 9) << 4) + 15] = l;
  
        for ( var i = 0; i<m.length; i+=16 ) {
            a = HASH[0];
            b = HASH[1];
            c = HASH[2];
            d = HASH[3];
            e = HASH[4];
            f = HASH[5];
            g = HASH[6];
            h = HASH[7];
  
            for ( var j = 0; j<64; j++) {
                if (j < 16) W[j] = m[j + i];
                else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
  
                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                T2 = safe_add(Sigma0256(a), Maj(a, b, c));
  
                h = g;
                g = f;
                f = e;
                e = safe_add(d, T1);
                d = c;
                c = b;
                b = a;
                a = safe_add(T1, T2);
            }
  
            HASH[0] = safe_add(a, HASH[0]);
            HASH[1] = safe_add(b, HASH[1]);
            HASH[2] = safe_add(c, HASH[2]);
            HASH[3] = safe_add(d, HASH[3]);
            HASH[4] = safe_add(e, HASH[4]);
            HASH[5] = safe_add(f, HASH[5]);
            HASH[6] = safe_add(g, HASH[6]);
            HASH[7] = safe_add(h, HASH[7]);
        }
        return HASH;
    }
  
    function str2binb (str) {
        var bin = Array();
        var mask = (1 << chrsz) - 1;
        for(var i = 0; i < str.length * chrsz; i += chrsz) {
            bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
        }
        return bin;
    }
  
    function Utf8Encode(string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
  
        for (var n = 0; n < string.length; n++) {
  
            var c = string.charCodeAt(n);
  
            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }
  
        }
  
        return utftext;
    }
  
    function binb2hex (binarray) {
        var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
        var str = "";
        for(var i = 0; i < binarray.length * 4; i++) {
            str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
            hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
        }
        return str;
    }
  
    s = Utf8Encode(s);
    return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
  
}

</script>
