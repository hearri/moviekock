<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<jsp:include page="../template/header.jsp">
	<jsp:param value="문의하기" name="title" />
</jsp:include>
<link rel="stylesheet" href="/movie/assets/style/qnaPageCss/qnaWritePage.css" />
<body>
	<div class="wrap">
		<div class="main_wrap">
	        <div class="main_head">
		        <a href="qnaListView.do" class="qna_txt">FAQ</a>
	        </div>  
	        <div class="main_body">
	            <form action="qnaWrite.do" method="post">
	            <div class="box1">
	                <div class="box2">
	                	<div class="box2_left">
					       <label for="select" class="left">유형</label><select name="qna_select" id="select" class="select">
	                            <option value="컨텐츠문제" selected>컨텐츠문제</option>
	                            <option value="정보요청">정보요청</option>
	                            <option value="버그문제">버그문제</option>
	                            <option value="건의사항">건의사항</option>
	                            <option value="기타문의">기타문의</option>
						    </select><br/>
	                  		<label for="title" class="left">제목</label><input type="text" name="qna_title" id="title" class="title"/>
	                	</div>
	                  	<div class="box2_right">
	                        <input type="checkbox" name="qna_secret" value="1" id="secret" />
	                        <label for="secret" id="secret_btn">비공개</label><br/>
	                       <input type="password" name="qna_pw" id="pw" class="display-none" placeholder="게시물 비밀번호를 입력하세요." />
	                  	</div>	
				   </div>
                    <div class="box3">
                        <textarea rows="100" cols="100" name="qna_content" class="content" id="content" placeholder="문의 내용을 입력하세요."></textarea>                     
                    </div> 
                    <div class="box5">
                        <button type="button" class="send_btn" onclick="fn_sendClick(this.form)">저장</button>
                    </div>
                </div>
				</form>
            </div>
           </div>
       </div>
    
    <script src="/movie/assets/script/qnaWritePage.js"></script>
 
 	
    
<%@ include file="../template/footer.jsp" %>
	