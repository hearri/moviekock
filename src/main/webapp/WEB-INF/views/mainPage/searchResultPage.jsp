<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="검색결과" name="title" />
</jsp:include>

<link rel="stylesheet"
	href="/movie/assets/style/mainPageCss/searchResultPage.css" />

<div class="wrap">
	<div class="main">
		<c:if test="${empty resultList}">
				검색된 영화가 없습니다.
			</c:if>
		<c:if test="${not empty resultList}">
			<p class="title">'${search}'에 대한 검색내용입니다.</p>
			<div class="container">
				<c:forEach var="movieDto" items="${resultList}">
					<div class="mainMovieList">
						<div class="list">
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg" />
						</div>
						<div class="info">
							<h4>${movieDto.movie_title.replace('_',' ')}</h4>
						</div>
						<input type="hidden" id="movieNo" value="${movieDto.movie_no }" />
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>
<script>
	$(document).on("click", ".mainMovieList", movePage);

	function movePage(event) {

		const movieNo = event.currentTarget.children[2].value;

		location.href = "movieInfoPage.do?movieNo=" + movieNo;
	}
</script>

<%@ include file="../template/footer.jsp"%>