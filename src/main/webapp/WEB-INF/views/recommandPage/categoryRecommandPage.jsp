<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="장르별 추천 페이지" name="title" />
</jsp:include>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />

<link rel="stylesheet" href="/movie/assets/style/recommandPageCss/categoryRecommandPage.css"/>

  <div class="main-wrapper">

    <div class="nav-category">
      <form name="form" class="form-inline">
		  <div class="form-group">
		  	<select id="genre" name="genre" class="left form-control" onChange="formChange()">
		  	  <option value="0">모든장르</option>
	          <option value="1">코미디</option>
	          <option value="2">드라마</option>
	          <option value="3">액션</option>
	          <option value="4">로맨스</option>
	          <option value="5">판타지</option>
	          <option value="6">멜로</option>
	          <option value="7">모험</option>
	          <option value="8">범죄</option>
	          <option value="9">SF</option>
	          <option value="10">스릴러</option>
	          <option value="11">전쟁</option>
	          <option value="12">공포</option>
	        </select>
		  </div>
		  <div>
		  	<select name="sort" class="right sort" onChange="formSort()">
		  	  <option value="0">평점순</option>
	          <option value="1">가나다순</option>
	          <option value="2">개봉일순</option>	  	
		  	</select>
		  </div>
	  </form>
 </div>	  
 
 
  <div class="main-movieList">

		<c:forEach var="movieDto" items="${movieAllList}" varStatus="i">
					<div class="movie-box">
						<div class="movie">
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg">
						</div>
						<div class="default-info">
							<div class="text">
								<h4>${movieDto.movie_title.replaceAll("_"," ")}</h4>
								<p>${movieDto.movie_nation}&nbsp;&nbsp;
									평점 ${movieDto.movie_web_score }<br /> 장르 ${movieDto.genre_name }
								</p>
							</div>
						</div>	
						<input type="hidden" id="movieNo" value="${movieDto.movie_no}" />
					</div>		
			</c:forEach>
		</div>	
 
  </div>

 
<script>

function formChange(){
	
	const genreNo =  $('#genre').val(); 
		$.ajax({
				url:'RecomandGenrePage/' + genreNo,
				type:'get',
				dataType:'json',
				success: function(responseObj){
        			const movieList = responseObj.movieGenreList;
        		$('.main-movieList').empty();
        			movieList.forEach(function(movieN){
        				console.log(movieN);
        				const movieOne = '<div class="insert-movie-box"><div class="movie-insert" style="background-image: url(/movie/assets/images/poster/'
        						+ movieN.movie_title+'_포스터.jpg' + '); background-size:210px 100%;"></div>'
						+'<div class="insert-info"><div class="text"><h4>'+movieN.movie_title.replaceAll("_"," ")+'</h4><p>'+movieN.movie_nation+'&nbsp;&nbsp;평점 '
						+movieN.movie_web_score+'<br/> 장르 '+movieN.genre_name+
						'</p></div></div><input type="hidden" id="movieNo" value="'+movieN.movie_no+'" /></div></div>';
							
						
						$('.main-movieList').append(movieOne);
        			});
     
  
        		},
        		error: function(){
        			
        		}
			
   
	}) ;
}	
$(document).on("click",".movie-box",movePage1);
function movePage1(event){
	
	const movieNo = event.currentTarget.children[2].value;
	
	location.href = "movieInfoPage.do?movieNo=" + movieNo;
}
$(document).on("click",".insert-movie-box",movePage2);
function movePage2(event){
	
	const movieNo = event.currentTarget.children[2].value;
	
	location.href = "movieInfoPage.do?movieNo=" + movieNo;
}
</script>

<%@ include file="../template/footer.jsp" %>