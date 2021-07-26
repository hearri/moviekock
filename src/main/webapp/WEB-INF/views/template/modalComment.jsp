  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
	.modal_open_btn{
		width: 130px;
		height: 30px;
	}
	
	.modal-dialog {
		width: 600px;
		height: 500px;
	}
	
	.modal-header {
		height: 50px;
	}
	
	.modal-body {
		padding: 0px;
		}
	

	.comment_contents, .comment_title {
		width: 598px;
		border: 0px;
		margin: 0px;
		font-size: 16px;
		padding: 0px 0px 0px 10px;
	}
	
	.comment_title {
		height: 50px;
		width: 598px;
		border-bottom: 1px solid #ddd;
	}
	
	.comment_contents {
		padding: 20px 10px 20px 10px; 
		height: 400px;
		resize: none;
	}
	
	.comment_contents:focus, .comment_title:focus {
		outline: none;
	}
	
	.modal-footer {
		width: 598px;
	}
	
	.btn-default {
		margin: auto;
	}
	
	.in_modal_btn {
		width: 50px;
		height: 30px;
		color: white;
	}
	
</style>
</head>
<body>
<button class="wish-comments" id="modalBox" data-target="#layerpop" data-toggle="modal">+ 코멘트 작성하기</button><br/> 
	<div class="modal fade" id="layerpop" >
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <!-- header -->
	      <div class="modal-header">
	        <!-- 닫기(x) 버튼 -->
	        <button type="button" class="close btn btn-info" data-dismiss="modal">×</button>
	        <!-- header title -->
	        <h4 class="modal-title">${movieDto.movie_title.replaceAll("_"," ")}</h4>
	      </div>
	      <!-- body -->
	      <div class="modal-body">
	      	<form action="commentSubmit.do" method="post" id="commentForm">
	      		<input type="text" id="commentTitle" class="comment_title" name="commentTitle" placeholder="제목을 1~15글자 사이로 입력해주세요." />
	      		<textarea class="comment_contents" id="commentContents"  name="commentContents" placeholder="내용을 입력해주세요." ></textarea>
	      		<input type="hidden" class="commentMovieNo" name="commentMovieNo" value="${movieDto.movie_no}"/>
	      	</form>
	      </div>
	      <!-- Footer -->
	      <div class="modal-footer">
	        <button class="inp_btn in_modal_btn" data-dismiss="modal">완료</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>