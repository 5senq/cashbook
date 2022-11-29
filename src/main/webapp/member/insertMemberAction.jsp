<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("") || request.getParameter("memberName") == null || request.getParameter("memberName").equals("")) {
		String msg = "모든 정보를 입력해주세요.";
		response.sendRedirect(request.getContextPath() + "/member/insertMemberForm.jsp");
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberName(request.getParameter("memberName"));
	
	MemberDao memberDao = new MemberDao();
	
	int duplicateId = memberDao.selectDuplicateInsertMember(paramMember);
	if(duplicateId != 0) {
		System.out.println("중복되는 아이디입니다.");
		String msg = "중복되는 아이디입니다.";
		response.sendRedirect(request.getContextPath() + "/member/insertMemberForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	int row = memberDao.insertMember(paramMember);
	String msg = null;
	
	if(row == 0) {
		System.out.println("회원가입 실패");
		msg = "회원가입 실패";
	} else {
		System.out.println("회원가입 성공");
		msg = "회원가입 성공";
	}
	
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
%>