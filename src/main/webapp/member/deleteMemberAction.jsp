<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
//C
	request.setCharacterEncoding("UTF-8");

	//로그인이 되어 있지 않을 때 접근 불가
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}

	// deleteMemberForm.jsp에서 받아온 값이 null 또는 "" 일 때
	if(request.getParameter("memberPw") == null || request.getParameter("memberPwCk") == null ||
		request.getParameter("memberPw").equals("") || request.getParameter("memberPwCk").equals("")) {

		String msg = "모든 정보를 입력해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/deleteMemberForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	
	} else if(!request.getParameter("memberPw").equals(request.getParameter("memberPwCk"))) {
		String msg = "비밀번호를 다시 한번 확인해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/deleteMemberForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	String msg = null;
	
	String memberPw = request.getParameter("memberPw");
	String memberPwCk = request.getParameter("memberPwCk");
	
	Member paramMember = (Member)session.getAttribute("loginMember");
	paramMember.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	
	int deleteMember = memberDao.deleteMember(paramMember);
	if(deleteMember == 0) {
		System.out.println("회원탈퇴 실패");
		msg = "비밀번호를 다시 한번 확인해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/deleteMemberForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	} else {
		System.out.println("회원탈퇴 성공");
		msg = "회원탈퇴가 완료되었습니다.";
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
	
%>