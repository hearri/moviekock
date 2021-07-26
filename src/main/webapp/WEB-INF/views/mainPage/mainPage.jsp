<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../template/header.jsp">
	<jsp:param value="메인페이지" name="title" />
</jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link rel="stylesheet" href="/movie/assets/style/mainPageCss/mainPage.css?ver=1" />
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<script>

	function fn_logout(){
		location.href="logout.do";
	}
	
	
	if('${afterInsert}'){
		
		if('${insertResult}' > 0){
			alert('회원가입 성공');
		}else{
			alert('회원가입 실패');
			
		}
	}
</script>

<div class="wrap">
	<div class="main">
		<div class="swiper-container s2">
			<c:if test="${not empty userNickname }">
			
				<h3>${userNickname }님의 취향 저격 영화들</h3>
			</c:if>
			<c:if test="${empty userNickname }">
			
				<h3>무비콕의 영화 추천!</h3>
			</c:if>
			<div class="swiper-wrapper">
				<c:forEach var="movieDto" items="${mainList2}" varStatus="i">
					<div class="swiper-slide">
						<div class="movie">
							<div class="rankBadge">${i.count}</div>
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg">
						</div>
						<div class="info">
							<div class="text">
								<h4>${movieDto.movie_title.replaceAll("_"," ")}</h4>
								<p>${movieDto.movie_nation}&nbsp;&nbsp;
									평점 <c:if test="${fn:length(movieDto.movie_web_score) == 1 }">
												${ movieDto.movie_web_score}.0
										 </c:if>
										 <c:if test="${fn:length(movieDto.movie_web_score) > 1 }">
												${ movieDto.movie_web_score}
										 </c:if>
										 <br /> 장르 ${movieDto.genre_name}</p>
							</div>
						</div>
						<input type="hidden" id="movieNo" value="${movieDto.movie_no }" />
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="swiper-button-next n2"></div>
		<div class="swiper-button-prev p2"></div>
	</div>
	<div class="main">
		<div class="swiper-container s1">

			<h3>${today}요일에 딱 맞는 영화</h3>
			<div class="swiper-wrapper">
				<c:forEach var="movieDto" items="${mainList1}" varStatus="i">
					<div class="swiper-slide">
						<div class="movie">
							<div class="rankBadge">${i.count}</div>
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg">
						</div>
						<div class="info">
							<div class="text">
								<h4>${movieDto.movie_title.replaceAll("_"," ")}</h4>
								<p>${movieDto.movie_nation}&nbsp;&nbsp;
									평점<c:if test="${fn:length(movieDto.movie_web_score) == 1 }">
												${ movieDto.movie_web_score}.0
										 </c:if>
										 <c:if test="${fn:length(movieDto.movie_web_score) > 1 }">
												${ movieDto.movie_web_score}
										 </c:if>
										 <br /> 장르 ${movieDto.genre_name}</p>
							</div>
						</div>
						<input type="hidden" id="movieNo" value="${movieDto.movie_no }" />
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="swiper-button-next n1"></div>
		<div class="swiper-button-prev p1"></div>
	</div>
	<div class="main">
		<div class="swiper-container s3">
			<h3>박스오피스</h3>

			<div class="swiper-wrapper">
				<c:forEach var="movieDto" items="${mainList3}">
					<div class="swiper-slide">
						<div class="movie">
							<div class="rankBadge">${movieDto.movie_no}</div>
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg">
						</div>
						<div class="info">
							<div class="text">
								<h4>${movieDto.movie_title.replaceAll("_"," ")}</h4>

								<p>${movieDto.movie_nation}&nbsp;&nbsp;
									평점 <c:if test="${fn:length(movieDto.movie_web_score) == 1 }">
												${ movieDto.movie_web_score}.0
										 </c:if>
										 <c:if test="${fn:length(movieDto.movie_web_score) > 1 }">
												${ movieDto.movie_web_score}
										 </c:if>
										 <br /> 장르 ${movieDto.genre_name }								</p>

							</div>
						</div>
						<input type="hidden" id="movieNo" value="${movieDto.movie_no }" />
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="swiper-button-next n3"></div>
		<div class="swiper-button-prev p3"></div>
	</div>
	<div class="main">

		<div class="swiper-container s4">
			<h3>개봉순</h3>

			<div class="swiper-wrapper">
				<c:forEach var="movieDto" items="${mainList4}" varStatus="i">
					<div class="swiper-slide">
						<div class="movie">
							<div class="rankBadge">${i.count}</div>
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg">
						</div>
						<div class="info">
							<div class="text">
								<h4>${movieDto.movie_title.replaceAll("_"," ")}</h4>
								<p>${movieDto.movie_nation}&nbsp;&nbsp;
									평점 <c:if test="${fn:length(movieDto.movie_web_score) == 1 }">
												${ movieDto.movie_web_score}.0
										 </c:if>
										 <c:if test="${fn:length(movieDto.movie_web_score) > 1 }">
												${ movieDto.movie_web_score}
										 </c:if>
										 <br /> 장르 ${movieDto.genre_name }
								</p>
							</div>
						</div>
						<input type="hidden" id="movieNo" value="${movieDto.movie_no }" />
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="swiper-button-next n4"></div>
		<div class="swiper-button-prev p4"></div>
	</div>
	<div class="main">
		<div class="swiper-container s5">
			<h3>한국영화</h3>
			<div class="swiper-wrapper">
				<c:forEach var="movieDto" items="${mainList5}" varStatus="i">
					<div class="swiper-slide">
						<div class="movie">
							<div class="rankBadge">${i.count}</div>
							<img src="/movie/assets/images/poster/${movieDto.movie_title}_포스터.jpg">
						</div>
						<div class="info">
							<div class="text">
								<h4>${movieDto.movie_title.replaceAll("_"," ")}</h4>

								<p>${movieDto.movie_nation}&nbsp;&nbsp;
									평점 <c:if test="${fn:length(movieDto.movie_web_score) == 1 }">
												${ movieDto.movie_web_score}.0
										 </c:if>
										 <c:if test="${fn:length(movieDto.movie_web_score) > 1 }">
												${ movieDto.movie_web_score}
										 </c:if>
										 <br /> 장르 ${movieDto.genre_name }
								</p>

							</div>
						</div>
						<input type="hidden" id="movieNo" value="${movieDto.movie_no }" />
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="swiper-button-next n5"></div>
		<div class="swiper-button-prev p5"></div>
	</div>
	</div>
