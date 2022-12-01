<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	if(request.getParameter("year") == null || request.getParameter("year").equals("") || request.getParameter("month") == null || request.getParameter("month").equals("") || request.getParameter("date") == null || request.getParameter("date").equals("")) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCashListByDate(cashNo);
	String deleteMsg = null;
	
	if(row == 1) {
		deleteMsg = "삭제 완료";
	} else {
		deleteMsg = "삭제 실패";
	}
	
	response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
%>