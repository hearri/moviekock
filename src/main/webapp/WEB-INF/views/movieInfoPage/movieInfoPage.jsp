<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    
<jsp:include page="../template/header.jsp">
	<jsp:param value="영화 상세페이지" name="title" />
</jsp:include>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
<link rel="stylesheet" href="/movie/assets/style/movieInfoPageCss/movieInfoPage.css"/>

<link rel="shortcut icon" href="#">

<c:if test="${empty movieDto }">
	영화정보 없음!
</c:if>

<c:if test="${not empty movieDto }">
	<div class="wrap">

		<div class="main">
			<div class="info_main_top">
			<div class="snap_background_left"></div>
				<img alt="스냅샷" class="snap" src="/movie/assets/images/snap/${movieDto.movie_title}_스냅샷.jpg" />
			<div class="snap_background_right"></div>
			</div>
			<div class="info_main_mid">
		        <div class="info_main_mid_left info_main_mid_box">
		          <div class="movie_poster" style="background-image: url('/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg')">
	
		          </div>
		        </div>
		        <div class="info_main_mid_mid">
		          <div class="info_main_mid_mid_title">
		            ${movieDto.movie_title.replaceAll("_"," ")}
		          </div>
		          <div class="info_main_mid_mid_contents">
		            <span class="movie_info_main"> ${movieDto.genre_name } • ${movieDto.movie_nation } </span><br>
		            <span class="movie_info_opendate deco">개봉일 : ${movieDto.movie_opening_date } 누적관객 : ${movieDto.movie_audience }</span><br>
		            <span class="movie_info_score deco">평점 <span id="littleStar">★</span> <c:if test="${fn:length(movieDto.movie_web_score) == 1 }">
																			${ movieDto.movie_web_score}.0
																	 </c:if>
																	 <c:if test="${fn:length(movieDto.movie_web_score) > 1 }">
																			${ movieDto.movie_web_score}
																	 </c:if></span>
		          </div>
		        </div>
		        <div class="info_main_mid_right">
		          <div class="my-rating-contents">평가하기
				 	 <div id="star-rating"></div></div>
		        <c:if test="${empty isWishList }">
		            <button class="wish-comments" id="wish">+ 위시리스트</button>
		        </c:if>
		        <c:if test="${not empty isWishList }">
		        	<c:if test="${isWishList > 0}">
			            <button class="wish-comments" id="wish">- 위시리스트</button>
		        	</c:if>
		        	<c:if test="${isWishList == 0}">
			            <button class="wish-comments" id="wish">+ 위시리스트</button>
		        	</c:if>
		        </c:if>
		            <!-- modal comment -->
					<div class="comment_top_right">
						<%@ include file="../template/modalComment.jsp" %>
					</div>
		        </div>
			</div>
			<div class="info_main_bot">
				<div class="info_main_bot_basic_info">
					<div class="main_bot_top">
						<a class="main_bot_top_font txt">기본정보</a>
					</div>
					<br/>
					<div class="main_bot_bot">
						<span class="txt">${movieDto.movie_story }
						</span>
					</div>
				</div>
				<div class="info_main_bot_staff">
					<div class="info_main_bot_staff_font">출연 / 제작</div>
					
					<div class="bot_staff_profiles">
						<div class="bot_staff_profiles_img">
							<!-- <img alt="사진" src="" /> 나중에 변경해야함 개발편의를 위해 box 로 대체-->
							<img alt="staff_img" class="staff_profile_img" src="/movie/assets/images/staff_profile/감독_${movieDto.movie_director }.jpg" />
						</div>
						<div class="bot_staff_profiles_txt">
							<div class="bot_staff_progiles_name">
								${movieDto.movie_director.replaceAll("_", " ") }
							</div>
							<div class="bot_staff_progiles_position txt">
								감독
							</div>
						</div>
					</div>
					
					<!-- 구분선 출연/제작 1 -->
					<c:forEach var="actor" items="${actorList }">
						<div class="bot_staff_profiles">
							<div class="bot_staff_profiles_img">
								<!-- <img alt="사진" src="" /> 나중에 변경해야함 개발편의를 위해 box 로 대체-->
								<img alt="배우" class="staff_profile_img" src="/movie/assets/images/staff_profile/${actor }.jpg" />
							</div>
							<div class="bot_staff_profiles_txt">
								<div class="bot_staff_progiles_name">
									${actor.replaceAll("_", " ") }
								</div>
								<div class="bot_staff_progiles_position">
									배우
								</div>
							</div>
						</div>
					</c:forEach>
					
					<!-- 구분선 -->
				</div>
				<div class="info_main_bot_comment">
					<div class="info_main_bot_comment_top">
						<div class="comment_top_left txt">
							코멘트
						</div>
						
					</div>
					<div class="info_main_bot_comment_bot">
						<c:if test="${empty commentList }">
							등록 된 코맨트가 없습니다.
						</c:if>
						<c:if test="${not empty commentList }">
							<c:choose>
								<c:when test="${fn:length(commentList) > 3}">
									<c:forEach begin="0" end="2" items="${commentList }" var="commentDto">
										<div class="comment_bot" >
											<div class="comment_body" id="movieView" data-target="#layerpop-commentView" data-toggle="modal">
											
												<div class="comment_main_top">
														<i class="fas fa-user-circle fa-1x txt">${commentDto.user_nickname }</i>
													<!--**************************** 별점 기능 필수 ******************************* -->
													<span id="commentStar"><i class="fas fa-star"></i> ${commentDto.comment_score }</span>
												</div>
												<div class="comment_main_mid">
													<textarea class="comment_main_mid_txt" readonly>${commentDto.comment_content }
													</textarea>
												</div>
												<input type="hidden" name="userNo" value= "${commentDto.user_no}" >
												<input type="hidden" name="movieNo" value="${commentDto.movie_no}" >
												<input type="hidden" name="commentNo" value="${commentDto.comment_no}">
					        	 				<input type="hidden" name="userNickname" value="${commentDto.user_nickname}">
									        	<input type="hidden" name="commentContent" value="${commentDto.comment_content}">
								        	    <input type="hidden" name="date" value="${commentDto.comment_date}">
	  							        	    <input type="hidden" name="title" value="${commentDto.comments_title}">
	  							        	    <input type="hidden" name="commentScore" value="${commentDto.comment_score}">
											</div>
											<div class="comment_main_bot">
												<a href="#">
												좋아요<i class="far fa-thumbs-up">&nbsp;&nbsp;${commentDto.comment_like }</i>
												</a>
											</div>
							        	    
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach items="${commentList }" var="commentDto">
										<div class="comment_bot" >
											<div class="comment_body" id="movieView" data-target="#layerpop-commentView" data-toggle="modal">
												<div class="comment_main_top">
														<i class="fas fa-user-circle fa-2x txt">${commentDto.user_nickname }</i>
													<!--**************************** 별점 기능 필수 ******************************* -->
													<span id="commentStar"><i class="fas fa-star"></i> ${commentDto.comment_score }</span>
												</div>
												<div class="comment_main_mid">
													<textarea class="comment_main_mid_txt" readonly>${commentDto.comment_content }
													</textarea>
												</div>
												<input type="hidden" name="userNo" value= "${commentDto.user_no}" >
												<input type="hidden" name="movieNo" value="${commentDto.movie_no}" >
												<input type="hidden" name="commentNo" value="${commentDto.comment_no}">
					        	 				<input type="hidden" name="userNickname" value="${commentDto.user_nickname}">
									        	<input type="hidden" name="commentContent" value="${commentDto.comment_content}">
								        	    <input type="hidden" name="date" value="${commentDto.comment_date}">
								        	    <input type="hidden" name="title" value="${commentDto.comments_title}">
  	  							        	    <input type="hidden" name="commentScore" value="${commentDto.comment_score}">
								        	    
											</div>
											<div class="comment_main_bot">
												<a href="#">
												좋아요<i class="far fa-thumbs-up">&nbsp;&nbsp;${commentDto.comment_like }</i>
												</a>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</c:if>
						
					</div>
					<input class="commet_view_btn" type="button" value="더보기" onclick="" />
				</div>
				<div class="description-box">
					<span class="section-description">영화 <span class="section-movieName">${movieDto.movie_title.replaceAll("_"," ") }</span> 과(와) 관련된 영화들 입니다!</span>
				</div>
				<div class="info_main_bot_movies">
					<c:choose>
						<c:when test="${fn:length(relationMovieList) > 8}">
							<c:forEach begin="0" end="7" items="${relationMovieList }" var="relationMovie">
									<div class="main_bot_movies_poster" style="background-image: url('/movie/assets/images/poster/${relationMovie.movie_title}_포스터.jpg')">
										<div class="main_bot_poster_info">
											<div>제목 ${relationMovie.movie_title.replaceAll("_", " ") }</div>
											<span>장르 ${relationMovie.genre_name }&nbsp; 평점 <c:if test="${fn:length(relationMovie.movie_web_score) == 1 }">
																										${ relationMovie.movie_web_score}.0
																								 </c:if>
																								 <c:if test="${fn:length(relationMovie.movie_web_score) > 1 }">
																										${ relationMovie.movie_web_score}
																								 </c:if></span>
											<input type="hidden" id="movieNo" value="${relationMovie.movie_no }"/>
										</div>
									</div>
							</c:forEach>
							
						</c:when>
						<c:otherwise>
							<c:forEach var="relationMovie" items="${relationMovieList }">
								<div class="main_bot_movies_poster" style="background-image: url('/movie/assets/images/poster/${relationMovie.movie_title}_포스터.jpg')">
									<div class="main_bot_poster_info">
										<div>제목 ${relationMovie.movie_title.replaceAll("_", " ")  }</div>
										<span>장르 ${relationMovie.genre_name }&nbsp; 평점 <c:if test="${fn:length(relationMovie.movie_web_score) == 1 }">
																										${ relationMovie.movie_web_score}.0
																								 </c:if>
																								 <c:if test="${fn:length(relationMovie.movie_web_score) > 1 }">
																										${ relationMovie.movie_web_score}
																								 </c:if></span>
										<input type="hidden" id="movieNo" value="${relationMovie.movie_no }"/>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
					
				</div>
			</div>
		</div>
	</div>
