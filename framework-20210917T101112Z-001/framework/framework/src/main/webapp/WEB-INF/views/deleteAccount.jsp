<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>메인 게시판</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <!-- <link th:href="@{css/demo.css}" href="../static/css/demo.css" rel="stylesheet" /> -->
</head>
<%
String Session = null;
if (Session == null && request.getSession().getAttribute("userid") != null){
	Session = (String) request.getSession().getAttribute("userid");
}
%>
<style>
div.sidemenu{
	background-color: none;
	position: fixed;
	left:16cm;
	top:3cm;
	botton: 0;
	height: 100%;
	width: 20cm;
	
}
a.list{
	color: aqua;
	background-color: menu;
	font-size: xx-large;
}
table{
	text-align: left;
}
button{
	width: 100%;
}

</style>
<body>

	<!-- header 부분 -->
	<%
	if (Session == null){
	%>
	<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
	<%
	} else if (Session != null){
	%>
	<jsp:include page="/WEB-INF/views/inc/sessionheader.jsp"/>
	<%
	}
	%>
	<!-- 회원 관리 목록 -->
	<div class = "sidemenu" id="menu">
	<h1> 본인 확인을 위해서 아래의 정보를 입력해주세요 </h1>
	<br>
		<form action="/bbs/deleteAccount" method="post" id="form">
			<table>
				<tr>
					<td>
						<label>아이디:
							<input type="text" id="userID" name="userID">
							<input type="hidden" value = "${userID}" id = "currentID"> 
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<label>비밀번호:
							<input type="password" id="userPassword" name="userPassword">
							<input type="hidden" value = "${userPassword}" id = "currentPassword"> 
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<label>가입시 사용된 이메일:
							<input type="email" id="userEmail" name="userEmail">
							<input type="hidden" value = "${userEmail}" id = "currentEmail"> 
						</label>
					</td>
				</tr>
				<tr>
					<td>	
						<button type="button" onclick="checkanddelete()">회원 탈퇴하기</button>
					</td>
				</tr>
			</table>
		</form>
		
		<br>
		<a href="/bbs/account">이전으로</a> 
		</div>
	

	<input type = "hidden" value = "${how}" id ="x">
	
	<script type="text/javascript">
	if(document.getElementById("x").value === "how"){
		alert('잘못된 접근입니다');
		location.href = "/bbs/"
	}
	function checkanddelete(){
		var userID = document.getElementById("userID").value;
		var currentID = document.getElementById("currentID").value;
		var userPassword = document.getElementById("userPassword").value;
		var currentPassword = document.getElementById("currentPassword").value;
		var userEmail = document.getElementById("userEmail").value;
		var currentEmail = document.getElementById("currentEmail").value;
		
		if(userID === currentID && currentPassword === userPassword && userEmail === currentEmail){
			var con = confirm('계정을 삭제하시겠습니다?');
			if (con){
				document.getElementById("form").submit();
			}
		} else {
			alert('본인인증에 실패하였습니다.');
		}
	}
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>