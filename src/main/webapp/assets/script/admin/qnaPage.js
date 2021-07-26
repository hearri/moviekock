// 페이징 처리
	let page = 1;  // 초기화
	let is_progress;
	
	
	/***** 1. 게시글 목록 *****/
	function qnaList() {
		if(is_progress == true){
			return;
		}
		is_progress = true;
		
		let obj= {
			"page": page,
		};
		
		$.ajax({
			url: 'qnaList.admin',
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
				
				$('#qnaList').empty();  // 기존 목록 제거
				
				// 게시글이 있으면,
				if (result.exist) {
					$('#totalCount').html(paging.totalRecord);  // 전체 게시글수 출력
					qnaListTable(result.list, result.paging.totalRecord);  // 목록 출력
				}
				// 게시글이 없으면,
				else {
					$('#totalCount').html('0');
					$('<tr>')
					.append($('<td colspan="6" style="height: 20px;">').html('데이터가 없습니다.'))
					.appendTo('#qnaList');
				}
				
				
				// 여기서부터 qnaList() 끝까지 페이징 처리
				
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
			qnaList();
		});
		$('body').on('click', '.go-page', function(){
			page = $(this).attr('data-page');
			qnaList();
		});
		$('body').on('click', '.next-block', function(){
			page = $(this).attr('data-page');
			qnaList();
		});
		
	}  // end qnaList()
	
	// 서브 함수: 문의글 목록을 테이블로 만들어 주는 함수
	function qnaListTable(list, totalRecord) {
		$.each(list, function(idx, qna){
//			 날짜 타입스탬프 밀리세컨드 값 포맷
			 let getDate = new Date(qna.qna_date);
			 let yyyy = getDate.getFullYear().toString();                                   
	         let mm = (getDate.getMonth()+1).toString(); // getMonth() is zero-based        
	         let dd  = getDate.getDate().toString();
	         let hh  = getDate.getHours().toString();
	         let mi  = getDate.getMinutes().toString();
	         let ss  = getDate.getSeconds().toString();
	         let date = yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);

	         let string =  `<tr> 
	        	 		    <td>${qna.qna_no}</td> 
	        	 			<td>${qna.user_nickname}</td> 
	        	 			<td>${qna.qna_select}</td> 
							<td> 
								<a href="#" id="qnaView" data-target="#layerpop" data-toggle="modal"> ${qna.qna_title} </a> 
								<input type="hidden" name="qnaNo" value= ${qna.qna_no} > 
					        	<input type="hidden" name="userNickname" value= ${qna.user_nickname} > 
								<input type="hidden" name="qnaSelect" value= ${qna.qna_select} > 
								<input type="hidden" name="qnaTitle" value=${qna.qna_title} > 
					        	<input type="hidden" name="qnaDate" value=${date} > 
					        	<input type="hidden" name="qnaYn" value=${qna.qna_yn} > 
							</td> 
				        	<td>${date}</td> 
	        	 			<td>${qna.qna_yn == 0 ? "답변대기중" : "답변완료"}</td> 
	        	 			<tr>`;
			$('#qnaList').append(string);
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
			.appendTo('#userList'); */
		});
	}
	
	/****** 문의글 보기********/
	$(document).on("click","#qnaView",handleView);
	function handleView(event){
		const qnaNo = event.currentTarget.parentNode.children.qnaNo.value;
		const userNickname = event.currentTarget.parentNode.children.userNickname.value;
		const qnaSelect = event.currentTarget.parentNode.children.qnaSelect.value;
		const qnaTitle = event.currentTarget.parentNode.children.qnaTitle.value;
		const qnaDate = event.currentTarget.parentNode.children.qnaDate.value;
		const qnaYn = event.currentTarget.parentNode.children.qnaYn.value;
		
		sendModalView(qnaNo, userNickname, qnaSelect, qnaTitle, qnaDate, qnaYn);
		
	}
	
	/* 버튼 클릭 시 모달창에 정보전달 */
	function sendModalView(qnaNo, userNickname, qnaSelect, qnaTitle, qnaDate, qnaYn, userProfileImage){
		
		$('.qnaNo').text(qnaNo);
		$('.userNickname').text(userNickname);
		$('.qnaSelect').text(qnaSelect);
		$('.qnaTitle').text(qnaTitle);
		$('.qnaDate').text(qnaDate);
		
		
		if(qnaYn == 0) {
			qnaYn = "답변 대기중";
			$('.qnaYn').text(qnaYn);
		}
		if(qnaYn == 1) {
			qnaYn = "답변 완료";
			$('.qnaYn').text(qnaYn);
		}
		
	}
	
	
//	/****** 문의글 답글 삭제********/
//	$('#deleteBtn').on('click',handleDelete);
//	
//	function handleDelete(event){
//		const qnaReplyNo = event.target.nextElementSibling.value;		
//		if(confirm('삭제하시겠습니까?')){
//			
//			$.ajax({
//				url:'adminQnaReplyDelete/' + qnaReplyNo,
//				type: 'delete',
//				dataType: 'json',
//				success: function(responseObj){
//					if(responseObj.deleteResult){
//						alert('삭제되었습니다.');
//						init();
//						event.target.parentElement.parentElement.children[3].children[0].click();
//					}
//				},
//				error: function(){
//					alert('삭제실패.');
//				}
//				
//			});
//		}else{
//			
//		}
//	}
	
	/****** 문의글 삭제********/
	$('#deleteBtn').on('click',handleDelete);
	
	function handleDelete(event){
		const qnaNo = event.target.nextElementSibling.value;		
		if(confirm('삭제하시겠습니까?')){
			
			$.ajax({
				url:'adminQnaDelete/' + qnaNo,
				type: 'delete',
				dataType: 'json',
				success: function(responseObj){
					if(responseObj.deleteResult){
						alert('삭제되었습니다.');
						init();
						event.target.parentElement.parentElement.children[3].children[0].click();
					}
				},
				error: function(){
					alert('삭제실패.');
				}
				
			});
		}else{
			
		}
	}

	function init(){
		qnaList();
	}
	
	init();
	
	
	