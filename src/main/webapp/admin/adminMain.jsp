<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// C
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}
	
	// M
	
	// 최근 공지 5개, 최근 멤버 5명
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<ul>
		<li><a href="">공지관리</a></li>
		<li><a href="">카테고리관리</a></li>
		<li><a href="">멤버관리</a></li> <!-- 목록, 레벨수정, 강제탈퇴 -->
	</ul>
</body>
</html>