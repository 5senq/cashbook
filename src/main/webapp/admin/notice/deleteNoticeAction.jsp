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
	
	// 삭제할 공지사항 번호가 없을시 list 페이지로 이동
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	
	Notice notice = noticeDao.selectNoticeByNo(noticeNo);
	
	int deleteNoticeCheck = noticeDao.deleteNotice(notice);
	
	// 작동시 성공, 실패 상관없이 공지사항 list 페이지로 이동
	if(deleteNoticeCheck == 0) {
		System.out.println("삭제 실패");
	} else {
		System.out.println("삭제 성공");
	}
	
	response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp");
%>