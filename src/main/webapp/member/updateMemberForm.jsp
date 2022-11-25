<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C	

	request.setCharacterEncoding("UTF-8");	

	// session에 저장된 멤버(현재 로그인 사용자)를 Member타입에 저장 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// M
	
	MemberDao memberDao = new MemberDao();
	ArrayList<HashMap<String, Object>> updateMemberList = memberDao.selectMemberIdCk(loginMember.getMemberId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>