<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// Controller
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// Map 매개변수
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 연도, 월, 일 가져오기
	int year = 0;
	int month = 0;
	int date = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null || request.getParameter("date") == null || request.getParameter("year").equals("") || request.getParameter("month").equals("") || request.getParameter("date").equals("")) {
	System.out.println("dddd");
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
	}
	
	String title = year + "년" + month + "월" + date + "일";
	
	

	// Model 호출
	
	// category 정보를 list에 저장
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash 정보를 list에 저장
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month + 1, date);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashDateList</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table>
			<tr>
				<td>categoryNo</td>
				<td>cashDate</td>
				<td>categoryName</td>
				<td>cashPrice</td>
				<td>cashMemo</td>
			</tr>
			<tr>
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
				<td>cashDate</td>
				<td><input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly"></td>
				<td><input type="number" name="cashPrice" value=""></td>
				<td><textarea rows="3" cols="50" name="cashMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
	<!-- cash 목록 출력 -->
	<table border="1">
		<tr>
			<td>categoryKind</td>
			<td>categoryName</td>
			<td>cashPrice</td>
			<td>cashMemo</td>
			<td>수정</td><!-- /cash/deleteCash.jsp?cashNo= -->
			<td>삭제</td><!-- /cash/updateCashForm.jsp?cashNo= -->
		</tr>
		<tr>
			<%
				for(HashMap<String, Object> m : list) {
					
					if(m.get("categoryKind").equals("지출")) {
			%>
						<td style="color:blue;"><%=m.get("categoryKind")%></td>
			<%			
					} else {
			%>
						<td style="color:red;"><%=m.get("categoryName")%></td>
			<%			
					}
			%>
				
				
				<td><%=m.get("cashPrice")%></td>
				<td><%=m.get("cashMemo")%></td>
				<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=(Integer)m.get("cashNo")%>">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=(Integer)m.get("cashNo")%>">삭제</a></td>
		
			<%		
				}
			%>
		</tr>
	</table>
</body>
</html>