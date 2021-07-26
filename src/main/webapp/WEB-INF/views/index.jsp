<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="template/header.jsp">
	<jsp:param value="인덱스" name="title" />
</jsp:include>
<script>
	function fn_logout(){
		location.href="logout.do";
	}
	
</script>
<style>
	body{
		margin-top: 95px;
	}
</style>
	<a href="mainPage.do">메인페이지</a><br>
	<a href="searchResultPage.do">검색</a>
	<br><br>
	
	
	-마이 페이지-<br>
	<a href="myPage.do">마이페이지 이동</a><br>
	<a href="myWritePage.do">내가 쓴 글 페이지 이동</a><br>
	<a href="myWriteViewPage.do">내가 쓴글 보기페이지</a><br>
	<a href="#" data-target="#layerpop" data-toggle="modal">내가 쓴글 보기페이지-모달창-</a><br><br>

	-추천 페이지-<br>
	<a href="categoryRecommandPage.do">장르별 추천 페이지로 이동</a><br>
	<a href="recommandPage.do">기분 상황별 추천 페이지이동</a><br><br>

	-회원가입-<br>
	<c:if test="${ not empty loginUser }">
		<input type="button" value="로그아웃" onclick="fn_logout()" method="post" />
	</c:if>
	<c:if test="${ empty loginUser }">
		<a href="loginPage.do">로그인 페이지로 이동</a><br>
	</c:if>
	<a href="signupPage.do">회원가입</a><br>
	<a href="signupChoicePage.do">회원가입시 영화선택페이지</a><br>
	<a href="findIdpwPage.do">아이디 비밀번호 찾기</a><br>
	<a href="privacyAgreementPage.do">개인정보약관동의사이트</a><br><br>
	<a href="updatePwPage.do">비밀번호변경페이지</a><br><br>
	
	-영화 정보보기 페이지-<br>
	<a href="movieInfoPage.do">영화 INFO 페이지</a><br>
	<a href="movieCommentPage.do">코멘트 페이지</a><br><br>
	
	-문의하기-<br>
	<a href="qnaWritePage.do">문의하기 페이지</a><br>
	<a href="qnaListView.do">문의목록 페이지</a><br>
<!-- 	<a href="qnaViewPage.do">문의보기 페이지</a><br> -->
	<a href="qnaReplyPage.do">관리자 답변하기 페이지</a><br>
	
	

	
	

	
	<!-- modal -->
	<style>
		.modal-dialog{
			width: 1200px
		}
		
	</style>
  <div class="modal fade" id="layerpop" >
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- header -->
        <div class="modal-header">
          <!-- 닫기(x) 버튼 -->
          <button type="button" class="close" data-dismiss="modal">×</button>
          <!-- header title -->
          <h4 class="modal-title">영화 이름</h4>
        </div>
        <!-- body -->
        <div class="modal-body">
            <jsp:include page="myPage/myWriteViewPage.jsp">
				<jsp:param value="test" name="title" />
			</jsp:include>
        </div>
        <!-- Footer -->
        <div class="modal-footer">
          <button type="button" id="close-btn" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>
	대충 내용<br/>

<script>
	
	if('${afterInsert}'){
		
		if('${insertResult}' > 0){
			alert('회원가입 성공');
		}else{
			alert('회원가입 실패');
			
		}
	}
	
	
</script>
	
	
<%@ include file="template/footer.jsp" %>