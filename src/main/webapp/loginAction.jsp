<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	// Controller
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}

	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
		String msg = "로그인 정보를 입력해주세요.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	// M
	MemberDao memberDao = new MemberDao();
	Member loginMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp?&msg=";
	String msg = "로그인 실패";
	
	if(loginMember != null) {
		session.setAttribute("loginMember", loginMember);
		redirectUrl = "/cash/cashList.jsp?&msg=";
		msg = "로그인 성공";
	}
	
	response.sendRedirect(request.getContextPath() + redirectUrl + URLEncoder.encode(msg, "UTF-8"));
%>