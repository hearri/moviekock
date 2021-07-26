<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../template/header.jsp">
	<jsp:param value="내가 쓴 글 목록" name="title" />
</jsp:include>

<link rel="stylesheet" href="/movie/assets/style/myPageCss/myWritePage.css"/>
<!--         <div class="big-box"> -->
<%--         	<div class="coverBox" style="background-image: url(/movie/assets/images/userCover/${loginUser.user_image_name}) ">
        	
        	</div>
        	
            <div class="profileBox" style="background-image: url(/movie/assets/images/userProfile/${loginUser.user_profile_name}) ">
            
            </div> --%>
        	
       <div class="wrap">
       	<div id="title">
       		<a class="myWrite-txt">내가 쓴 글</a>
       	</div>
              <div class="tableBox" >
                <table class="bordered">
                    <thead>
                        <tr id="commentHead">
                            <th>글 번호</th>
                            <th>제목</th>
                            <th>닉네임</th>
                            <th>작성일</th>
                            <th>좋아요</th>
                        </tr>
                    </thead>

                    <tbody id="commentList"></tbody>

                    <tfoot>
                        <tr id="bottom-paging">
                            <td colspan="7">
                                <div id="paging" class="paging"></div>
                            </td>
                        </tr>
                    </tfoot>
                </table>

              </div>
<!--             </div> -->
              
<!--               <div class="tableBox" > -->
<!--                 <div class="table"> -->
<!-- 					<div class="thead"> -->
<!-- 						<div class="tr thead_tr"> -->
<!-- 							<div class="th">글 번호</div> -->
<!-- 							<div class="th">영화</div> -->
<!-- 							<div class="th">제목</div> -->
<!-- 							<div class="th">닉네임</div> -->
<!-- 							<div class="th">작성일</div> -->
<!-- 							<div class="th">좋아요</div> -->
<!-- 							<div class="th">비고</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="tbody" id="commentList"></div> -->
					
<!-- 					<div class="tfoot"> -->
<!-- 						<div class="tr"> -->
<!-- 							<div class="td"> -->
<!-- 								<div id="paging" class="paging"></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
                
<!--               </div> -->
              
         
            
            <!-- modal -->
	 <div class="modal fade" id="layerpop" >
	   <div class="modal-dialog">
	     <div class="modal-content">
	       <!-- header -->
	       <div class="modal-header">
	         <!-- 닫기(x) 버튼 -->
	         <button type="button" class="close btn btn-info" data-dismiss="modal">×</button>
	         <!-- header title -->
	         <h4 class="modal-title">영화 이름</h4>
	       </div>
	       <!-- body -->
	       <div class="modal-body">
	           <jsp:include page="myWriteViewPage.jsp">
					<jsp:param value="test" name="title" />
			   </jsp:include>
	       </div>
	       <div class="footer-btn-box">
				<input type="button" value="수정하기" class="btn btn-info none" id="updateControlBtn" onclick="fn_commentUpdateControl()"/>
	      		<input type="button" value="수정완료" class="btn btn-info none" id="updateComment" onclick="fn_commentUpdate()"/>
				<input type="button" value="삭제하기" class="btn btn-info none" id="deleteBtn" onclick="fn_commentDeleteBtn()"/>
       	   </div>
	       <!-- Footer -->
	       <div class="modal-footer">
	         <button type="button" id="close-btn" class="btn btn-info" data-dismiss="modal">닫기</button>
	       </div>
	     </div>
	   </div>
	 </div>
            
    <script src="/movie/assets/script/commentView.js"></script>
 	   </div>
    </body>
	

	<%@ include file="../template/footer.jsp"%>