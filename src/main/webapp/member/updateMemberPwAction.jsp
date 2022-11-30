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

	// updateMemberPwForm.jsp에서 받아온 값이 null 또는 "" 일 때
	if(request.getParameter("memberPw") == null || request.getParameter("changePw") == null || request.getParameter("changePwCk") == null ||
		request.getParameter("memberPw").equals("") || request.getParameter("changePw").equals("") || request.getParameter("changePwCk").equals("")) {

		String msg = "모든 정보를 입력해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/updateMemberPwForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	
	} else if(!request.getParameter("changePw").equals(request.getParameter("changePwCk"))) {
		String msg = "변경할 비밀번호를 다시 한번 확인해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/updateMemberPwForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	String msg = null;
	
	String memberPw = request.getParameter("memberPw");
	String changePw = request.getParameter("changePw");
	String changePwCk = request.getParameter("changePwCk");
	
	Member paramMember = (Member)session.getAttribute("loginMember");
	paramMember.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	
	int updateMemberPwCheck = memberDao.updateMemberPw(paramMember, changePw);
	if(updateMemberPwCheck == 0) {
		System.out.println("수정 실패");
		msg = "수정 실패(현재 비밀번호 불일치)";
		response.sendRedirect(request.getContextPath() + "/member/updateMemberPwForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	} else {
		System.out.println("수정 성공");
		msg = "수정 성공(다시 로그인 하십시오.)";
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
%>