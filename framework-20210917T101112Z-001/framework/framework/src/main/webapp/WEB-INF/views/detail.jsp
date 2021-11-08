<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.jihun.bbs.Dto.Reply" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>글 보기</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <!-- <link th:href="@{css/demo.css}" href="../static/css/demo.css" rel="stylesheet" /> -->
</head>
<style>
div.container{
	position: static;
	border: 3px solid #000000;
	text-align: left;
	background-color: gray;
}
div.replyPaging{
	text-align:center;
	width: 100%;
	margin: 8px 100px;
 	display: inline;
}
.btn, select {
  width: 45%;
  margin: 8px 0;
  display: inline;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  text-align: center;
}
.add, select{
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  text-align: center;
}
.replyButton, select{
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  text-align: center;
}
.replyFunction, select{
  width: 45%;
  display: inline;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  text-align: center;
}
input[type=text], select {
  width: 1126.5px;
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
h2{
	width: 1000px;
}
table{
	text-align:left;
	height:400px;
}
tr.spaceHere>td {
  padding-top: 2em;
}
tr.this>td{
	text-align: right;
}

</style>
<%
String Session = null;
if(request.getSession().getAttribute("userid") != null){
	Session = (String) request.getSession().getAttribute("userid");
}
System.out.println("Session: "+Session);

%>
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
	<input type="hidden" id="session" value=<%=Session %>>
	<%
	}
	%>
	<!-- 글 보기 양식 -->
	<div class="container">			
	<div>
		<form id = "form" method="post" enctype="multipart/form-data">
			<table>
				<thead>
					<tr>
						<td><h1>게시판 글 보기</h1></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><label for="bbsTitle">글 제목 <br> <input
								type="text" id="bbsTitle" name="bbsTitle" value="${bbsTitle}"
								placeholder="${bbsTitle}" required readonly>
						</label></td>
					</tr>
					<tr>
						<td><label for="userIDforBBS">작성자 <br> <input
								type="text" placeholder="${userID}" value="${userID}"
								id="userIDforBBS" name="userID" required readonly></input>
						</label></td>
					</tr><br><br>
					<tr><br><br>
						<td id = "edit"><label for="bbsContent">본문 내용<br>
							<br><h2>${bbsContent}</h2><br><textarea name="bbsContent" id="bbsContent" value="${bbsContent}" rows="10"
									cols="138" required readonly style="display: none;">수정 글을 입력하세요</textarea>
									<%
									if( request.getAttribute("files") != null && ! request.getAttribute("files").toString().isBlank()){
									String end = "";
									String files = (String) request.getAttribute("files");
									
									if (files.contains(",")){
									%>
									<c:forTokens var="file" items="${files}" delims=",">
									<c:choose>
									<c:when test="${fn:contains(file, 'jpg') or fn:contains(file, 'png')}">	
									<!--  <img id="image" src="${pageContext.request.contextPath}/resources/${file}" alt="${file}"height="250" width="300">-->
									<a  id="image" href="${pageContext.request.contextPath}/resources/${file}" style= "color: red">이미지 미리보기 - ${file}</a>
									<br><a  id="imageLink" href="${pageContext.request.contextPath}/resources/${file}" style= "color: red" download="${file}">이미지 다운로드 - ${file}</a><br>
									</c:when>
									
									<c:when test="${! fn:contains (file, 'jpg') and ! fn:contains (file, 'png')}">
									<br><a id="textLink" href="${pageContext.request.contextPath}/resources/${file}" style= "color: red" download="${file}">첨부 파일 다운로드 - ${file}</a><br> 
									</c:when>
									</c:choose>
									</c:forTokens>										
									<%							
									}else{
										String [] minilist = files.split("\\.");
									 	System.out.println("1: " + minilist[0] +" 2 : "+minilist[1]);
										end = minilist[1];
										System.out.println("end: "+end);
									if (end.equalsIgnoreCase("jpg") || end.equalsIgnoreCase("png")){
									%>
									<!--<img id="image" src="${pageContext.request.contextPath}/resources/${files}" alt="${files}"height="250" width="300"> -->
									<a id="image" href="${pageContext.request.contextPath}/resources/${files}" style= "color: red">이미지 미리보기 - ${files}</a>
									<br><a id="imageLink" href="${pageContext.request.contextPath}/resources/${files}" style= "color: red" download="${files}">이미지 다운로드 -${files}</a>
									<%
										} else{
									%>
									<br><a id="textLink" href="${pageContext.request.contextPath}/resources/${files}" style= "color: red" download="${files}">첨부 파일 다운로드 - ${files}</a>
									<%
										}}}
									%>
						</label></td>
					</tr>
					<tr>
						<td id="fileeidt">
							<input type="hidden" id="bbsID" name="bbsID" value="${bbsID}">
							<%
							if (Session != null && Session.equalsIgnoreCase((String) request.getAttribute("userID"))){
							%>
							
							<button  type="button" class="btn" value="${bbsID}" id="updateButton" name="updateButton" onclick="update1(this)"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button  type="button" class="btn" value="${bbsID}" id="deleteButton" name="deleteButton" onclick="delete1(this)"></button>
							<button type="button" class = "btn" id = "like" name = "like" >좋아요 ^^ b (${likes})</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class = "btn" id = "dislike" name = "dislike">싫어요 -- q(${dislikes})</button>
						
							<%
							/*================= */
							}else if (Session != null && Session != (String) request.getAttribute("userID")){
							%>
							<button type="button" class = "btn" id = "like" name = "like" onclick = "status(this)">좋아요 ^^ b (${likes})</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class = "btn" id = "dislike" name = "dislike" onclick = "status(this)">싫어요 -- q(${dislikes})</button>
						<%
							}
						%>
						</td>
					</tr>
				</tbody>  <!--  -->
			</table>
		</form>
	</div>
	<br><br>
	<!-- 댓글 창 양식 -->
	<div>
		<table>
			<thead>
				<tr>
					<td>
						<h2>댓글란(${total})</h2>
					</td>
				</tr>
			</thead>
			<tbody>
				<%int index = 0; %>
				<c:forEach var ="reply" items="${replyList}">
				<tr class = "spaceHere">
					<td>
						<h2><span id="userIDforReply">${reply.userID}</span></h2>
						<input type="text" id="replyContent- + ${reply.replyID}" name="replyContent-" value="${reply.replyContent}" required readonly>           	 	
						<%
						ArrayList <Reply> comments = (ArrayList) request.getAttribute("replyList");
						String replyID2 = comments.get(index).getUserID();
						if (Session != null && Session.equalsIgnoreCase(replyID2)){
						%>
						<button type="button" class = "replyFunction"  id="replyUpdate" name="replyUpdate" onclick="settingModify(this)"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class = "replyFunction"  id="replyDelete" name="replyDelete" onclick="settingModify(this)"></button>
						<%
						}
						%>	
					</td>
				</tr>
				<% index = index + 1; %>
				</c:forEach>
				<tr class = "spaceHere">
					<td>
					<div>
						<form action="/bbs/detail/replywrite" method="Post">
						<label for="replyContent">덧글 쓰기 
							<input type="hidden" id="bbsIDforReply" name="bbsID" value="${bbsID}">
							<input  type="text" id="replyContent" name="replyContent" placeholder="댓글을 입력하세요" required>
						</label>
						<%
						if( Session == null || Session.isBlank() || Session.isEmpty()){
						%>
							<button class="add" name="add" id="add" disabled>댓글을 등록하려면 로그인이 필요합니다</button>
						<%
						} else{
						%>
							<button  class = "add" name="add" id="add" onclick="writecheck()">댓글 등록</button>
						<%
						}
						%>	
						</form>
					</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="replyPaging">
							<form action="detail" method="Get">
								<input type="hidden" id="replyPage" name="replyPage" value="${replyPage}">						
								<input type="hidden" id="bbsIDforReplyPage" name="bbsID" value="${bbsID}">
								<input type="hidden" id="totalPage" name="totalPage" value="${totalPage}">
								<button class="replyButton" id="previousReply" name="previousReply" onclick="previousPage()">◀</button>
								<c:forEach var = "button" items = "${buttons}">
								<button id="paging + ${button}" value="${button}" onclick="paging(this)">${button}</button>
								</c:forEach>
								<button class="replyButton" id="nextReply" name="nextReply" onclick="nextPage()">▶</button>
							</form>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</div>

	<c:choose>
	
	<c:when test="${param.cc ==  'update'}">
	<script type="text/javascript">
	alert("글이 수정 되었습니다.");
	</script>
	</c:when>
	
	<c:when test="${param.cc ==  'replyupdate'}">
	<script type="text/javascript">
	alert("댓글이 수정 되었습니다.");
	</script>
	</c:when>
	
	<c:when test="${param.cc ==  'replydelete'}">
	<script type="text/javascript">
	alert("댓글이 삭제 되었습니다.");
	</script>
	</c:when>
	
	<c:when test="${param.cc ==  'replywrite'}">
	<script type="text/javascript">
	alert("댓글이 등록 되었습니다.");
	</script>
	</c:when>
	
	</c:choose>
	
	<script type="text/javascript">
	
	//댓글 삭제 기능
	 function deleteReply(){
		document.getElementById("replyForm").setAttribute("action", "/bbs/detail/replydelete");
		document.getElementById("replyForm").setAttribute("method", "post")

		var check = confirm("정말로 삭제하시겠습니까?");
		if(check){
		document.getElementById("replyForm").submit();
		}
	}	
	//댓글 수정 기능
	function replyUpdate(){
		var updateContent1 = document.getElementById("those").parentElement.firstElementChild.nextElementSibling.value;
		console.log(updateContent1);
		updateContent.setAttribute("value", updateContent1);
		
		document.getElementById("replyForm").setAttribute("action", "/bbs/detail/replyupdate");
		document.getElementById("replyForm").setAttribute("method", "post")
		
		if(updateContent1 != null && updateContent1 != ""){
		document.getElementById("replyForm").submit();
		} else{
			alert("내용을 입력해 주세요");
		}
	} 
	//댓글 작성전 빈칸 체크
	 function writecheck(){
		// 댓글 란이 null이 아니고, 빈 칸이 아닐 시
		if(document.getElementById("replyContent").value != null && document.getElementById("replyContent").value != ""){
			submit();
		}else{
			alert("댓글을 입력하세요");			
		}
		
	}
	// 댓글 삭제 수정전
	function settingModify(button){
		//공통

		//var replyID = button.
		
		//update 혹은 delete 확인
		var id = button.id;
		var h = id.split("-");
		console.log( h[0]);
		
		var td = button.parentElement;
		console.log(td);
		var form = document.createElement("form");
		form.setAttribute("id","replyForm");
		
		td.appendChild(form);
		form.setAttribute("action", "replyUpdate");
		form.setAttribute("method", "post");
		
		var replyID = document.createElement("input");
		var replyPage = document.createElement("input");
		var bbsID = document.createElement("input");
		var updateContent = document.createElement("input");
		
		var tttt = td.firstElementChild.nextElementSibling.id
		var b =tttt.split("-");
		
		var replyID1 = b[1];
		var replyPage1 = document.getElementById("replyPage").getAttribute("value");
		var bbsID1 = document.getElementById("bbsID").getAttribute("value");

		replyID.setAttribute("value", replyID1);
		replyPage.setAttribute("value", replyPage1);
		bbsID.setAttribute("value", bbsID1);
	
		replyID.setAttribute("type", "hidden");
		replyPage.setAttribute("type", "hidden");
		bbsID.setAttribute("type", "hidden");
		updateContent.setAttribute("type", "hidden");
		
		replyID.setAttribute("name", "replyID");
		replyPage.setAttribute("name", "replyPage");
		bbsID.setAttribute("name", "bbsID");
		updateContent.setAttribute("name", "updateContent");
		updateContent.setAttribute("id", "updateContent");

		form.appendChild(replyID);
		form.appendChild(replyPage);
		form.appendChild(bbsID);
		form.appendChild(updateContent);
		
		
			//댓글 수정
		 if (h[0] == "update"){
		 button.setAttribute("id", "those");
		 button.nextElementSibling.setAttribute("id", "that")
		 button.innerText = "수정 댓글 등록";
		 button.nextElementSibling.innerText = "댓글 수정 취소";
		 var q = document.getElementById("that");
		 q.removeAttribute("onclick");
		 q.setAttribute("onclick","canceling()");
		 button.removeAttribute("onclick");
		 button.setAttribute("onclick","replyUpdate()");
		 
		 var content = button.parentElement.firstElementChild.nextElementSibling
		 content.readOnly = false;
		 content.required = true;
		 
		var list = document.getElementsByTagName("button");
		var length = list.length
		 console.log(list);
		 console.log(list.length);
			var check = 0;
			var plus = 1;
			
			
		 for( i = 0; i<length; i++){
			 console.log(i + list.item(check).id);
			 console.log("first: " + check);
			 	
			if(list.item(check).id != "those" && list.item(check).id != "that"){
				document.getElementById(list.item(check).parentElement.removeChild(list.item(check)));
			} else if (list.item(check).id == "those" || list.item(check).id == "that"){
					check = check + plus;
			}
			
			}
		
		 
		//댓글 삭제
		 	}else if(h[0] == "delete"){
				deleteReply();
		 }
	}

	//댓글, 게시글 수정 취소
	function canceling(){
		 var goback = confirm("수정을 취소하시겠습니까?");
		 if (goback){
			 location.reload();
		 }
	}
	
	
	// 게시글, 댓글 수정 삭제 inner text
	var update = document.getElementById("updateButton");
	if(update != null){
		update.innerText = "글 수정";
		}
	var fundel = document.getElementById("deleteButton");
	if(fundel != null){
		fundel.innerText = "글 삭제";
	}
	const replyDel = [];

	while(document.getElementById("replyDelete")){
		var a = document.getElementById("replyDelete");
		replyDel.push(a)
		a.setAttribute("id", "delete-Changed");
	}
	
	for (const element of replyDel){
		element.innerText = "댓글 삭제";
	}
	
	const replyUp = [];

	while(document.getElementById("replyUpdate")){
		var a = document.getElementById("replyUpdate");
		replyUp.push(a)
		a.setAttribute("id", "update-Changed");
	}
	
	for (const element of replyUp){
		element.innerText = "댓글 수정";
	}
	
	// 댓글 페이지 이동 (숫자 클릭시)
	function paging(button){
		var value = button.value;
		console.log(value);
		if(parseInt(value)<=parseInt(document.getElementById("totalPage").value)){
		document.getElementById("replyPage").setAttribute("value",value);
		submit();
		} else{
			alert("존재하지 않는 페이지입니다.")
		}
	}
	// 댓글 페이지 이동 (다음 버튼 클릭시)
	function nextPage(){
		if(parseInt(document.getElementById("replyPage").value)>=1 && parseInt(document.getElementById("replyPage").value)<parseInt(document.getElementById("totalPage").value)){
		document.getElementById("replyPage").setAttribute("value",parseInt(document.getElementById("replyPage").value) +1);
		console.log(document.getElementById("replyPage").value);
		submit();
		}else{
			alert("마지막 페이지 입니다.")
		}
		
	}
	// 댓글 페이지 이동 (이전 버튼 클릭시)
	function previousPage(){		
		if(parseInt(document.getElementById("replyPage").value)>1){
		document.getElementById("replyPage").setAttribute("value",parseInt(document.getElementById("replyPage").value) -1);
		console.log(document.getElementById("replyPage").value);
		submit();
		} else{
			alert("이전 페이지가 없습니다.")
		}
	}
		//게시글 수정
		function update1(){
			
			var list = document.getElementsByTagName("button");
			var length = list.length
			 console.log(list);
			 console.log(list.length);
				var check = 0;
				var plus = 1;
				
				//document 안의 모든 버튼 조회
			 for( i = 0; i<length; i++){
				 console.log(i + list.item(check).id);
				 console.log("first: " + check);
				 	
				if(list.item(check).id != "updateButton" && list.item(check).id != "deleteButton"){
					document.getElementById(list.item(check).parentElement.removeChild(list.item(check)));
				} else if (list.item(check).id == "updateButton" || list.item(check).id == "deleteButton"){
						check = check + plus;
				}
				
				}
			
			
			
			
			//readonly 설정
			var titleSection = document.getElementById("bbsTitle");
			titleSection.readOnly = false;
			var contentSection = document.getElementById("bbsContent");
			contentSection.readOnly = false;
			contentSection.style.display = 'inline';
			console.log("INLINE");
			
			
			//onclick 변경 (수정 글 등록)
			document.getElementById("updateButton").innerText = "수정 글 등록";
			document.getElementById("updateButton").removeAttribute("onclick");
			document.getElementById("updateButton").setAttribute("onclick","updateBbs()");
			
			document.getElementById("deleteButton").innerText = "글 수정 취소";
			document.getElementById("deleteButton").removeAttribute("onclick");
			document.getElementById("deleteButton").setAttribute("onclick","canceling()");
			
			var img = document.getElementById("image");
			var imglink = document.getElementById("imageLink");
			var textlink = document.getElementById ("textLink");
			console.log("IMG : " + img);
			console.log("IMGLINK : " + imglink);
			console.log("TEXTLINK : " + textlink);
		/* 	if (img == null && imglink == null && textlink == null){
				var file = document.createElement("input");  
				var filetwo = document.createElement("input");
				
				file.type = "file";
				filetwo.type = "file";
				
				file.name = "file";
				filetwo.name = "filetwo";
				
				file = document.getElementById("fileeidt").insertBefore(file,document.getElementById("updateButton"));
				filetwo = document.getElementById("fileeidt").insertBefore(filetwo,document.getElementById("updateButton"));
			}else {
				if(document.getElementById("image") != null){
				var par = img.parentNode;
				} else {
					var par = textlink.parentNode;
				} */
			/* 	par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				par.removeChild(par.firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling);
				 */
				 
			
			/* 	if (img !=null){
					par.remove(img);
				} 
				if (imglink != null){
					par.remove(imglink);
				}
				if (textlink !=null){
					par.remove(textlink);
				} */
				var file = document.createElement("input");
				var filetwo = document.createElement("input");
				var ff = document.createElement("input");
				var label = document.createElement("label");
				var ffff = document.createElement("input");
				var label2 = document.createElement("label");

				file.type = "file";
				filetwo.type = "file";
				ff.type = "checkbox";
				ffff.type = "checkbox";

				file.name = "file";
				filetwo.name = "filetwo";
				ff.name = "checkbox";
				label.name = "label";
				ffff.name = "checkbox2";
				label2.name = "label2";
				
				file.id = "file";
				filetwo.id = "filetwo";
				ff.id = "checkbox";
				label.id = "label";
				var br = document.createElement("br");				
				ffff.id = "checkbox2";
				label.id = "label2";
				
				file = document.getElementById("fileeidt").insertBefore(file,document.getElementById("updateButton"));
				filetwo = document.getElementById("fileeidt").insertBefore(filetwo,document.getElementById("updateButton"));
				ff = document.getElementById("fileeidt").insertBefore(ff,document.getElementById("updateButton"));
				label = document.getElementById("fileeidt").insertBefore(label,document.getElementById("updateButton"));
				br = document.getElementById("fileeidt").insertBefore(br,document.getElementById("updateButton"));
				label.innerHTML = "글 작성 시 업로드된 파일 사용" ;
				label.htmlFor = "checkbox"; 
				
				ffff = document.getElementById("fileeidt").insertBefore(ffff,document.getElementById("updateButton"));
				label2 = document.getElementById("fileeidt").insertBefore(label2,document.getElementById("updateButton"));
				br = document.getElementById("fileeidt").insertBefore(br,document.getElementById("updateButton"));
				label2.innerHTML = "첨부파일 모두 삭제" ;
				label2.htmlFor = "checkbox2"; 
				
				
		
		
		
		}
		//게시글 수정 2
		function updateBbs(){
			var content = document.getElementById("bbsContent").value.length;
			var title = document.getElementById("bbsTitle").value.length;
			
			
				var ff = document.getElementById("checkbox");
				var ffff = document.getElementById("checkbox2");

				if(ff.checked === true){
					ff.value = "o";
				}else if (ffff.checked === true ){
						ffff.value = "o";
				} 
			if(content >0 && title>0){
				var form = document.getElementById("form");
				form.action = "/bbs/detail/boardupdate";
				form.method = "POST";
				form.enctype = "multipart/form-data";
				

				form.submit();
				
				}else{
					
					
				alert("내용을 입력하세요.");
				}
			 
			}
		//게시글 삭제
		function delete1(button){
			var form = document.getElementById("form");
			form.action = "/bbs/detail/boarddelete";
			form.method = "POST";
			var delcheck = confirm("정말로 삭제하겠습니까?");
			if(delcheck){
				form.submit();
			} 
		}
		/*==============================*/
		//좋아요 기능
		function status(button){
			var bbsID = document.getElementById("bbsID").value;
			var userID = document.getElementById("session").value;
			var status = button.id;
			console.log("bbsID: "+bbsID);
			console.log("userID: "+userID);
			console.log("status: "+status);
		location.href = "/bbs/detail/status?bbsID="+bbsID+"&userID="+userID+"&status="+status;
		}
		
		
	</script>







	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>