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

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	// 입력값 체크
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("") || request.getParameter("memberName") == null || request.getParameter("memberName").equals("")) {
		String msg = URLEncoder.encode("모든 정보를 입력해주세요.","utf-8"); // 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg=" + msg);
		return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberName(request.getParameter("memberName"));
	
	// 분리된 M 호출
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId)) {
		System.out.println("중복 아이디");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm");
		return;
	}
	int row = memberDao.insertMember(paramMember);
	System.out.println(row + " <-- insertMemberAction.jsp row");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>