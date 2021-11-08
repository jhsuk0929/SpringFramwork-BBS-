<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="navbar navbar-inverse" style="position: sticky; top:0;">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="/bbs/">BBS Using SpringBoot</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="/bbs/">홈 화면</a></li>
      <li><a href="/bbs/board">게시판</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/bbs/join"><em class="glyphicon glyphicon-user"></em>회원가입</a></li>
      <li><a href="/bbs/login"><em class="glyphicon glyphicon-log-in"></em>로그인</a></li>
    </ul>
  </div>
</nav>