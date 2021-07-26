<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:include page="../template/header.jsp">
 	<jsp:param value="랜덤 추천" name="title" />
</jsp:include>

<script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>

<link rel="stylesheet" href="/movie/assets/style/recommandPageCss/recommandPage.css" />

<script type="text/javascript">
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
function fn_random(){
	location.href="recommandRandomPage.do"
}
function fn_tag(f){
	/* location.href="recommand_random_page.do" */
	f.action="recommandSituPage.do"
	/* f.submit(); */
	tag.selectedValue.value=$('situation-box').val();
	
	document.tag.subit();
}
$(document).ready(function(){
	$('.situation-box').click(function(){
		$(this).removeClass('clicked');
		$(this).addClass('clicked');
	})
})
function goTagsSearch(){
	location.href="recommandSituPage.do"
	
}
function movieResult(url){
	var ajaxOption = {
			url : url,
			async : true,
			type : "POST",
			dataType : "html",
			cache : false
	};
	
	$.ajax(ajaxOption).done(function(data){
		$('#movie-box').children().remove();
		$('#movie-box').html(data);
	});
}
function showImage(){
	var imgNum= Math.round(Math.ramdom()*3);
	var objImg = document.getElementById("introImg");
	
	var imgArray=new Array(); 
	imgArray[0]="assets/images/emoticon/angry.png"; 
	imgArray[1]="assets/images/emoticon/cold.png"; 
	imgArray[2]="assets/images/emoticon/crying.png"; 
	imgArray[3]="assets/images/emoticon/disappointment.png";
	objImg.src = imgArray[imgNum];
	setTimeout(showImage,5000);
	
}

rdbtn.onclick = function() {
	  stripe.classList.add('animate');
	};
</script>

 <div class="recommand_wrap">
       	<div class="recommand_main">
	     	<div class="recommand_header">
		   		<div id="heading"></div>
	        	<div class="topmenu">
	        		<input type="button" class="menu-button b1" value="랜덤 추천" onclick="randombtn()" />
	        		<input type="button" class="menu-button b2" value="기분별 추천" onclick="feelbtn()" />
	        		<input type="button" class="menu-button b3" value="상황별 추천" onclick="situbtn()" />
	        	</div>
	        </div>
	        <form >
	         <div id="random-frame" class="display" onload="showImage()">
	         
	        		<div id="movie-box" >
	            		<img id="introImg" src="assets/images/random_image.jpg"/>
	        		</div>
	        		<input id="rdbtn" class="rdbtn" type="button" value="추천 받기" onclick="movieResult('recommandRandomPage.do')"/>
	      	   </div>
	       </form>
	      	  
	       	<form action="">
	       	 	<div id="feel-frame" class="display">
	       			<div id="emoticon-frame">
	            		<div class="emoticon-box">
	                		<img src="assets/images/emoticon/angry.png" alt="angry"/>                                          
	           			</div>
	            		<div class="emoticon-box">
	         	    		<img src="assets/images/emoticon/cold.png" alt="cold"/>   
	            		</div>
	            		<div class="emoticon-box">
							<img src="assets/images/emoticon/crying.png" alt="crying"/>
	            		</div>
	            		<div class="emoticon-box">
	          				<img src="assets/images/emoticon/disappointment.png" alt="disappointment"/>
	            		</div>
	            		<div class="emoticon-box">
	        				<img src="assets/images/emoticon/rolling-eyes.png" alt="rolling-eyes"/>
	            		</div>
	            		<div class="emoticon-box">
	           				<img src="assets/images/emoticon/shocked.png" alt="shocked"/>
	            		</div>
	            		<div class="emoticon-box">
	             			<img src="assets/images/emoticon/smile.png" alt="smile"/>
	            		</div>
	            		<div class="emoticon-box">
	             			<img src="assets/images/emoticon/smiling.png" alt="smiling"/>
	            		</div>
	            		<div class="emoticon-box">
	             			<img src="assets/images/emoticon/yummy.png" alt="yummy"/>
	            		</div>
	             		<div class="emoticon-box">
	             			<img src="assets/images/emoticon/sleeping.png" alt="sleeping"/>
	            		</div>
	        		</div>
	        		<input class="fbtn" type="button" value="추천 받기" onclick="fn_feel(this.form)"/>
	    	  </div>
	    	 	</form>
	      
	      <form id="tag">
	        <div id="situ-frame" class="display">
	        	<div id="tag-frame">
					<div class="situation-box" name="tag1" value="썸" onclick="goTagsSearch('썸')">#썸</div>
	                <div class="situation-box" id="tag2">#혼술</div>
	                <div class="situation-box" id="tag3">#지방출장</div>
	                <div class="situation-box" id="tag4">#새해</div>
	                <div class="situation-box" id="tag5">#여행</div>
	                <div class="situation-box" id="tag6">#카페</div>
	                <div class="situation-box" id="tag7">#성공</div>
	                <div class="situation-box" id="tag8">#생일파티</div>
	                <div class="situation-box" id="tag9">#불금</div>
	                <div class="situation-box" id="tag10">#이별했을 때</div>
	                <div class="situation-box" id="tag11">#새벽감성</div>
	                <div class="situation-box" id="tag12">#클래식</div>
	                <div class="situation-box" id="tag13">#코로나</div>
	                <div class="situation-box" id="tag14">#싸움</div>
	                <div class="situation-box" id="tag15">#의지활활</div>
	                <div class="situation-box" id="tag16">#공부</div>
	                <div class="situation-box" id="tag17">#기분전환</div>
	                <div class="situation-box" id="tag18">#출/퇴근길</div>
	                <div class="situation-box" id="tag19">#운동</div>
	                <div class="situation-box" id="tag20">#하우스파티</div>
	                <div class="situation-box" id="tag21">#해외</div>
	                <div class="situation-box" id="tag22">#차박</div>
	                <div class="situation-box" id="tag23">#루프탑</div>  
	        	</div>
	        	<input class="tgbtn"type="button" onclick="fn_tag(this.form)"value="추천 받기"/>
	    	</div>
	 		
	 	</form>
    </div>
  </div>

<%@ include file="../template/footer.jsp" %>