<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	request.setCharacterEncoding("UTF-8");

	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}

	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || request.getParameter("memberName") == null || request.getParameter("memberName").equals("") || request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
		String msg = "모든 정보를 입력해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/updateMemberForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String sessionMemberId = loginMember.getMemberId();
	
	Member paramMember = new Member();
	paramMember.setMemberNo(loginMember.getMemberNo());
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberName(request.getParameter("memberName"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	MemberDao memberDao = new MemberDao();
	
	int duplicateMemberIdCheck = memberDao.selectDuplicateUpdateMember(paramMember, sessionMemberId);
	if(duplicateMemberIdCheck != 0) {
		String msg = "중복된 아이디입니다.";
		response.sendRedirect(request.getContextPath() + "/member/updateMemberForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	int updateMemberCheck = memberDao.updateMember(paramMember);
	String msg = null;
	if(updateMemberCheck == 0) {
		System.out.println("수정 실패");
		msg = "수정 실패";
		response.sendRedirect(request.getContextPath() + "/member/updateMemberForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	} else {
		System.out.println("수정 성공");
		session.setAttribute("loginMember", paramMember);
		msg = "수정 성공";
	}
	
	response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
%>