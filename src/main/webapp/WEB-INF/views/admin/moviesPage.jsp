<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="template/header.jsp">
	<jsp:param value="영화 관리" name="title"/>
</jsp:include>
<link rel="stylesheet" href="/movie/assets/style/adminPage/moviesPage.css">

<div class="main-wrap">
		<div class="inner-wrap">
			전체 영화 수: <span id="totalCount"></span> 개
			<table class="bordered">
                    <thead>
                        <tr id="commentHead">
                            <th>영화 번호</th>
                            <th>영화 명</th>
                            <th>감독</th>
                            <th>관객수</th>
                            <th>개봉 일</th>
                            <th>개봉 국가</th>
                            <th>장르</th>
                            <th>평점</th>
                        </tr>
                    </thead>

                    <tbody id="movieList"></tbody>

                    <tfoot>
                        <tr id="bottom-paging">
                            <td colspan="8">
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
	         <h4 class="modal-title">영화 정보</h4>
	       </div>
	       <!-- body -->
	       <div class="modal-body">
	           <jsp:include page="template/movieViewModal.jsp">
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

	<script src="/movie/assets/script/admin/moviesPage.js"></script>
	

</body>
</html>