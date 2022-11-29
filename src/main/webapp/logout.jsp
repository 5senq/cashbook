<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	String msg = "로그아웃";
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
%>