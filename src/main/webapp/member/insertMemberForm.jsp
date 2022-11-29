<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
</head>
<body>
	<h1>회원가입</h1>
	<div>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>회원 아이디</td>
					<td>
						<input type="text" name="memberId" value="">
					</td>
				</tr>
				<tr>
					<td>회원 비밀번호</td>
					<td><input type="password" name="memberPw" value=""></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="memberName" value=""></td>
				</tr>
			</table>
			<button type ="submit">회원가입</button>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/loginForm.jsp">뒤로</a>
	</div>
</body>
</html>