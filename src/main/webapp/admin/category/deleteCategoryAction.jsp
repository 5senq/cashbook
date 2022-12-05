<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
			return;
		}
	}
	
	if(request.getParameter("categorNo") == null || request.getParameter("categoryNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.deleteCategory(categoryNo);
	
	if(row == 0) {
		System.out.println("삭제 실패");
	} else {
		System.out.println("삭제 성공");
	}
	
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
%>