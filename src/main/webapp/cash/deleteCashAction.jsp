<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	request.setCharacterEncoding("UTF-8");

	Member loginMemberId = (Member)session.getAttribute("loginMember");
	String memberId = loginMemberId.getMemberId();
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// M 호출시 매개값
	
	Cash cash = new Cash();
	cash.setCashNo(cashNo);
	cash.setMemberId(memberId);
	
	// M
	
	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCash(cash);
	if(row == 1) {
		String msg = URLEncoder.encode("삭제완료","utf-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
		return;
	}
%>