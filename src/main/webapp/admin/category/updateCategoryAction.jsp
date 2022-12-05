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
	
	if(request.getParameter("categorNo") == null || request.getParameter("categoryNo").equals("") || request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
		return;
	}
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	category.setCategoryName(request.getParameter("categoryName"));
	
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.updateCategory(category);
	
	if(row == 0) {
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath() + "/admin/category/updateCategoryForm.jsp?categoryNo=" + category.getCategoryNo());
		return;
	} else {
		System.out.println("수정 성공");
	}
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
%>