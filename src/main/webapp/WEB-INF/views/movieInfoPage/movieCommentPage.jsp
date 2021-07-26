<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    
<jsp:include page="../template/header.jsp">
	<jsp:param value="코멘트" name="title" />
</jsp:include>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
<link rel="stylesheet" href="/movie/assets/style/movieInfoPageCss/movieCommentPage.css"/>

<body>

<div class="wrap">
		<input type="hidden" id="movieNo" value="${movieNo }" />
        <div class="main_line">
          <div class="back_box">
          <i class="fas fa-arrow-left fa-4x" id="back" onclick=""></i>
          </div>  
        </div>
        
        <c:if test="${empty commentDtoList }">
        	<script>
        		alert('등록된 코멘트가 없습니다.');
        		history.go(-1);
        	</script>
        	
        </c:if>
        <c:if test="${not empty commentDtoList }">
	        <c:forEach items="${commentDtoList }" var="commentDto">
				<div class="main-top comment_bot">
				  <div class="box1">
				  	<div class="comment_body" id="movieView" data-target="#layerpop-commentView" data-toggle="modal">
			            <div class="box1_top comment_main_top">
					    <i class="fas fa-user-circle fa-4x" id=user_icon1></i>
			            <div class="box1_name">${commentDto.user_nickname }</div>
			            <div class="box1_star_box">★ ${commentDto.comment_score == 0.0 ? 0 : commentDto.comment_score}</div>
					    </div>
					    <div class="box1_middle comment_main_mid">
					    	<textarea class="commentContents" readonly>${commentDto.comment_content }
					    	</textarea>
					    </div>
					  	<input type="hidden" name="userNo" value= "${commentDto.user_no}" >
						<input type="hidden" name="movieNo" value="${commentDto.movie_no}" >
						<input type="hidden" name="commentNo" value="${commentDto.comment_no}">
	   	 				<input type="hidden" name="userNickname" value="${commentDto.user_nickname}">
			        	<input type="hidden" name="commentContent" value="${commentDto.comment_content}">
		        	    <input type="hidden" name="date" value="${commentDto.comment_date}">
		        	    <input type="hidden" name="title" value="${commentDto.comments_title}">
        	   			 <input type="hidden" name="commentScore" value="${commentDto.comment_score}">
		        	    
				  	</div>
		            <div class="box1_bottom">
		              <p>좋아요</p>
		              <i class="far fa-thumbs-up fa-2x" id="finger1">${commentDto.comment_like }</i>
		            </div>
				  </div>
				</div>
	        </c:forEach>
        </c:if>
		
	</div>
	
	<!-- modal -->
	<style>
		.commentView .modal-dialog{
			width: 800px;
		}
		.modal-header {
   			 width: 40%;
   		}
   		.modal-footer {
		    width: 40%;
		}
		textarea#commentContents {
		    width: 50%;
		    height: 50%;
		}
	</style>
	 <div class="modal fade commentView" id="layerpop-commentView" >
	   <div class="modal-dialog">
	     <div class="modal-content">
	       <!-- header -->
	       <div class="modal-header">
	         <!-- 닫기(x) 버튼 -->
	         <button type="button" class="close btn btn-info" data-dismiss="modal">×</button>
	         <!-- header title -->
	         <h4 class="modal-title">코멘트</h4>
	       </div>
	       <!-- body -->
	       <div class="modal-body">
	           <jsp:include page="../myPage/myWriteViewPage.jsp">
					<jsp:param value="test" name="title" />
			   </jsp:include>
	       </div>
	       <!-- Footer -->
	       <div class="modal-footer">
	         <button type="button" id="close-btn" class="btn btn-info" data-dismiss="modal">닫기</button>
	       </div>
	     </div>
	   </div>
	 </div>
 
 <script src="/movie/assets/script/commentScrollEvent.js"> </script>
 <script src="/movie/assets/script/commentViewModal.js"></script>
 
 <script>
 	
 </script>
   
</body>
</html>