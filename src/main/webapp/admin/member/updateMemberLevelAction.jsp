<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션 정보가 없을시 로그인 페이지로 이동
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	// 관리자 레벨이 아닐시 가계부 페이지로 이동
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
			return;
		}
	}
	
	// 수정하려는 멤버의 정보가 없을시 list 페이지로 이동
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("") || request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || request.getParameter("memberLevel") == null || request.getParameter("memberLevel").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp");
	}
	
	Member member = new Member();
	
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	MemberDao memberDao = new MemberDao();
	
	int row = memberDao.updateMemberLevel(member);
	
	// 작동 실패시 수정 폼으로, 성공시 list 페이지로 이동
	if(row == 0) {
		System.out.println("레벨 수정 실패");
		response.sendRedirect(request.getContextPath() + "/admin/member/updateMemberLevelForm.jsp?memberId=" + member.getMemberId());
	} else {
		System.out.println("레벨 수정 완료");
	}
	
	response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp");
	return;
%>