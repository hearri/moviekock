<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <link rel="stylesheet" href="/movie/assets/style/adminPage/movieViewModal.css">
 
 <div class="modalContainer">
   	<div class="snapShotBox"><span class="desc">스냅샷</span></div>
   	<div class="contentsBox">
	   	<div class="posterBox"><span class="desc">포스터</span></div>
   		<div class="movieInfoBox">
   			
   			<table class="movieInfoTable" >
   				<tr>
   					<td>영화 번호</td>
   					<td class="movieNo"></td>
   				</tr>
   				<tr>
   					<td>영화 명</td>
   					<td class="movieTitle"><input type="text" name="movieName" id="movieTitle" readonly></td>
   				</tr>
   				<tr>
   					<td>감독</td>
   					<td class="movieDirector"><input type="text" name="movieDirector" id="movieDirector" readonly></td>
   				</tr>
   				<tr>
   					<td>관객수</td>
   					<td class="movieAudience"><input type="text" name="movieAudience" id="movieAudience" readonly></td>
   				</tr>
   				<tr>
   					<td>개봉 일</td>
   					<td class="movieDate"><input type="text" name="movieDate" id="movieDate" placeholder="yyyy-mm-dd" readonly></td>
   				</tr>
   				<tr>
   					<td>개봉 국가</td>
   					<td class="movieNation"><input type="text" name="movieNation" id="movieNation" readonly></td>
   				</tr>
   				<tr>
   					<td>장르</td>
   					<td class="movieGenre"><input type="text" name="movieGenre" id="movieGenre" readonly></td>
   				</tr>
   				<tr>
   					<td>평점</td>
   					<td class="movieScore"><input type="text" name="movieScore" id="movieScore" placeholder="0~5" readonly></td>
   				</tr>
   			</table>
   			<div class="story">
	   			<span>줄거리</span><br/>
	   			<textarea name="movieStory" id="movieStory" readonly></textarea>
   			</div>
   		</div>
   		
   	</div>
 </div>
  
  <script>
  	
  </script>
