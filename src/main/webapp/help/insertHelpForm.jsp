<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertHelpForm</title>
</head>
<body>
	<h1>문의사항 작성</h1>
	<div>
		<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
			<table>
				<tr>
					<th>문의사항 작성</th>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="helpMemo"></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="memberId" value=<%=loginMember.getMemberId()%>">
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/help/helpList.jsp">뒤로</a>
			<button type="submit">문의하기</button>
		</div>
	</div>
</body>
</html>