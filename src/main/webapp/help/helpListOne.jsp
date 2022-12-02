<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setMemberId(loginMember.getMemberId());
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpListOne(help);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListOne</title>
</head>
<body>
	<!-- header include -->
	<!-- 고객센터 문의 목록 -->
	<table>
		<tr>
			<th>문의내용</th>
		</tr>
		<tr>
			<th>번호</th>
			<th>내용</th>
			<th>수정일</th>
			<th>작성일</th>
		</tr>
		<tr>
			<%
				for(HashMap<String, Object> h : list) {
			%>
					<td><%=h.get("helpNo")%></td>
					<td><%=h.get("helpMemo")%></td>
					<td><%=h.get("helpUpdatedate")%></td>
					<td><%=h.get("helpCreatedate")%></td>
			<%
				}
			%>
		</tr>
	</table>
	<table>
		<tr>
			<th>관리자 답변</th>
		</tr>
		<tr>
			<th>번호</th>
			<th>내용</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<tr>
			<%
				for(HashMap<String, Object> h : list) {
					if(h.get("commentMemo") != null) {
			%>
						<td><%=h.get("commentNo")%></td>
						<td><%=h.get("commentMemo")%></td>
						<td><%=h.get("commentMemberId")%></td>
						<td><%=h.get("commentCreatedate")%></td>
			<%
					} else {
			%>
						<td>작성된 답변이 없습니다.</td>
			<%
					}
				}
			%>
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/help/helpList.jsp">뒤로</a>
	</div>
</body>
</html>