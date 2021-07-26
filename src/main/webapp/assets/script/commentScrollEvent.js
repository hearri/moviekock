/**
 * 
 */

/* 스크롤 하단 감지 영화 리스트뽑아오기 */
		let movieNo = document.querySelector('#movieNo').value;
        let scrollCount = 2;
  		
  $(window).scroll(function() {
        
        let scrolltop = $(window).scrollTop();
        let height = $(document).height();
        let height_win = $(window).height();
        
        /* 스크롤이 하단에 위치한다면 */
     if (Math.round( $(window).scrollTop()) == $(document).height() - $(window).height()) {
        
        	$.ajax({
        		url: 'scrollCommentList/'+ scrollCount + '/' + movieNo,
        		type: 'get',
        		dataType: 'json',
        		success: function(responseObj){
        			const commentList = responseObj.scrollCommentList;
        			
        			commentList.forEach(function(commentDto){
        				
						 let getDate = new Date(commentDto.comment_date);
	    				 let yyyy = getDate.getFullYear().toString();                                   
	    		         let mm = (getDate.getMonth()+1).toString(); // getMonth() is zero-based        
	    		         let dd  = getDate.getDate().toString();
	    		         let date = yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);
        				const commentOne = `<div class="main-top comment_bot">
											  <div class="box1">
											  	<div class="comment_body" id="movieView" data-target="#layerpop-commentView" data-toggle="modal">
										            <div class="box1_top comment_main_top">
												    <i class="fas fa-user-alt fa-4x" id=user_icon1></i>
										            <div class="box1_name">${commentDto.user_nickname }</div>
										            <div class="box1_star_box">★ ${commentDto.comment_score }</div>
												    </div>
												    <div class="box1_middle comment_main_mid">
												    	<textarea class="commentContents" readonly>${commentDto.comment_content }
												    	</textarea>
												    </div>
						        					<input type="hidden" name="userNo" value= "${commentDto.user_no}" >
						        					<input type="hidden" name="movieNo" value="${commentDto.movie_no}" >
						        					<input type="hidden" name="commentNo" value="${commentDto.comment_no}">
						        					<input type="hidden" name="userNickname" value="${commentDto.user_nickname}">
						        					<input type="hidden" name="commentContent" value="${commentDto.comment_content}">
						        					<input type="hidden" name="date" value="${date}">
						        					<input type="hidden" name="title" value="${commentDto.comments_title}">
											    </div>
									            <div class="box1_bottom">
									              <p>좋아요</p>
									              <i class="far fa-thumbs-up fa-2x" id="finger1">${commentDto.comment_like }</i>
									            </div>
											  </div>
											</div>`;
        				$('.wrap').append(commentOne);
        			});
        			
        			
        			scrollCount++;
        		},
        		error: function(){
        			
        		}
        		
        	});
        }
        
   });  