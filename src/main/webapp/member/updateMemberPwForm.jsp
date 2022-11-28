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
						<input type="password" name="memberNewPw">
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" name="memberNewPwCk">
					</td>
				</tr>
				<tr>
					<th>
						<button type="submit">비밀번호 수정</button>
					</th>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>