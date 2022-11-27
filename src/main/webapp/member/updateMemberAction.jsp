<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	request.setCharacterEncoding("UTF-8");

	//session에 저장된 멤버(현재 로그인 사용자)를 Member타입에 저장 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	System.out.println("");
	System.out.println(loginMember + "<-- 아이디");
	System.out.println(memberPw + "<-- 비밀번호");
	System.out.println(memberName + "<-- 이름");
	
	// 입력값 체크
	if(memberPw == null || memberName == null || memberPw.equals("") || memberName.equals("")) {
		String msg = URLEncoder.encode("모든 정보를 입력해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg=" + msg);
		return;
	}
	
	Member updateMember = new Member();
	updateMember.setMemberId(memberId);
	updateMember.setMemberPw(memberPw);
	updateMember.setMemberName(memberName);
	
	// M
	
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.update(updateMember);
%>