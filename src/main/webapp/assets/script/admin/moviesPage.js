// 페이징 처리
	let page = 1;  // 초기화
	let is_progress;
	
	
	/***** 1. 회원 목록 *****/
	function movieList() {
		if(is_progress == true){
			return;
		}
		is_progress = true;
		
		let obj= {
			"page": page,
		};
		
		$.ajax({
			url: 'movieList.admin',
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
								"id": "movie1",
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
				
				$('#movieList').empty();  // 기존 목록 제거
				
				// 회원이 있으면,
				if (result.exist) {
					$('#totalCount').html(paging.totalRecord);  // 전체 영화 수 출력
					movieListTable(result.list, result.paging.totalRecord);  // 목록 출력
				}
				// 회원이 없으면,
				else {
					$('#totalCount').html('0');
					$('<tr>')
					.append($('<td colspan="6" style="height: 20px;">').html('데이터가 없습니다.'))
					.appendTo('#movieList');
				}
				
				
				// 여기서부터 movieList() 끝까지 페이징 처리
				
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
			movieList();
		});
		$('body').on('click', '.go-page', function(){
			page = $(this).attr('data-page');
			movieList();
		});
		$('body').on('click', '.next-block', function(){
			page = $(this).attr('data-page');
			movieList();
		});
		
	}  // end movieList()
	
	// 서브 함수: 회원 목록을 테이블로 만들어 주는 함수
	function movieListTable(list, totalRecord) {
		$.each(list, function(idx, movie){
//			 날짜 타입스탬프 밀리세컨드 값 포맷
			 let getDate = new Date(movie.movie_opening_date);
			 let yyyy = getDate.getFullYear().toString();                                   
	         let mm = (getDate.getMonth()+1).toString(); // getMonth() is zero-based        
	         let dd  = getDate.getDate().toString();
	         let hh  = getDate.getHours().toString();
	         let mi  = getDate.getMinutes().toString();
	         let ss  = getDate.getSeconds().toString();
	         let date = yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);

	         let string = `<tr><td>${movie.movie_no}</td>
							<td>
								<a href="#" id="movieView" data-target="#layerpop" data-toggle="modal"> ${movie.movie_title.replaceAll('_' , ' ')} </a>
					        	 <input type="hidden" name="movieNo" value= ${movie.movie_no} >
					        	 <input type="hidden" name="movieTitle" value= ${movie.movie_title} >
								<input type="hidden" name="movieDirector" value= ${movie.movie_director} >
								<input type="hidden" name="movieAudience" value=${movie.movie_audience} >
					        	 <input type="hidden" name="movieDate" value=${date} >
					        	 <input type="hidden" name="movieNation" value=${movie.movie_nation} >
					        	 <input type="hidden" name="movieGenre" value=${movie.genre_name} >
					        	 <input type="hidden" name="movieScore" value=${movie.movie_web_score} >
					        	 <input type="hidden" name="movieStory" value="${movie.movie_story}" />
								</td>
							<td>${movie.movie_director.replaceAll('_' , ' ')}</td>
				        	 <td>${movie.movie_audience}</td>
				        	 <td>${date}</td>
				        	 <td>${movie.movie_nation}</td>
							<td>${movie.genre_name}</td>
							<td>${movie.movie_web_score}</td></tr>`;
			$('#movieList').append(string);
			/* $('<tr>')
			.append( $('<td>').html(totalRecord - (recordPerPage * (page - 1)) - idx ) ) 
			.append( $('<td>').html(comment.movie_no) )
			.append( $('<td>').html(comment.comments_title) ).data('target', '#layerpop').data('toggle','modal')
			.append( $('<td>').html('닉네임' ) )
			.append( $('<td>').html(comment.comment_date) )
			.append( $('<td>').html(comment.comment_like) )
			.append( $('<input type="hidden" name="movieNo" />').val( ${loginmovie.movie_no} ) )
			.append( $('<input type="hidden" name="movieNo" />').val( comment.movie_no ) )
			.append( $('<input type="hidden" name="comentNo" />').val(comment.comment_no) )  // 회원 삭제에서 사용할 id를 새로 추가했습니다.
			.append( $('<td>').html('<input type="button" value="조회" id="btnView" /><input type="button" value="삭제" id="btnDelete" />'))
			.appendTo('#movieList'); */
		});
	}
	
	/****** 회원 보기********/
	$(document).on("click","#movieView",handleView);
	function handleView(event){
		const movieNo = event.currentTarget.parentNode.children.movieNo.value;
		const movieTitle = event.currentTarget.parentNode.children.movieTitle.value;
		const movieDirector = event.currentTarget.parentNode.children.movieDirector.value;
		const movieAudience = event.currentTarget.parentNode.children.movieAudience.value;
		const movieDate = event.currentTarget.parentNode.children.movieDate.value;
		const movieNation = event.currentTarget.parentNode.children.movieNation.value;
		const movieGenre = event.currentTarget.parentNode.children.movieGenre.value;
		const movieScore = event.currentTarget.parentNode.children.movieScore.value;
		const movieStory = event.currentTarget.parentNode.children.movieStory.value;
		
		sendModalView(movieNo, movieTitle, movieDirector, movieAudience, movieDate, movieNation, movieGenre, movieScore, movieStory);
		
	}
	
	/* 버튼 클릭 시 모달창에 정보전달 */
	function sendModalView(movieNo, movieTitle, movieDirector, movieAudience, movieDate, movieNation, movieGenre, movieScore, movieStory){
		
		$('.movieNo').text(movieNo);
		$('#movieTitle').val(movieTitle.replaceAll('_' , ' '));
		$('#movieDirector').val(movieDirector.replaceAll('_' , ' '));
		$('#movieAudience').val(movieAudience);
		$('#movieDate').val(movieDate);
		$('#movieNation').val(movieNation);
		$('#movieGenre').val(movieGenre);
		$('#movieScore').val(movieScore);
		$('#movieStory').val(movieStory);
		
		$('.snapShotBox').css('background-image','url(/movie/assets/images/snap/'+ movieTitle + '_스냅샷.jpg' +')');
		
		$('.posterBox').css('background-image','url(/movie/assets/images/poster/'+ movieTitle + '_포스터.jpg' +')');
		
		
	}
	
	
//	/****** 회원 삭제********/
//	$('#deleteBtn').on('click',handleDelete);
//	
//	function handleDelete(event){
//		const movieNo = event.target.nextElementSibling.value;
//		
//		if(confirm('삭제하시겠습니까?')){
//			
//			$.ajax({
//				url:'movieDelete/' + movieNo,
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
//					
//				}
//				
//			});
//		}else{
//			
//		}
//	}

	
	
	
	function init(){
		movieList();
	}
	
	init();
	
	
	