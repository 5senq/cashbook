<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 세션
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?&msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	// 로그인 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	if(request.getParameter("year") == null || request.getParameter("year").equals("") || request.getParameter("month") == null || request.getParameter("month").equals("") || request.getParameter("date") == null || request.getParameter("date").equals("")) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	// M
	CashDao cashDao = new CashDao();
	Cash cashData = cashDao.selectUpdateCashData(cashNo);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	NumberFormat numberFormat = NumberFormat.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
</head>
<body>
	<h1>내역 수정</h1>
	<div>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
			<table>
				<tr>
					<th>분류</th>
					<td>
						<select name="categoryNo">
							<%
								for(Category c : categoryList) {
							%>
									<option value="<%=c.getCategoryNo()%>">
										<%=c.getCategoryKind()%>/<%=c.getCategoryName()%>
									</option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>날짜</th>
					
						<%
							if(date < 10) {
						%>
								<td>
									<input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-0<%=date%>" readonly="readonly">
								</td>
						<%
							} else {
						%>
								<td>
									<input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly">
								</td>
						<%
							}
						%>
				</tr>
				<tr>
					<th>메모</th>
					<td>
						<textarea name="cashMemo"><%=cashData.getCashMemo()%></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div>
		<input type="hidden" name="cashNo" value="<%=cashData.getCashNo()%>">
	</div>
	<div>
		<button type="submit">수정</button>
	</div>
</body>
</html>