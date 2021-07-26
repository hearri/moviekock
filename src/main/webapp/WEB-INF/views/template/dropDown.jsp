<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<!-- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" /> -->
<style>
*{
	outline: none;
}

.ddBody{
	margin-top: 5px;
    padding: 10px;
    text-align: center;
    display: block;
}
.dropdown{
     position: relative;
     display: inline-block;
     display: flex;
}
 .button{
 /* 	height: 20px; */
    padding: 0px;
    color: white;
	margin-top: 0px;
	border: none;
 }
 
 	#circle{
	 	background-color: white;
	 	margin: auto;
	 	border: none;
	 	height: 40px;
 	}
 	
 	#logOut{
 		position: relative;
 		top : -60px;
 		border-top: 1px solid  #ddd;
 		padding-top: 15px;
 		height: 30px;
 		
 	}
 	
 	#myPage{
 		position: relative;
 		top : -20px;
 	}
/*  .button:action, */
/*  .button:focus, */
/*  .button:hover */
.dropDown:action,
.dropDown:focus,
.dropDown:hover {
 	outline: none;
 	border: none;
 }
 
.dropDown-menu{
	position: absolute;
	min-width: 90px;
	height : 90px;
	margin-top: 18px;
	text-align: center;
	border-radius: 5px;
	top: 100%;
	float: left;
	background-color: white;
	border: 1px solid  #ddd ;
}

.dropDown-menu input{
    font-size: 12px;
    color: black;
    border: none;
    outline: none;
    background-color: #fff;
    height: 15px;
    line-height: 15px;
}

.top_user_circle {
	color: #646ECB;
	background-color: white;
	height: 30px;
}

</style>
	<div class="ddBody">
	    <div class="dropdown">
	        <button onclick="dp_menu()" id="circle"><i class="fas fa-user-circle fa-3x top_user_circle"></i></button>
	        <div style="display: none;" id="drop-content" class="dropDown-menu dropdown-menu-right" >
	            <input type="button" id="myPage" value="마이페이지" onclick="location.href='myPage.do'" />
	            <input type="button" id="logOut" value="로그아웃" onclick="location.href='logout.do'" />
	        </div>
	    </div>
    </div>
 
    <script>
        function dp_menu(){
            let click = document.getElementById("drop-content");
            if(click.style.display === "none"){
                click.style.display = "block";
 
            }else{
                click.style.display = "none";
 
            }
        }
    </script>