</c:if>

<!-- modal -->
	<style>
		.commentView .modal-dialog{
			width: 800px;
		}
		.modal-title {
   			 font-weight: bold;
   		} 
		textarea#commentContents {
		    width: 90%;
		    height: 90%;
		    margin-left : -55px;
		}
		
		
	</style>
	 <div class="modal fade commentView" id="layerpop-commentView" >
	   <div class="modal-dialog">
	     <div class="modal-content">
	       <!-- header -->
	       <div class="modal-header">
	         <!-- 닫기(x) 버튼 -->
	         <button type="button" class="close btn btn-info" data-dismiss="modal">×</button>
	         <!-- header title -->
	         <h4 class="modal-title">코멘트</h4>
	       </div>
	       <!-- body -->
	       <div class="modal-body">
	           <jsp:include page="../myPage/myWriteViewPage.jsp">
					<jsp:param value="test" name="title" />
			   </jsp:include>
	       </div>
	       <!-- Footer -->
	       <div class="modal-footer">
	         <button type="button" id="close-btn" class="btn btn-info" data-dismiss="modal">닫기</button>
	       </div>
	     </div>
	   </div>
	 </div>
	
	
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
<script src="/movie/assets/script/commentViewModal.js"></script>
<script>

	const movieNo = ${movieDto.movie_no};
	const ratingContentsBox = document.querySelector('.my-rating-contents');
	const movieStarObjList = localStorage.getItem("movieStarObjList");
	let movieStar_List = [];
	const loginUser = '${loginUser.user_no}';

	/* 별점 초기 값 */
	$('document').ready(function(){
		
	});
	$("#star-rating").on("rateyo.init", function (e, data) {
		 
		if(loginUser == null || loginUser == ''){
			
			if(movieStarObjList != null){
				 movieStar_List = JSON.parse(movieStarObjList);
				 let movieStarObj = movieStar_List.find(function(element){
					 	
					return element.movieNo == movieNo;
				 });
				 
				 if(movieStarObj){
					 
					 let targetRating = movieStarObj.rating;
					 
					 $("#star-rating").rateYo("option", "rating", targetRating);
					 ratingContentsText(e, targetRating);
				 }else{
					 return;
				 }
				 
			}else{
				return;
			}
			
		}else{
			
			// 로그인 유저가 있을 경우 가져옴
			$.ajax({
				url: 'initStarScore/' + loginUser + '/' + movieNo,
				type: 'get',
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				async:false,
				success: function(responseObj){
					
					if(responseObj.result){
						
						 let targetRating = responseObj.movieScore;
						 $("#star-rating").rateYo("option", "rating", targetRating);
						 ratingContentsText(e, targetRating);
					}else{
						return;
					}
				},
				error: function(){
					swal({
					    title: "Error",
					    text: "유저초기별점에러",
					    icon: "error" //"info,success,warning,error" 중 택1
					});
					
					/*  alert('유저초기별점에러');*/
				}
				
			});
			
		}
		
       });
 
	$("#star-rating").rateYo({
		rating: 1.5,
		halfStar: true,
		starWidth: "40px"
		
	});
	
	/* 별점 바뀔때마다 실행 */
	 $("#star-rating").rateYo().on("rateyo.set", function (e, data) {

		 let rating = data.rating;
		 ratingContentsText(e, rating);
		 
		 $.ajax({
			 url: 'setStar/'+ movieNo + '/' + rating,
			 type: 'post',
			 contentType: 'application/json; charset=utf-8',
			 dataType: 'json',
			 success: function(responseObj){
				 
				 let movieStarObj = {
						 "movieNo": movieNo,
						 "rating": rating
				 }
				 
				 // 로그인 안한상태라면 로컬 스토리지 활용
				 if(!responseObj.setUserScore){
					 
					 if(movieStarObjList == null){
						 movieStar_List.push(movieStarObj);
						 console.log(movieStarObj);
						 // 로컬 스토리지에 저장
						 localStorage.setItem("movieStarObjList" , JSON.stringify(movieStar_List) );
				 
					 }else{
						 movieStar_List = JSON.parse(movieStarObjList);
						 console.log(movieStar_List);
						 let idx = movieStar_List.findIndex(function(e){
							 			return e.movieNo === movieNo;
						 });
							 // 로컬 스토리지에 저장되어 있다면 값을 새로 추가 후 저장
						 if(idx == -1){
							 
							 movieStar_List.push(movieStarObj);
							 localStorage.setItem("movieStarObjList" , JSON.stringify(movieStar_List) );
							 
							 // 중복되는 값이 있다면 값 제거 후 새로운 값을 추가 후 저장
						 }else{
							 
						 	movieStar_List.splice(idx, 1);
						 	movieStar_List.push(movieStarObj);
							localStorage.setItem("movieStarObjList" , JSON.stringify(movieStar_List) );
	
						 }
						 
						 
					 }
				 }else{
					 console.log('성공');
				 }
			 },
			 error: function(){
				 alert('error');
			 }
			 
			 
		 });
         
         
     });
	
	 // 평가후 점수별로 코멘트
	 function ratingContentsText(e, getRating){
		 
		 /* alert("The rating is set to " + data.rating + "!"); */
         let rating = getRating;
         
         switch(true){
         case rating >= 4 : $(".my-rating-contents").html("<div id='star-result'>인생 영화에요!</div>"); break;
         case rating >= 3 : $(".my-rating-contents").html("<div id='star-result'>최고에요!</div>"); break;
         case rating >= 2 :$(".my-rating-contents").html("<div id='star-result'>재밌어요!</div>"); break;
         case rating >= 1 :$(".my-rating-contents").html("<div id='star-result'>괜찮아요.</div>"); break;
         case rating >= 0 : $(".my-rating-contents").html("<div id='star-result'>추천하지 않아요.</div>"); break;
         						
         }
	 }
	 
	 // 세션에 존재하는 값 체크
	
	 
	 
	 
	 
	 
	 // 모달 컨트롤
	 $('#modalBox').on('click',handleModal);
	 
	 function handleModal(){
		 if(loginUser == ''){
			 /* alert('로그인 후 이용해 주세요!'); */
			 swal({
	    		   title: "Check!",
	    		   text: "로그인 후 이용해 주세요!",
	    		   icon: "warning" //"info,success,warning,error" 중 택1
  			 }).then(function(){
  				 
			 	location.href="loginPage.do";
  			 });
		 }
	 }
	 
	 // 위시리스트
	 
	 // 위시리스트 추가
	 $('#wish').on('click',handleWish);
	 
	 function handleWish(){
		 if(loginUser == ''){
			 swal({
	    		   title: "Check!",
	    		   text: "로그인 후 이용해 주세요!",
	    		   icon: "warning" //"info,success,warning,error" 중 택1
			 }).then(function(){
				 
			 	location.href="loginPage.do";
			 });
		 }else{
			 
			 // 버튼의 텍스트로 비교합니다.
			 if($('#wish').text() == '+ 위시리스트'){
				 
				 $.ajax({
					 url: 'insertWishList/' + movieNo,
					 type: 'post',
					 contentType: 'application/json; charset=utf-8',
					 success: function(responseObj){
						 if(responseObj.insertResult){
							 swal({
					    		   title: "Success!",
					    		   text: "위시리스트에 등록되었습니다!",
					    		   icon: "success" //"info,success,warning,error" 중 택1
							 });
							 // 위시리스트에 데이터가 저장되면 버튼의 텍스트를 변경합니다.
							 $('#wish').text('- 위시리스트');
						 }
					 },
					 error: function(){
						 alert('실패');
					 }
					 
				 });
			 }else{
				// 위시리스트 제거
				 $.ajax({
					 url: 'deleteWishList/' + movieNo,
					 type: 'post',
					 contentType: 'application/json; charset=utf-8',
					 success: function(responseObj){
						 if(responseObj.deleteResult){
							 swal({
					    		   title: "Delete!",
					    		   text: "위시리스트에서 제거되었습니다.",
					    		   icon: "warning" //"info,success,warning,error" 중 택1
							 });
							 $('#wish').text('+ 위시리스트');
						 }
					 },
					 error: function(){
						 alert('실패');
					 }
					 
				 });
			 }
			 
			 
		 }
	 }
	 
	 // 코멘트 작성
	 $('.inp_btn').on('click',handleCommentSubmit);
	 
	 function handleCommentSubmit(e){
		 
		 if( $('#commentTitle').val() == ''){
			 alert('제목은 필수입니다.');
			 $('#commentTitle').focus();
			 e.stopPropagation();
			 return;
		 }
		 
		 if( $('#commentContents').val() == ''){
			 alert('내용은 필수입니다.');
			 $('#commentContents').focus();
			 e.stopPropagation();
			 return;
		 }
		 
		 if( !fnCut($('#commentTitle').val(), 50)){
        	 alert('제목은 50byte까지 가능합니다.');
   	 		 $('#commentTitle').focus();
			 e.stopPropagation();
			 return;
		 }
		 
		swal({
 		   title: "Success!",
 		   text: "코멘트가 등록되었습니다!",
 		   icon: "success" //"info,success,warning,error" 중 택1
		}).then(function(){
			
			$('#commentForm').submit();
		})
	 }
	 
	 function fnCut(str,lengths) // str은 inputbox에 입력된 문자열이고,lengths는 제한할 문자수 이다.
	 {
	       var len = 0;
	       var newStr = '';
	   
	       for (var i=0;i<str.length; i++) 
	       {
	         var n = str.charCodeAt(i); // charCodeAt : String개체에서 지정한 인덱스에 있는 문자의 unicode값을 나타내는 수를 리턴한다.
	         // 값의 범위는 0과 65535사이이여 첫 128 unicode값은 ascii문자set과 일치한다.지정한 인덱스에 문자가 없다면 NaN을 리턴한다.
	         
	        var nv = str.charAt(i); // charAt : string 개체로부터 지정한 위치에 있는 문자를 꺼낸다.
	         

	         if ((n>= 0)&&(n<256)) len ++; // ASCII 문자코드 set.
	         else len += 3; // 한글이면 3byte로 계산한다.
	         console.log(len);
	         
	       }
	         if (len>lengths){
	        	 
	        	 return false; // 제한 문자수를 넘길경우.
	        	 
	         }else{
	        	 return true;
	         }
	 }
	 
	 
	 // 관계된 영화들 링크주기
	 $('.main_bot_movies_poster').on('click',handleMovieInfo);
	 
	 function handleMovieInfo(event){
		 let movieNo = event.target.children[0].children[2].value;
		 
		 location.href="movieInfoPage.do?movieNo=" + movieNo;
	 }
	
	 // 코멘트 더보기 페이지
	 $('.commet_view_btn').on('click',handleCommentViewList);
	
	 function handleCommentViewList(){
		 location.href='movieCommentPage.do?movieNo=' + movieNo;
	 }
	
		
	</script>	
	
<%@ include file="../template/footer.jsp" %>