<script src="../dist/js/swiper.min.js"></script>
<script>

	var list = [
		{'s': '.s1', 'n': '.n1', 'p': '.p1'},
		{'s': '.s2', 'n': '.n2', 'p': '.p2'},
		{'s': '.s3', 'n': '.n3', 'p': '.p3'},
		{'s': '.s4', 'n': '.n4', 'p': '.p4'},
		{'s': '.s5', 'n': '.n5', 'p': '.p5'}
	]
	
	$.each(list, function(idx, item){
		new Swiper(item.s, {
			slidesPerView : 6,
			spaceBetween : 20,
			slidesPerGroup : 6,
			loop : true,
			loopFillGroupWithBlank : false,
			navigation : {
				nextEl : item.n,
				prevEl : item.p,
			},
		});
		
	}) 
 
	$(document).on("click", ".wrap .swiper-slide", handleMovie);

	function handleMovie(event) {

		const movieNo = event.currentTarget.children[2].value;

		location.href = "index.do?movieNo" + movieNo;
	}

	$(document).on("click", ".swiper-slide", movePage);

	function movePage(event) {

		const movieNo = event.currentTarget.children[2].value;

		location.href = "movieInfoPage.do?movieNo=" + movieNo;
	}
</script>

<%@ include file="../template/footer.jsp"%>