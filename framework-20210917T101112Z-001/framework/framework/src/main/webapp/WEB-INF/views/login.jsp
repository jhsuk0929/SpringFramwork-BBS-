<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
div.container{
	padding: auto;
	border: 3px solid #000000;
	width:500px;
	background-color: gray;
}
button{
	text-align:center;
	width: 450px;
}
input, select {
  width: 450px;
  padding: 12px 20px;
  margin: 8px 15px;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
h1{
	text-align:center;
}

</style>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
<title>Log-in</title>
</head>
<body>

	<!-- header 부분 -->
	<jsp:include page="/WEB-INF/views/inc/header.jsp"/>
	
	<div class="container">
		<form action="/bbs/login" method="Post">
		<table>
				<thead>
					<tr>
						<td>
							<h1>로그인</h1>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
						<label>아이디: 
							<input type="text" id="userID" name="userID" required>
						</label>
						</td>
					</tr>
					<tr>
						<td>
						<label>비밀번호: 
							<input type="password" id="userPassword" name="userPassword" required>
						</label>
						</td>
					</tr>
					<tr>
						<td>
							<button>로그인</button>
						</td>
					</tr>
				</tbody>
		</table>
		</form>
	</div>
	<input type="hidden" id = "fail" value=<%=request.getAttribute("fail")%>>
</body>
<script type="text/javascript">
if (document.getElementById("fail").value.toString() == "x"){
	alert("아이디 또는 비밀번호가 일치하지 않습니다.");
}

</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>