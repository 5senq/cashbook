<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 세션
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
	}
	
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("") || request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("") || request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCashListByDate(cashNo, categoryNo, cashDate, cashPrice, cashMemo);
	
	if(row == 1) {
		System.out.println("수정 성공");
	} else {
		System.out.println("수정 실패");
	}
	
	response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
%>