<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="template/header.jsp">
	<jsp:param value="회원관리 페이지" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/movie/assets/style/adminPage/usersPage.css">
	<div class="main-wrap">
		<div class="inner-wrap">
			전체 유저 수: <span id="totalCount"></span> 명
			<table class="bordered">
                    <thead>
                        <tr id="commentHead">
                            <th>회원 번호</th>
                            <th>아이디</th>
                            <th>닉네임</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>휴대폰 번호</th>
                            <th>가입일</th>
                            <th>커버</th>
                            <th>프로필</th>
                        </tr>
                    </thead>

                    <tbody id="userList"></tbody>

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
	           <jsp:include page="template/userViewModal.jsp">
					<jsp:param value="modalView" name="title" />
			   </jsp:include>
	       </div>
	       <div class="footer-btn-box">
				<input type="button" value="삭제하기" class="btn btn-info none" id="deleteBtn"/>
				<input type="hidden" id="userNo" value="userNo" value=""/>
       	   </div>
	       <!-- Footer -->
	       <div class="modal-footer">
	         <button type="button" id="close-btn" class="btn btn-info" data-dismiss="modal">닫기</button>
	       </div>
	     </div>
	   </div>
	 </div>
	
	<script src="/movie/assets/script/admin/usersPage.js"></script>
</body>
</html>