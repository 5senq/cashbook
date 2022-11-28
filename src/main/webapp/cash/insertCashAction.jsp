<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	request.setCharacterEncoding("UTF-8");

	String memberId = request.getParameter("memberId");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// M
	Cash cash = new Cash();
	cash.setMemberId(memberId);
	cash.setCategoryNo(categoryNo);
	cash.setCashDate(cashDate);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	
	CashDao cashDao = new CashDao();
	int insertCash = cashDao.insertCash(cash);
	
	if(insertCash == 1) {
		String msg = URLEncoder.encode("입력 성공","utf-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "&msg" + msg);
	}
%>