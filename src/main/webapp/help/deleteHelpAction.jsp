<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setMemberId(loginMember.getMemberId());
	
	HelpDao helpDao = new HelpDao();
	
	int row = helpDao.deleteHelp(help);
	
	if(row == 0) {
		String msg = "삭제 실패";
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath() + "/help/helpList.jsp");
%>