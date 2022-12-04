<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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
	
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelp(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateHelpForm</title>
</head>
<body>
	<h1>문의사항 수정</h1>
	<div>
		<table>
			<tr>
				<th>기존 문의내역</th>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=help.getHelpMemo()%></td>
			</tr>
		</table>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
			<table>
				<tr>
					<th>수정사항</th>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="helpMemo" placeholder="수정할 내용을 작성해주세요."></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="helpNo" value="<%=help.getHelpNo()%>">
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/help/helpList.jsp">뒤로</a>
		<button type="submit">수정</button>
	</div>
</body>
</html>