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

	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp">
		<table>
			<tr>
				<td>회원 아이디</td>
				<td>
					<input type="text" name="memberId" value="">
					<%
						if(msg !=null) {
					%>
							<span><%=msg%></span>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td>회원 비밀번호</td>
				<td><input type="password" name="memberPw" value=""></td>
			</tr>
			<tr>
				<td>회원 이름</td>
				<td><input type="text" name="memberName" value=""></td>
			</tr>
		</table>
		<button type ="submit">회원가입</button>
	</form>
</body>
</html>