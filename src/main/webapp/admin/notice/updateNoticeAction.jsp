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
	
	// 수정할 공지사항 번호와 내용이 없으면 list 페이지로 이동
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("") || request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.updateNotice(notice);
	
	// 작동 실패시 수정 폼으로 이동
	if(row == 0) {
		response.sendRedirect(request.getContextPath() + "/admin/notice/updateNoticeForm.jsp");
		return;
	}
	
	response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp");
%>