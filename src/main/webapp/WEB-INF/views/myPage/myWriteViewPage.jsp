<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<link rel="stylesheet" href="/movie/assets/style/myPageCss/myWriteViewPage.css"/>
	 <div class="container">
    <div class="main-wrapper-my-write">

      <div class="section-left">

        <div class="movie-name">
          <span class="movie-name-span">
          <!-- 영화 타이틀 -->
          </span>
        </div>
        <div class="movie-poster">
          <div class="movie-poster-img">
			<!-- 영화 포스터 -->
			<input type="hidden" id="movieNo" />
          </div>
        </div>
      </div>
      <div class="section-right">
        <div class="top-title">
          <span class="top-title-contents">
          <!-- 글제목 -->
          </span>
          <span class="movie-score-box">
          	<i class="fas fa-star fa-2x"></i><span class="movie-score">4.5</span>
          </span>
        </div>
        <div class="top-contents">
          <span class="writer">
            <!-- 작성자: 홍길동 -->
          </span>
          <span class="write-date">
           <!--  작성일자: 2021-01-27 -->
          </span>
        </div>
        <div class="right-textarea">
          <div class="right-textarea-contents">
		   <!-- 글 컨텐츠 -->
          </div>
        </div>
        
	   <input type="hidden" class="commentNo" id="commentNo" value="0"/>

      </div>

    </div>
  </div>
  
  <script>
  	$('.movie-poster-img').on('click',handleMovieInfo);
  	
  	function handleMovieInfo(event){
  		
  		let movieNo = event.target.children[0].value;
  		
  		location.href='movieInfoPage.do?movieNo=' + movieNo;
  		
  	}
  	
  	
  </script>
