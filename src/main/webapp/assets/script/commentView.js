/**
 * 
 */

// 페이징 처리
	let page = 1;  // 초기화
	let is_progress;
	
	
	/***** 1. 회원 목록 *****/
	function commentList() {
		if(is_progress == true){
			return;
		}
		is_progress = true;
		
		let obj= {
			"page": page,
		};
		
		$.ajax({
			url: 'userWriteList.do',
			type: 'post',
			data: JSON.stringify(obj),  // 컨트롤러로 보내는 JSON 데이터
			contentType: 'application/json; charset=utf-8',  // 컨트롤러로 보내는 데이터의 타입
			dataType: 'json',
			success: function(result) {
				/*
					result = {
						"list": [
							{
								"no": 1,
								"id": "user1",
								"name": "제임스",
								"gender": "남",
								"address": "서울"
							},
							...
						],
						"paging": {
							"totalRecord": 20,
							"page": 1,
							"totalPage": 7,
							"pagePerBlock": 5,
							"beginPage": 1,
							"endPage": 4
						},
						"exist": true
					}
				*/
				var paging = result.paging;
				
				$('#commentList').empty();  // 기존 목록 제거
				
				// 회원이 있으면,
				if (result.exist) {
					$('#totalRecord').html('전체: ' + paging.totalRecord + '명');  // 전체 인원수 출력
					commentListTable(result.list, result.paging.totalRecord, result.paging.recordPerPage, result.paging.page, result.userNo, result.userNickname);  // 목록 출력
				}
				// 회원이 없으면,
				else {
					$('<tr>')
					.append($('<td colspan="6" style="height: 20px;">').html('데이터가 없습니다.'))
					.appendTo('#commentList');
				}
				
				
				// 여기서부터 commentList() 끝까지 페이징 처리
				
				$('#paging').empty();  // 기존 페이징 초기화
				
				// 링크가 필요한 모든 곳에는 data-page 속성에 이동할 페이지 번호를 계산해 두고
				// $(this).attr('data-page') 를 통해서 그 값을 꺼내서 사용합니다.
				
				// ◀
				if (paging.beginPage <= paging.pagePerBlock) {
					// class 의미
					// disable : css (클릭 안 되는 건 실버색) 적용하려고
					$('#paging').append('<div class="disable"><a>◀</a></div>');
				} else {
					// class 의미
					// 1) prev-block : 이전(◀)으로 이동하려고
					// 2) go-page : css (cursor: pointer) 적용하려고
					$('#paging').append('<div class="prev-block go-page" data-page="' + (paging.beginPage - 1) + '"><a>◀</a></div>');
				}
				
				// 1 2 3 4 5
				for (let p = paging.beginPage; p <= paging.endPage; p++) {
					if (paging.page == p) {  // 현재페이지는 링크가 안 됩니다.
						// class 의미
						// now-page : css (현재 페이지는 녹색) 적용하려고
						$('#paging').append('<div class="now-page"><a>' + p + '</a></div>')
					} else {
						// class 의미
						// go-page : css (cursor: pointer) 적용하려고
						$('#paging').append('<div class="go-page" data-page="' + p + '"><a>' + p + '</a></div>');
					}
				}
				
				// ▶
				if (paging.endPage >= paging.totalPage) {
					// class 의미
					// disable : css (클릭 안 되는 건 실버색) 적용하려고
					$('#paging').append('<div class="disable"><a>▶</a></div>');
				} else {
					// class 의미
					// 1) next-block : 다음(▶)으로 이동하려고
					// 2) go-page : css (cursor: pointer) 적용하려고
					$('#paging').append('<div class="next-block go-page" data-page="' + (paging.endPage + 1) + '"><a>▶</a></div>');
				}
				setTimeout(function(){is_progress = false;}, 500);
			},
			error: function(){
				alert('실패');
				setTimeout(function(){is_progress = false;}, 500);
			}
			
			
		});
		
		// 링크가 걸릴 때 이동할 페이지 번호를 알아내서 다시 목록을 뿌리는 함수들
		$('body').on('click', '.prev-block', function(){
			page = $(this).attr('data-page');
			commentList();
		});
		$('body').on('click', '.go-page', function(){
			page = $(this).attr('data-page');
			commentList();
		});
		$('body').on('click', '.next-block', function(){
			page = $(this).attr('data-page');
			commentList();
		});
		
	}  // end commentList()
	
	// 서브 함수: 회원 목록을 테이블로 만들어 주는 함수
	function commentListTable(list, totalRecord, recordPerPage, page, userNo, userNickname) {
		$.each(list, function(idx, comment){
//			 날짜 타입스탬프 밀리세컨드 값 포맷
			 let getDate = new Date(comment.comment_date);
			 let yyyy = getDate.getFullYear().toString();                                   
	         let mm = (getDate.getMonth()+1).toString(); // getMonth() is zero-based        
	         let dd  = getDate.getDate().toString();
	         let date = yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);

	         let string = `<tr><td>${totalRecord - (recordPerPage * (page - 1)) - idx}</td>
							<td>
								<a href="#" id="movieView" data-target="#layerpop" data-toggle="modal"> ${comment.comments_title} </a>
								<input type="hidden" name="userNo" value= ${userNo} >
								<input type="hidden" name="movieNo" value=${comment.movie_no} >
								<input type="hidden" name="commentNo" value=${comment.comment_no}>
	        	 				<input type="hidden" name="userNickname" value=${userNickname}>
					        	<input type="hidden" name="commentContent" value=${comment.comment_content}>
				        	    <input type="hidden" name="date" value=${date}>
					        	<input type="hidden" name="commentScore" value=${comment.comment_score}></td>
							<td>${userNickname}</td>
							<td>${date}</td>
							<td>${comment.comment_like}</td></tr>`;
			$('#commentList').append(string);
			/* $('<tr>')
			.append( $('<td>').html(totalRecord - (recordPerPage * (page - 1)) - idx ) ) 
			.append( $('<td>').html(comment.movie_no) )
			.append( $('<td>').html(comment.comments_title) ).data('target', '#layerpop').data('toggle','modal')
			.append( $('<td>').html('닉네임' ) )
			.append( $('<td>').html(comment.comment_date) )
			.append( $('<td>').html(comment.comment_like) )
			.append( $('<input type="hidden" name="userNo" />').val( ${loginUser.user_no} ) )
			.append( $('<input type="hidden" name="movieNo" />').val( comment.movie_no ) )
			.append( $('<input type="hidden" name="comentNo" />').val(comment.comment_no) )  // 회원 삭제에서 사용할 id를 새로 추가했습니다.
			.append( $('<td>').html('<input type="button" value="조회" id="btnView" /><input type="button" value="삭제" id="btnDelete" />'))
			.appendTo('#commentList'); */
		});
	}
	
	
	/****** 회원 게시글 보기********/
	$(document).on("click","#commentList a",handleView);
		function handleView(event){
			if(is_progress == true){
				return;
			}
			is_progress = true;
			const userNo = event.target.parentElement.children.userNo.value;
			const movieNo = event.target.parentElement.children.movieNo.value;
			const commentNo = event.target.parentElement.children.commentNo.value;
			const userNickname = event.target.parentElement.children.userNickname.value;
			const commentContent = event.target.parentElement.children.commentContent.value;
			const date = event.target.parentElement.children.date.value;
			const commentScore = event.target.parentElement.children.commentScore.value;
			const commentName = event.target.innerText;
			let movieTitle;
		
			$.ajax({
				url: 'getMovieTitle/' + movieNo,
				type: 'get',
				dataType: 'json',
				success: function(responseObj){
					
					movieTitle = responseObj.movieTitle;
					
					if(!movieTitle){
						alert('일치하는 영화없음');
					}
					sendModalView(userNo, movieNo, commentNo, userNickname, commentName, movieTitle, commentContent, date, commentScore );
					
					setTimeout(function(){is_progress = false;}, 100);
				},
				error: function(){
					setTimeout(function(){is_progress = false;}, 500);
				}
			});
			
			
		}
		
		/* 버튼 클릭 시 모달창에 정보전달 */
		function sendModalView(userNo, movieNo, commentNo, userNickname, commentName, movieTitle, commentContent, date, commentScore){
			const modal = document.querySelector('.modal');
			modal.querySelector('.modal-title').innerText = `${userNickname} 님이 작성하신 글입니다.`;
			
			const modalContents = document.querySelector('.main-wrapper-my-write');
			
			modalContents.querySelector('.movie-name-span').innerText = movieTitle.replaceAll('_', ' ');
			modalContents.querySelector('.movie-poster-img').style.backgroundImage = `url("/movie/assets/images/poster/${movieTitle}_포스터.jpg")`;
			modalContents.querySelector('.movie-poster-img').style.backgroundSize = '100% 100%';
			modalContents.querySelector('#movieNo').value = movieNo;
			
			let contentTitle = `
								<input type="text" class="textOutline" value="${commentName}" id="contentTitle" readonly/>
								`;
			modalContents.querySelector('.top-title-contents').innerHTML = contentTitle;
			
			modalContents.querySelector('.writer').innerText = `작성자: ${userNickname}`;
			modalContents.querySelector('.write-date').innerText = `작성일자: ${date}`;
			
			let contentTextarea = `<textarea class="contentTextArea textOutline" id="commentContents" readonly>${commentContent}</textarea>`;
			
//				document.createElement('textarea');
//			contentTextarea.className = 'contentTextArea';
//			contentTextarea.innerText = commentContent;
			modalContents.querySelector('.right-textarea-contents').innerHTML = contentTextarea;
			
			// 스코어
			commentScore = commentScore.length == 1 ? commentScore + '.0' : commentScore
			modalContents.querySelector('.movie-score').innerHTML = commentScore;
			
			if(document.title == '내가 쓴 글 목록'){
				const modalBox = modal.querySelector('.main-wrapper-my-write');
				const updateBtn = modal.querySelector('#updateControlBtn');
				const deleteBtn = modal.querySelector('#deleteBtn');
				
				updateBtn.classList.remove('none');
				deleteBtn.classList.remove('none');
				
				modal.querySelector('#commentNo').setAttribute('value', commentNo);
				
			}
		}
		
		
		/******* 글 수정 하기 *****/
		
