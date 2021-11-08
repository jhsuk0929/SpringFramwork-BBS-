<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
	<title>Main</title>
</head>
<%
String Session = null;
if (Session == null && request.getSession().getAttribute("userid") != null){
	Session = (String) request.getSession().getAttribute("userid");
}

%>

<style>
h5{
	text-align:center;
}
a.quiz{
	font-size: xx-large;
	color: fuchsia;
	text-align: center;
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
	
	<!-- main 부분 -->
	<div class="container">
		<table>
			<thead>
				<tr>
					<td>
						<h1> spring frame work이용한 게시판 만들기</h1>
					</td>
				</tr>
			</thead>		
			<tbody>
				<tr>
					<td>
						<h3>이번 게시판 만들기에서는 JDBC TEMPLATE,MYBATIS을 이용하였습니다.</h3>
						<br><br><br>
						<%
						if(Session != null){
						%>
						
						<h1><%=Session%>님이 로그인 되었습니다!</h1>
						<%
						}
						%>
						
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br>
	<input type="hidden" id = "session" value=<%=Session%>>
	<input type="hidden" id = "delete" value="${delete}">
	
	<script type="text/javascript">
	if (document.getElementById("delete").value === "o"){
		alert("계정이 삭제되었습니다.");
	}
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
