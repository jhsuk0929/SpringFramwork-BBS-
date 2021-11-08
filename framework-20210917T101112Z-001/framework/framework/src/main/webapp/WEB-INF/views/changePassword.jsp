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
	<h1>  계정 정보</h1>
	<br>
		<form action="/bbs/editPassword" method="post" id="form">
			<table>
				<tr>
					<td>
						<label>사용 중인 비밀번호:
							<input type="password" id="current" name="current">
							<input type="hidden" value = "${now}" id = "now"> 
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<label>새로운 비밀번호:
							<input type="password" id="changed" name="changed">
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<label>새로운 비밀번호 확인:
							<input type="password" id="changed2" name="changed2">
						</label>
					</td>
				</tr>
				<tr>
					<td>	
						<button type="button" onclick="checkandchange()">비밀번호 변경하기</button>
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
	console.log("now : " + document.getElementById("now").value);
	function checkandchange(){
		var now = document.getElementById("now").value;
		var current = document.getElementById("current").value;
		var changed = document.getElementById("changed").value;
		var changed2 = document.getElementById("changed2").value;
		if(changed === changed2 && current === now && now != changed){
			var con = confirm('비밀번호를 변경하시겠습니까?');
			if (con){
				document.getElementById("form").submit();
			}
		} else {
			alert('비밀번호가 일치하지 않거나 현재 비밀번호가 옳바르지 않습니다');
		}
	}
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>