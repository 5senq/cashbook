<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
		
		String msg = URLEncoder.encode("모든 정보를 입력해주세요","utf-8");
		
		String targetUrl = "/member/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl + "?msg=" + msg);
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
	
	loginMember.setMemberPw(request.getParameter("memberPw"));
	
	MemberDao memberDao = new MemberDao();
	
	if(memberDao.deleteMember(loginMember)) {
		System.out.println("회원탈퇴 완료");
		
		String targetUrl = "/logout.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl);
	} else {
		System.out.println("회원탈퇴 실패");
		
		String msg = URLEncoder.encode("비밀번호를 다시 한번 확인해주세요.","utf-8");
		
		// msg를 가지고 다시 deleteMemberForm.jsp로 이동
		String targetUrl = "member/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl + "?msg=" + msg);
	}
%>