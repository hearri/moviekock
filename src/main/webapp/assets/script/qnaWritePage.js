let secret = document.querySelector('#pw');
let btn = document.querySelector('#secret');

function btnHandler(){

	if(secret.className == 'display-none'){
	   secret.classList.replace('display-none' , 'display-block');
	} else {
		secret.classList.replace('display-block' , 'display-none');
	}

}

function init(){
	btn.addEventListener('click', btnHandler);	
}
	
init();
	
function fn_sendClick(f){

	if ($('#title').val() == '') {
		swal({
			title: "error",
			text: "제목을 입력해 주세요.",
			icon: "error" //"info,success,warning,error" 중 택1
		});
		$('#title').focus();
		return;
	}
	
	if ($('#content').val() == '') {
		swal({
			title: "error",
			text: "내용을 입력해 주세요.",
			icon: "error" //"info,success,warning,error" 중 택1
		});
		$('#content').focus();
		return;
	}	

	f.action = 'qnaWrite.do';
	f.submit();

}