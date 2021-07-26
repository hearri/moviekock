<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	if (title == null || title.isEmpty()) {
		title = "movieKock";
	}
	pageContext.setAttribute("title", title);
	%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title }</title>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/movie/assets/style/adminPage/header.css">
</head>
<body>
	<div class="header-wrap">
	
		<div class="usersBtn">
			<a href="adminPage.admin">회원 관리</a></div>
		<div class="moviesBtn">
			<a href="movies.admin">영화 관리</a></div>
		<div class="commentsBtn">
			<a href="comments.admin">코멘트 관리</a></div>
		<div class="qnaBtn">
			<a href="qna.admin">qna 관리</a></div>
	
	</div>
