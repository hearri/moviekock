<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../template/header.jsp">
	<jsp:param value="검색결과" name="title" />
</jsp:include>

<link rel="stylesheet"
	href="/movie/assets/style/myPageCss/wishList.css" />

<div class="wrap">
	<div class="main">
		<p class="title-topName">${userNickname } 님이 보고싶은 영화입니다.</p>
		<div class="main-movieList">
		
			<c:forEach items="${movieDtoList }" var="movieDto">
				
				<div class="list" style="background-image: url('/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg'); background-size: 230px 300px;">
					<input type="hidden" name="movieNo" value="${movieDto.movie_no }" />
				</div>
				
			</c:forEach>
			
		</div>
	</div>
</div>



<script>
	$('.list').on('click',handleMovieClick);
	
	function handleMovieClick(event){
		
		let movieNo = event.target.children.movieNo.value;
		
		location.href= 'movieInfoPage.do?movieNo=' + movieNo;
	}
	
</script>

<%@ include file="../template/footer.jsp"%>