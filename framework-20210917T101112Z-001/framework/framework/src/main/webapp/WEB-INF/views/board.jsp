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
#real{
	position: static;
	height: 350px;
	border: 3px solid #000000;
	text-align: center;
	background-color: gray;
}
div.buttonContainer{
	text-align: center;
	position: fixed;
	bottom: 250px;
	left: 160px;

}
div.functionContainer{
	text-align: center;
	position: fixed;
	bottom: 250px;
	right: 160px;
}
div.paging{
	text-align: center;
	position: fixed;
	bottom: 250px;
	right: 750px;
}
/* mouse over link */
a:hover {
  color: green;
}
a{
  color: black;
}
div.buttonContainer > a{
	color:white;
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
	
	<!-- 글 리스트 -->	
	<div class = "container" id = "real">
		<h3><strong>글 목록</strong></h3>
		<table class = "table">
			<thead>
				<tr>
					<td colspan = 1><h5><strong>글 번호</strong></h5></td>		
					<td colspan = 1><h5><strong>글 제목</strong></h5></td>
					<td colspan = 1><h5><strong>작성자</strong></h5></td>
					<td colspan = 1><h5><strong>조회수</strong></h5></td>
					<td colspan = 1><h5><strong>작성 시간</strong></h5></td>
					
				</tr>
			</thead>
			<tbody> 
				<%
				int index=0; 
				ArrayList<Integer> header = (ArrayList) request.getAttribute("header");		
				%>
				<c:forEach  var = "bbs" items="${list}">
				<tr>
				<td><%=header.get(index)%></td>
				<td><a href="/bbs/detail?bbsID=${bbs.bbsID}">${bbs.bbsTitle}</a></td>
				<td>${bbs.userID}</td>
				<td>${bbs.view}</td>
				<td><fmt:formatDate value="${bbs.bbsDate}"
				pattern="yyyy년 MM월 dd일 HH시 mm분" /></td>
				</tr> 
				<%
				index+=1;
				%>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="store">
	<!-- page 이동 -->
	<div  class="paging" >
		<form id="form" action="/bbs/board" method=GET>
		<input type="hidden" id="pageNumber" name="pageNumber" value=<%=request.getAttribute("pageNumber")%>>
		<input type="hidden" id="filterBy" name="filterBy" value=<%=request.getAttribute("filterBy")%>>
		<input type="hidden" id="sortType" name="sortType" value=<%=request.getAttribute("sortType")%>>
		<input type="hidden" id="searchWord" name="searchWord" value=<%=request.getAttribute("searchWord")%>>
		<input type="hidden" id="totalPage" name="totalPage" value=<%=request.getAttribute("totalPage")%>>
		<button  type = "button" name="previous" id="previous" onclick="previousPage()">◀</button>	
		<c:forEach var="button" items="${paging}">
		<button type = "button" value="${button}" onclick="paging(this)">${button}</button>
		</c:forEach>
		<button  type = "button" name="next" id="next" onclick="nextPage()">▶</button>	
		</form>
	</div>
	
	<!-- 글 작성 -->
	<div  class = "buttonContainer">
		<button id="write" type="button" value="${Session}" onclick="writecheck()" >글 쓰기</button>	
	</div>
	
	<!-- 검색 및 정렬 -->
	<div class = "functionContainer">
		<form action="/bbs/board" method="Post">
			<label for="sorts">정렬 및 검색:</label>
			<select name="sorts" id="sorts">
			  	<option value="bbsTitle,ASC">글 제목 - 오름차순</option>
			  	<option value="bbsTitle,DESC">글 제목 - 내림차순</option>
				<option value="userID,ASC">작성자 - 오름차순</option>
				<option value="userID,DESC">작성자 - 내림차순</option>
				<option value="bbsDate,ASC">작성시간 - 오래된 순</option>
				<option value="bbsDate,DESC">작성시간 - 최신 순</option>
			</select>		
			<input type="text" name="searchWord" id="searchWord" placeholder="검색어 입력">
			<input type="hidden" name="pageNumber" id="pageNumber" value="1">
			<button class = "btn btn-primary" name="submit" id="submit" onclick="Submit()">검색</button>
		</form>
	</div>
	</div>
	
	
	<!-- 글 검색(정렬),등록,삭제 후 alert -->
	
	<c:choose>
	<c:when  test="${nosuch != null}" >
	<script type="text/javascript">
	alert("글 목록(검색결과)이 없습니다!");
	location.href="/bbs/board";
	</script>
	</c:when>
	
	<c:when  test="${param.cc ==  'yes'}">
	<script type="text/javascript">
	alert("글 등록이 완료되었습니다.");
	</script>
	</c:when>
	
	<c:when  test="${param.cc ==  'delete'}">
	<script type="text/javascript">
	alert("글이 삭제 되었습니다.");
	</script>
	</c:when>
	</c:choose>
	
	<script type="text/javascript">
	//숫자버튼으로 페이지 이동
	function paging(button){
		var value = button.value;
		console.log(value);
		if(parseInt(value)<=parseInt(document.getElementById("totalPage").value)){
		document.getElementById("pageNumber").setAttribute("value",value);
		var a= document.getElementById("form")
		a.submit();
		} else{
			alert("존재하지 않는 페이지입니다.");
		}
	}
	
	//화살표 버튼다음 페이지 이동( 현재 페이지가 1 이거나 1 보다 클 때 & 현재 페이지가 총 페이지보다 작을 때)
	function nextPage(){
		if(parseInt(document.getElementById("pageNumber").value)>=1 && parseInt(document.getElementById("pageNumber").value)<parseInt(document.getElementById("totalPage").value)){
		document.getElementById("pageNumber").setAttribute("value",parseInt(document.getElementById("pageNumber").value) +1);
		console.log(document.getElementById("pageNumber").value);
		var a= document.getElementById("form")
		a.submit();
		}else{
			alert("다음 페이지가 없습니다.");
		}
	}
	//화살표 버튼 이전 페이지 이동( 현재 페이지가 일보다 크고 현재페이지가 전체페이지랑 같거나 작을 때)
	function previousPage(){		
		if(parseInt(document.getElementById("pageNumber").value)>1 && parseInt(document.getElementById("pageNumber").value)<=parseInt(document.getElementById("totalPage").value)){
		document.getElementById("pageNumber").setAttribute("value",parseInt(document.getElementById("pageNumber").value) -1);
		console.log(document.getElementById("pageNumber").value);
		var a= document.getElementById("form")
		a.submit();
		} else{
			alert("이전 페이지가 없습니다.");
		}
	}
	//글 쓰기 버튼 클릭시 로그인이 안 되어 있을 시
	function writecheck(){
	if(document.getElementById("write").value != ""){
		location.href="/bbs/write";	
	} else{
		alert("회원만 이용가능한 기능입니다")
	}	
	}
	
	</script>
	
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>