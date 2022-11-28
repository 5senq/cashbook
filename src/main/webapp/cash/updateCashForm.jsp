<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C
	
	request.setCharacterEncoding("UTF-8");
	
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
	
	// 로그인 정보 불러오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCash(loginMember.getMemberId(), cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
</head>
<body>
	<h1>Cash 수정</h1>
	<div>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<input type="hidden" name="cashNo" value="<%=cashNo%>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			<table>
				<tr>
					<th>categoryNo</th>
					<th>cashPrice</th>
					<th>cashMemo</th>
				</tr>
				<tr>
					<td>
						<select name="categoryNo">
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
					<%
						// 기본키가 달린 식별번호를 입력값으로 받으면 그거에 관해서만 출력
						// session에 저장된 아이디로만 받으면 아이디가 동일한 행 모두 출력
						for(HashMap<String, Object> m : list) {
					%>
							<td>
								<input type="text" name="cashPrice" value="<%=m.get("cashPrice")%>">
							</td>
							<td>
								<textarea rows="3" cols="50" name="cashMemo"><%=m.get("cashMemo")%></textarea>
							</td>
					<%
						}
					%>
				</tr>
			</table>
		</form>
	</div>
	<div>
		<button type="submit">수정</button>
	</div>
</body>
</html>