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
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	Help help = new Help();
	help.setMemberId(memberId);
	
	HelpDao helpDao = new HelpDao();
	
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(help);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpList</title>
</head>
<body>
	<h1>고객센터</h1>
	<div>
		<table>
			<tr>
				<th>문의하기</th>
			</tr>
			<tr>
				<th>번호</th>
				<th>문의내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답변일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tr>
			<%
				for(HashMap<String, Object> h : helpList) {
			%>
					<td><%=h.get("helpNo")%></td>
					<td><a href="<%=request.getContextPath()%>/help/helpListOne.jsp?helpNo=<%=h.get("helpNo")%>"><%=h.get("helpMemo")%></a></td>
					<td><%=h.get("memberId")%></td>
					<td><%=h.get("helpCreatedate")%></td>
					<td>
						<%
							if(h.get("commentCreatedate") == null) {
						%>
								답변 대기중
						<%
							} else {
						%>
								<%=h.get("commentCreatedate")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(h.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=h.get("helpNo")%>">수정</a>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(h.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=h.get("helpNo")%>">삭제</a>
						<%
							}
						%>
					</td>
					</tr>
					<tr>
			<%
				}
			%>
			</tr>
		</table>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a>
	</div>
</body>
</html>