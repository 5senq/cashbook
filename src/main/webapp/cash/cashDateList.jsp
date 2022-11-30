<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// Controller
	
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"')</script>");
		msg = null;
	}
	
	// Map 매개변수
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 연도, 월, 일 가져오기
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	if(request.getParameter("year") == null || request.getParameter("year").equals("") || request.getParameter("month") == null || request.getParameter("month").equals("") || request.getParameter("date") == null || request.getParameter("date").equals("")) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	// Model 호출
	
	// cash 정보를 list에 저장
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(memberId, year, month + 1, date);
	int cashNo = 0;
	
	// category 정보를 list에 저장
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	long resultPrice = 0;
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashDateList</title>
</head>
<body>
	<div>
		<h1>수입 지출 내역</h1>
		<span><%=year%>년 <%=month+1%>월 <%=date%>일</span>
	</div>
	<div>
		<table>
			<tr>
				<th>수입/지출</th>
				<th>내역</th>
				<th>금액</th>
				<th>상세내역</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tr>
				<%
					for(HashMap<String, Object> m : list) {
						if(m.get("categoryKind").equals("지출")) {
							resultPrice = resultPrice - ((Long)(m.get("cashPrice")));
						} else {
							resultPrice = resultPrice + ((Long)(m.get("cashPrice")));
						}
						int a = (Integer)m.get("cashNo");
				%>
						<td><%=(String)(m.get("categoryKind"))%></td>
						<td><%=(String)(m.get("categoryName"))%></td>
						<td>\<%=(Long)(m.get("cashPrice"))%></td>
						<td><%=(String)(m.get("cashMemo"))%></td>
						<td>
							<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=(Integer)(m.get("cashNo"))%>">삭제</a>
						</td>
			</tr>
			<tr>
				<%
					}
				%>
			</tr>
			<tr>
				<td>총 지출 :</td>
				<td>\<%=resultPrice%></td>
			</tr>
		</table>

		<!-- cash 입력 폼 -->
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			<table>
				<tr>
					<td>수입/지출</td>
					<td>	
						<select name = "categoryNo">
							<%
								for(Category c : categoryList) {
							%>
									<option value="<%=c.getCategoryNo()%>">
										<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
									</option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>cashDate</td>
					<%
						if(date < 10) {
					%>
							<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
					<%
						} else {
					%>
							<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td><input type="text" name="cashPrice" value=""></td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td><textarea rows="3" cols="50" name="cashMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">입력</button>
		</form>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month%>">뒤로</a>
	</div>
</body>
</html>