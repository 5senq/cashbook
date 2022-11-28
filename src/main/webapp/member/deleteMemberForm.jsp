<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 로그인이 되어 있지 않을 때 접근 불가
	if(session.getAttribute("loginMember") == null) {
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath() + targetUrl);
		return;
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
						<input type="text" name="memberId" value="<%=loginMember.getMemberId()%>">
					</td>
				</tr>
				<tr>
					<td>
						<button type="submit">회원탈퇴</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>