<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="template/header.jsp">
	<jsp:param value="문의하기 관리" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/movie/assets/style/adminPage/qnaPage.css">
	<div class="main-wrap">
		<div class="inner-wrap">
			전체 문의글 수: <span id="totalCount"></span> 개
			<table class="bordered">
                    <thead>
                        <tr id="commentHead">
                            <th>게시글 번호</th>
                            <th>닉네임</th>
                            <th>문의 유형</th>
                            <th>제목</th>
                            <th>문의 날짜</th>
                            <th>답변 여부</th>
                        </tr>
                    </thead>

                    <tbody id="qnaList"></tbody>

                    <tfoot>
                        <tr id="bottom-paging">
                            <td colspan="9">
                                <div id="paging" class="paging"></div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
			
		</div>
	
	</div>
	
	<!-- modal -->
	<style>
		.modal-dialog {
		    width: 800px;
		    /* height: 500px; */
		}
		.modal-body {
		    height: 700px;
		}
		.footer-btn-box {
		    text-align: right;
		    margin: 5px 13px 10px 0px;
		}
	
	</style>
	 <div class="modal fade" id="layerpop" >
	   <div class="modal-dialog">
	     <div class="modal-content">
	       <!-- header -->
	       <div class="modal-header">
	         <!-- 닫기(x) 버튼 -->
	         <button type="button" class="close btn btn-info" data-dismiss="modal">×</button>
	         <!-- header title -->
	         <h4 class="modal-title">회원 정보</h4>
	       </div>
	       <!-- body -->
	       <div class="modal-body">
	           <jsp:include page="template/qnaViewModal.jsp">
					<jsp:param value="modalView" name="title" />
			   </jsp:include>
	       </div>
	       <div class="footer-btn-box">
				<input type="button" value="삭제하기" class="btn btn-info none" id="deleteBtn"/>
				<input type="hidden" id="qnaNo" value="qnaNo" value=""/>
       	   </div>
	       <!-- Footer -->
	       <div class="modal-footer">
	         <button type="button" id="close-btn" class="btn btn-info" data-dismiss="modal">닫기</button>
	       </div>
	     </div>
	   </div>
	 </div>

	<script src="/movie/assets/script/admin/qnaPage.js"></script>
</body>
</html>