//		값 저장용
		let orCommentTitle;
		let orCommentContents;
		
		const modal = document.querySelector('.modal');
		const updateCommentBtn = modal.querySelector('#updateComment');
		const updateControlBtn = modal.querySelector('#updateControlBtn');
		const deleteBtn = modal.querySelector('#deleteBtn');
		
		function fn_commentUpdateControl(){

			const footerBtnBox = modal.querySelector('.footer-btn-box');
			const commentTitle = modal.querySelector('#contentTitle');
			const commentContents = modal.querySelector('#commentContents');
			
			let footerBtn;
			if(updateControlBtn.value == '수정하기'){
//				footerBtn = `
//					<input type="button" value="수정취소" class="btn btn-primary" id="updateCancle" onclick="fn_commentUpdateControl()"/>
//					<input type="button" value="수정완료" class="btn btn-primary" id="updateControlBtn" onclick="fn_commentUpdate()"/>
//					<input type="button" value="삭제하기" class="btn btn-primary" id="deleteBtn" onclick="fn_commentDeleteBtn()"/>
//					`;
				updateCommentBtn.classList.remove('none');
				updateControlBtn.value = '취소하기';
				
				commentTitle.classList.remove('textOutline');
				commentContents.classList.remove('textOutline');
				
				commentTitle.removeAttribute('readonly');
				commentContents.removeAttribute('readonly');
				
				orCommentTitle = commentTitle.value;
				orCommentContents = commentContents.value;
				
				commentTitle.focus();
			}else{
//				footerBtn = `
//					<input type="button" value="수정하기" class="btn btn-primary" id="updateControlBtn" onclick="fn_commentUpdateControl()"/>
//					<input type="button" value="삭제하기" class="btn btn-primary" id="deleteBtn" onclick="fn_commentDeleteBtn()"/>
//					`;
				
				updateCommentBtn.classList.add('none');
				updateControlBtn.value = '수정하기';
				
				commentTitle.value = orCommentTitle;
				commentContents.value = orCommentContents;
				
				commentTitle.classList.add('textOutline');
				commentContents.classList.add('textOutline');
				
				
				commentTitle.setAttribute('readonly', 'true');
				commentContents.setAttribute('readonly', 'true');

			}
		}
		
		
		function fn_commentUpdate(){
			if(is_progress == true){
				return;
			}
			is_progress = true;
			orCommentTitle = modal.querySelector('#contentTitle').value;
			orCommentContents = modal.querySelector('#commentContents').value;
			const commentNo = modal.querySelector('#commentNo').value;
			
			// 업데이트 할 값들
			let updateValueObj = {
					"titleValue": orCommentTitle,
					"contentValue": orCommentContents,
					"commentNo": commentNo
			};
			
			$.ajax({
				url: 'userUpdateComment.do',
				type: 'put',
				data: JSON.stringify(updateValueObj),
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				success: function(responseObj){
					
					if(responseObj.updateResult > 0){
						alert('수정되었습니다.');
						fn_commentUpdateControl();
					}else{
						alert('실패');
					}
					
					
					setTimeout(function(){ is_progress = false; }, 500);
				},
				error: function(){
					alert('오류');
					setTimeout(function(){ is_progress = false; }, 500);
				}
			});
			
		}
		
		
		/******* 글 삭제 하기 *****/
		
		// 닫기 버튼 클릭 시 	commentList() 함수 실행
		
		document.querySelector('#close-btn').addEventListener('click',init);
		
		function fn_commentDeleteBtn(){
			if(is_progress == true){
				return;
			}
			is_progress = true;
			const commentNo = modal.querySelector('#commentNo').value;
			
			if(confirm('정말로 삭제하시겠습니까?')){
				$.ajax({
					url: 'userDeleteComment/' + commentNo,
					type: 'delete',
					contentType: 'application/json; charset=utf-8',
					success: function(responseObj){
						
						if(responseObj.resultDelete > 0){
							is_progress = false;
							alert('삭제되었습니다.');
							document.querySelector('#close-btn').click();
							
						}
						
						setTimeout(function(){ is_progress = false; }, 500);
					},
					error: function(){
						
						setTimeout(function(){ is_progress = false; }, 500);
					}
				});
			}else{
				setTimeout(function(){ is_progress = false; }, 500);
			} 
			
		}
		
	
	function init(){
		commentList();
	}
	
	init();