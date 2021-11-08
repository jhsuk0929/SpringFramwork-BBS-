<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>글 작성하기</title>
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
div.container{
	position: static;
	height: 750px;
	border: 3px solid #000000;
	text-align: left;
	background-color: gray;
}
button, select {
  width: 100%;
  padding: 12px 20px;
  margin: 80px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  text-align: left;
}
input[type=text], select {
   width: 1120px;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  text-align: left;
}
h1{
	text-align:center;
}
table{
	text-align:left;
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
	
	<!-- 글 쓰기 양식 -->
	<div class = "container">
	<form action="/bbs/write/new" method="Post" enctype="multipart/form-data">
		<table>
			<thead>
				<tr><td><h1>글 작성양식</h1></td></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<label for="bbsTitle">글 제목<br>
						<input type="text" id="bbsTitle" name="bbsTitle" required>
						</label>
					</td>
				</tr>
				<tr>
					<td>	
						<label for="userID">작성자<br>
						<input type="text" placeholder=<%=Session%> value=<%=Session%> id="userID" name="userID"  readonly></input>
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="bbsContent">본문 내용<br><br>
							<textarea name="bbsContent" id="bbsContent"  rows="10" cols="138" required></textarea>
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<label for="mediaFile">파일 첨부<br><br>
							<input type="file" name="mediaFile1" id="mediaFile1" ></input>
							<input type="file" name="mediaFile2" id="mediaFile2" ></input>
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<Button  id="submit" name = "submit" onclick="Submit()"></Button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>


	<script type="text/javascript">
		var a = document.getElementById("submit");
		a.innerText = "글 등록";
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>