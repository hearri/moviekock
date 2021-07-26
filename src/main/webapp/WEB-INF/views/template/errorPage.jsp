<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="인덱스" name="title" />
</jsp:include>
	
<style>
	.err_wrap{
		width: 100%;
		text-align: center;
		padding: 6.055% 0px;
	}
	
	.err_main{
		width: 40%;
		margin: auto;
		padding: 30px;
		border: 2px solid #ddd;
	}
	
	.err_main i{
		font-size: 207.7px;
	}
	.mainTopFont{
		font-size: 30px;
	}
	
	.mainMidFont {
		font-size: 26px;
	}
</style>
	
	<div class="err_wrap">
		<div class="err_main">
			<i class="fas fa-bug"></i>
			<div class="mainTopFont">
				<span>이런! 버그를 발견하고 서버가 놀라서 뻗었습니다.</span><br/>
			</div>
			<div class="mainMidFont">
				<span>괜찮아요 잠시 기절했을뿐이에요.</span><br/>
				<span>문의 사항은 'moviekock@gmail.com' 혹은<br/> 홈페이지에 '문의하기'로 문의 주시면 감사하겠습니다.</span>
			</div>
			
		</div>
	</div>
	
<%@ include file="footer.jsp" %>