<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="문의하기 상세보기" name="title" />
</jsp:include>

<link rel="stylesheet" href="/movie/assets/style/qnaPageCss/qnaViewPage.css"?ver=1 />
	<div class="wrap">
		<div class="main">
			<div class="main_body">
				<table class="table_user_write">
				<tr class="user_write_tr">
					<td class="user_write_td" colspan="6">제목</td>
				</tr>
					<tr>
						<td id="title" colspan="6">${qnaDto.qna_title}</td>	
					</tr>
					<tr class="user_write_tr">
						<td class="user_write_td">문의 유형</td><td>${qnaDto.qna_select}</td>
						<td class="user_write_td">작성자</td><td>${qnaDto.user_nickname}</td>
						<td class="user_write_td">문의 날짜</td><td>${qnaDto.qna_date}</td>
					</tr>
					<tr>
						<td colspan="6" id="contents"class="user_write_td_resp user_write_td_fst">${qnaDto.qna_content}</td>
					</tr>
				</table>
				<table class="table_reply_content">
					<tr class="reply_content_tr">
						<td class="reply_content_td user_write_td_fst">답변 내용</td>
						<td class="reply_content_td">답변 날짜</td>
						<td class="reply_content_td">답변 여부</td>
					</tr>
					<c:if test="${qnaDto.qna_yn eq 0}">
					<tr class="reply_content_tr_resp">
						<td class="reply_content_td_resp user_write_td_fst">아직 답변이 등록되지 않았습니다</td>
						<td class="reply_content_td_resp">---</td>
						<td class="reply_content_td_resp">답변 대기중</td>
					</tr>
					</c:if>
					<c:if test="${qnaDto.qna_yn eq 1}">
					<tr class="reply_content_tr_resp">
						<td class="reply_content_td_resp user_write_td_fst">${qnaReplyDto.qna_reply_content}</td>
						<td class="reply_content_td_resp">${qnaReplyDto.qna_reply_date}</td>
						<td class="reply_content_td_resp">답변 완료</td>
					</tr>
					</c:if>
				</table>
				<form method="post">
					<c:if test="${loginUser.user_id eq 'admin' || qnaDto.user_no eq loginUser.user_no  }">
						<input type="button" class="delete_btn" value="삭제"  onclick="fn_qnaDelete(this.form)" />
						<input type="hidden" name="qna_no" value="${qnaDto.qna_no}" />
						<input type="hidden" name="qna_reply_no" value="${qnaReplyDto.qna_reply_no}" />
					</c:if>
				</form>
				<form method="get">
					<input type="button" class="list_btn" value="목록" onclick="fn_qnaListView(this.form)" />	
				</form>
				<form method="get">
					<c:if test="${loginUser.user_id eq 'admin' and qnaDto.qna_yn eq 0}">
						<input type="hidden" name="page" value="${page}" />
						<input type="hidden" name="qna_no" value="${qnaDto.qna_no}" />
						<input type="button" class="qna_reply_btn" value="답변하기" onclick="fn_qnaReplyPage(this.form)" />
					</c:if>
				</form>
			</div>
		</div>
	</div>
	
					
	<script type="text/javascript">
 	
 	function fn_qnaDelete(f) {
		if (confirm('삭제할까요?')) {
			f.action = 'qnaDelete.do';
			f.submit();
		}
	}
 	
 	function fn_qnaListView(f) {
			f.action = 'qnaListView.do';
			f.submit();
		}
 	
 	function fn_qnaReplyPage(f) {
			f.action = 'qnaReplyPage.do';
			f.submit();
		}
	
 	
 	
 	</script>
	
	

<%@ include file="../template/footer.jsp" %>