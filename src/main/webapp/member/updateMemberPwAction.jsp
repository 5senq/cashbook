<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	//C

	request.setCharacterEncoding("UTF-8");

	// updateMemberPwForm.jsp에서 받아온 값이 null 또는 "" 일 때
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberNewPw") == null || request.getParameter("memberNewPwCk") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberNewPw").equals("") ||	request.getParameter("memberNewPwCk").equals("")) {

		String msg = URLEncoder.encode("모든 정보를 입력해주세요.","utf-8");
		String targetUrl = "/updateMemberForm.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl + "?msg=" + msg);
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	Member updateMember = new Member();
	
	// updateMemberPwForm에서 받아온 값을 updateMember에 저장
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberPw(request.getParameter("memberPw"));
	
	// 새 비밀번호
	String newPw = request.getParameter("memberNewPw");
	String newPwCk = request.getParameter("memberNewPwCk");
	
	// M
	
	// 비밀번호 수정 전 newPw와 newPwCk가 일치하는지 확인
	if(memberDao.passwordCheck(newPw, newPwCk)) { // 일치 -> 비밀번호 수정
		updateMember = memberDao.updateMemberPw(updateMember, newPw);
		if(updateMember != null) { // 비밀번호 수정 성공시
			// 수정된 updateMember를 새로 세션에 넣기
			Member loginMember = memberDao.login(updateMember);
			session.setAttribute("loginMember", loginMember);
			
			String msg = URLEncoder.encode("비밀번호 수정 성공","utf-8");
			String targetUrl = "/cash/cashList.jsp";
			response.sendRedirect(request.getContextPath() + targetUrl + "?msg=" + msg);
			return;
		} else { // 비밀번호 수정 실패시
			String msg = URLEncoder.encode("입력하신 정보들을 다시 한번 확인해주세요.","utf-8");
			String targetUrl = "/member/updateMemberPwForm.jsp";
			response.sendRedirect(request.getContextPath() + targetUrl + "?msg=" + msg);
			return;
		}
	} else { // 불일치 -> updatePwForm.jsp로 이동
		String msg = URLEncoder.encode("새로 입력하신 두 비밀번호가 일치하지 않습니다","utf-8");
		String targetUrl = "/member/updateMemberPwForm.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl + "?msg=" + msg);
		return;
	}
%>