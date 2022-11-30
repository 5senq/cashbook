<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	
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
<title>deleteMemberForm</title>
</head>
<body>
	<h1>회원탈퇴</h1>
	<div>
		<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td>
						<input type="password" name="memberPwCk">
					</td>
				</tr>
			</table>
			<button type="submit">회원탈퇴</button>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/loginForm.jsp">뒤로</a>
	</div>
</body>
</html>