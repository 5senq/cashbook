<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인이 되어 있지 않을 때 접근 불가
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

	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberPwForm</title>
</head>
<body>
	<h1>비밀번호 수정</h1>
	<div>
		<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>현재 비밀번호</th>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
				<tr>
					<th>새로운 비밀번호</th>
					<td>
						<input type="password" name="changePw">
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" name="changePwCk">
					</td>
				</tr>
			</table>
			<button type="submit">비밀번호 수정</button>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/loginForm.jsp">뒤로</a>
	</div>
</body>
</html>