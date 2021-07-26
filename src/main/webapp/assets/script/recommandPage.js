function randombtn(){
	if($('#random-frame').css("display")=="none"){
		$('#situ-frame').hide();
		$('#feel-frame').hide();
		$('#random-frame').show();
	}
	
}

function feelbtn(){
	if($('#feel-frame').css("display")=="none"){
		$('#random-frame').hide();
		$('#situ-frame').hide();
		$('#feel-frame').show();
	}
}

function situbtn(){
	if($('#situ-frame').css("display")=="none"){
		$('#random-frame').hide();
		$('#feel-frame').hide();
		$('#situ-frame').show();
	}
}



$(document).ready(function(){
$('.situation-box').click(function(){
	$(this).removeClass('clicked');
	$(this).addClass('clicked');
})
})

