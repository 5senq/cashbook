<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	String memberId = request.getParameter("memberId");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// M 호출시 필요한 매개값
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	cash.setCashNo(cashNo);
	cash.setMemberId(memberId);
	
	// M
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCash(cash);
	
	if(row == 1) {
		String msg = URLEncoder.encode("수정완료","utf-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
		return;
	}
%>