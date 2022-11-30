<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	request.setCharacterEncoding("UTF-8");

	//로그인이 되어 있지 않을 때 접근 불가
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("") || request.getParameter("memberId") == null || request.getParameter("memberId").equals("") || request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("") || request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")) {
		String msg = "모든 정보를 입력해주세요.";
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + request.getParameter("year") + "&month=" + request.getParameter("month") + "&date=" + request.getParameter("date"));
		return;
	}
	
	Cash insertCash = new Cash();
	insertCash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	insertCash.setMemberId(request.getParameter("memberId"));
	insertCash.setCashDate(request.getParameter("cashDate"));
	insertCash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	insertCash.setCashMemo(request.getParameter("cashMemo"));
	
	System.out.println(insertCash.getCategoryNo());
	
	CashDao cashDao = new CashDao();
	int insertCashList = cashDao.insertCashListByDate(insertCash);
	
	if(insertCashList == 0) {
		System.out.println("입력 실패");
		String msg = "입력 실패";
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + request.getParameter("year") + "&month=" + request.getParameter("month") + "&date=" + request.getParameter("date") + "&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	} else {
		System.out.println("입력 성공");
		String msg = "입력 성공";
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?year=" + request.getParameter("year") + "&month=" + request.getParameter("month") + "&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
%>