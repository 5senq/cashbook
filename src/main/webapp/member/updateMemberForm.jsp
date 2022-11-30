<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");	

	// 로그인 유효성 검사
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
	
	// session에 저장된 멤버(현재 로그인 사용자)를 Member타입에 저장 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberForm</title>
</head>
<body>
	<h1>회원정보 수정</h1>
	
	<!-- 폼 작성 -->
	<div>
		<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td>
						<input type="text" name="memberName" value="<%=memberName%>">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw" value="">
					</td>
				</tr>
			</table>
			<button type="submit">수정</button>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/loginForm.jsp">뒤로</a>
	</div>
</body>
</html>