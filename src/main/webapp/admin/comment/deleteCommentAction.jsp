<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");

	// 세션 정보가 없을시 로그인 페이지로 이동
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	// 관리자 레벨이 아닐시 가계부 페이지로 이동
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	// 수정하려는 코멘트를 모르므로 list 페이지로 이동
	if(request.getParameter("commnetNo") == null || request.getParameter("commentNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp");
		return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commnetNo"));
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	CommentDao commentDao = new CommentDao();
	
	int row = commentDao.deleteComment(comment);
	
	// 동작 실패시 문의사항 list 페이지로 이동
	if(row == 0) {
		String msg = "삭제 실패";
		response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp");
%>