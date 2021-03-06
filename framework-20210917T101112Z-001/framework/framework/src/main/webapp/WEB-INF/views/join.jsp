<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
   	<title>회원가입</title>
    <!-- <link th:href="@{css/demo.css}" href="../static/css/demo.css" rel="stylesheet" /> -->
</head>
<style>
div.container{
	padding: auto;
	border: 3px solid #000000;
	width:500px;
	background-color: gray;
}
input[type=text], select {
  width: 450px;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type=password], select {
  width: 450px;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type=email], select {
  width: 450px;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type=radio]{
  margin: 8px 35px 8px 35px;
   padding: 12px 20px;
  text-align:center;
}

h2{
	text-align:center;
}
button{
	text-align:center;
	width: 100%;
}
label[for=male] {
    font-size: 20px;
    font-weight: bold;
}
label[for=female] {
    font-size: 20px;
    font-weight: bold;
}
</style>
<body>
	<!-- 공통 네비게이션 바 -->
	<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
	
	<!-- 회원가입 양식 -->
	<div class="container">
		<form action="/bbs/join" method="post" id="Joinform">
			<h2>회원가입 정보</h2>
			<label>이름:
				<input type="text" id="name" name="name" required>
			</label>	
			<br><br>
			<label>아이디:
				<input type="text" id="userid" name="userid" required>
			</label>
			<br><br>
			<label>비밀번호:
				<input type="password" id="userpassword" name="userpassword" required>
			</label> 
			<br><br>
			<label>이메일
				<input type="email" id="email" name="email" required>
			</label>
			<br><br>
			<label for="male">남자
				<input type="radio" checked id="male" name="gender" value="1">
			</label>
			<label for="female">여자
				<input type="radio" id="female" name="gender" value="2">
			</label>
			<br><br>
			<button class="btn btn-primary pull-right" id="reg" name="reg" onclick="Submit()"
				>회원가입</button>
		</form>
	</div>
	<br>
	<script type="text/javascript">
	var a = '${joinfail}';
	if (a === "no"){
		alert("회원가입 오류: 다시시도해");
	}
	
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
</body>
</html>