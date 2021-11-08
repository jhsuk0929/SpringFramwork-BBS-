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
	<h1>계정 관리 목록</h1>
	<br>
		<ul>
			<li><a class="list" href = "/bbs/accountInfo">계정 정보 보기</a></li>
			<li><a class="list" href = "/bbs/changePassword">비밀번호 변경</a></li>
			<li><a class="list" href = "/bbs/deleteAccount">회원 탈퇴</a></li>
		</ul>
	</div>
	<input type = "hidden" value = "${how}" id ="x">
	<input type = "hidden" value = "${result}" id ="cp">
	
	<script type="text/javascript">
	console.log(document.getElementById("x").value);
	if(document.getElementById("x").value === "how"){
		alert('잘못된 접근입니다');
		location.href = "/bbs/"
	}
	if(document.getElementById("cp").value ==="o"){
		alert("비밀번호가 변경되었습니다");
	}
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>