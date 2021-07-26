<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../template/header.jsp">
	<jsp:param value="문의하기목록" name="title" />
</jsp:include>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
	

<link rel="stylesheet" href="/movie/assets/style/qnaPageCss/qnaListPage.css"/>

<!--
<script type="text/javascript">
	
	$(function(){  // 본문을 모두 읽은 뒤 처리하시오. (페이지 로드 이벤트)
		
		var qnaViews = $('.qnaView');
		$.each(qnaViews, function(idx, qnaView) {
			$(qnaView).click(function(){
				var pw = $(this).attr('data-pw');  // 게시글의 비밀번호
				var no = $(this).attr('data-no');  // 게시글의 번호
				var input_pw = ??;  // 모달/팝업등에서 사용자가 입력한 비밀번호
				if (pw == input_pw) {
					location.href = 'qnaView.do?qna_no=' + no + '&page=${page}';
				} else {
					alert('비밀번호를 확인하세요.');
				}
			});
		});
		
	});
	
</script>
-->


	<div class="wrap">
		<div class="main">
			<div class="main_top_font">
				<a class="qna_txt">FAQ</a>
				
			</div>
			<div class="main_bot">
				<a href="qnaWritePage.do" class="qna_do">글쓰기</a>
				<div class="main_bot_inner">
					<table class="table qna_list_table">
					<thead>
						<tr class="qna_list_1st_tr" id="qna_list_1st_tr">
							<td class="td qna_list_td">게시글 번호</td>
							<td class="td qna_list_td">문의 유형</td>
							<td class="td qna_list_td">제목</td>
							<td class="td qna_list_td">작성자</td>
							<td class="td qna_list_td">문의 날짜</td>
							<td class="td qna_list_td">답변 여부</td>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr>
								<td colspan="4">없음</td>
							</tr>
						</c:if>
						<c:if test="${not empty list}">
						<c:forEach var="qnaDto" items="${list}" varStatus="k">
							<tr>
								<td>${qnaDto.qna_no}</td>
								<td>${qnaDto.qna_select}</td>
							<%-- 	<c:if test="${loginUser.user_id eq 'admin' || qnaDto.qna_pw eq null}" >
									<td><a href="qnaView.do?qna_no=${qnaDto.qna_no}&page=${page}" id="pw">${qnaDto.qna_title}</a></td>
								</c:if>
								<c:if test="${loginUser.user_id eq 'admin' and qnaDto.qna_pw ne null}" >
									<td><a class="viewLinks" data-pw="${qnaDto.qna_pw}" data-no="${qnaDto.qna_no}" data-page="${page}" href="#" data-target="#layerpop" data-toggle="modal">${qnaDto.qna_title}</a></td>
								</c:if> --%>
								
								
								<c:if test="${loginUser.user_id eq 'admin'}">
									<td><a href="qnaView.do?qna_no=${qnaDto.qna_no}&page=${page}" id="pw">${qnaDto.qna_title}</a></td>
								</c:if>
								<c:if test="${loginUser.user_id ne 'admin'}">
									<c:if test="${qnaDto.qna_pw eq null }">
										<td><a href="qnaView.do?qna_no=${qnaDto.qna_no}&page=${page}" id="pw">${qnaDto.qna_title}</a></td>
									</c:if>
									<c:if test="${qnaDto.qna_pw ne null}">
										<td><a class="viewLinks" data-pw="${qnaDto.qna_pw}" data-no="${qnaDto.qna_no}" data-page="${page}" href="#" data-target="#layerpop" data-toggle="modal">${qnaDto.qna_title}</a></td>
									</c:if>
								</c:if>
								
								
								<td>${qnaDto.user_nickname}</td>
								<td>${qnaDto.qna_date}</td>
								
								<c:if test="${qnaDto.qna_yn eq 0}">
									<td>답변 대기중</td>
								</c:if>
								<c:if test="${qnaDto.qna_yn eq 1}">
									<td>답변 완료</td>
								</c:if>
								
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6">
							${paging}
						</td>
					</tr>
				</tfoot>
			</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="layerpop" >
	    <div class="modal_dialog">
	      <div class="modal_content">
	        <!-- header -->
	        <div class="modal_header">
	          <!-- 닫기(x) 버튼 -->
	          <button type="button" class="close btn btn_info" data-dismiss="modal">×</button>
	          <!-- header title -->
	          <h3 class="modal_title">비밀글 입니다.</h3>
	        </div>
	        <form>
		        <!-- body -->
		        <div class="modal_body">
		            <span class="mpw"><input type="password" name="inpPw" id="inpPw" class="inpPw" placeholder="비밀번호를 입력하세요." /></span>
		        </div>
		        <!-- Footer -->
		        <div class="modalFooter">
		          <input type="button" id="close_btn" class="modal_close" data-dismiss="modal" value="닫기" />
		          <input type="button" value="확인" id="go_btn" class="go_btn" onclick="fn_qnaView(this.form)" />
		        </div>
	        </form>
	      </div>
	    </div>
    </div>
	

	<script>
		
		$(function(){
			fn_linkClick();
		});
		
		function fn_linkClick(){
			
			var viewLinks = $('.viewLinks');
			
			$.each(viewLinks, function(idx, viewLink) {
				$(viewLink).click(function(){
					if (sessionStorage.getItem('qna_pw')) { sessionStorage.removeItem('qna_pw'); }
					if (sessionStorage.getItem('qna_no')) { sessionStorage.removeItem('qna_no'); }
					if (sessionStorage.getItem('page')) { sessionStorage.removeItem('page'); }
					sessionStorage.setItem('qna_pw', $(this).attr('data-pw'));
					sessionStorage.setItem('qna_no', $(this).attr('data-no'));
					sessionStorage.setItem('page', $(this).attr('data-page'));
				});
			});
			
		}
		
		function fn_qnaView(f){
			if(f.inpPw.value != sessionStorage.getItem('qna_pw')) {
				swal({
				    title: "Warning",
				    text: "비밀번호가 틀렸습니다.",
				    icon: "warning" //"info,success,warning,error" 중 택1
				});
				f.inpPw.value = '';
				return;
			}
			location.href = "qnaView.do?qna_no=" + sessionStorage.getItem('qna_no') + "&page=" + sessionStorage.getItem('page');
		}
		
	</script>
	
	
	
	
	
	
	
<%@ include file="../template/footer.jsp" %>