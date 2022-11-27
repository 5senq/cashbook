<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// C	

	request.setCharacterEncoding("UTF-8");	

	// session에 저장된 멤버(현재 로그인 사용자)를 Member타입에 저장 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// M
	
	MemberDao memberDao = new MemberDao();
	ArrayList<HashMap<String, Object>> updateMemberList = memberDao.selectMemberListById(loginMember.getMemberId());
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberForm</title>
</head>
<body>
	<h1>회원정보 수정</h1>
	<%
		if(request.getParameter("msg") != null) {
	%>
			<div><%=request.getParameter("msg")%></div>
	<%		
		}
	%>
	<!-- 폼 작성 -->
	<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
		<%
			for(HashMap<String, Object> m : updateMemberList) {
				String memberId = (String)(m.get("memberId"));
				String memberName = (String)(m.get("memberName"));
		%>
			<input type="hidden" name="memberNo" value="">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</td>
					<td>비밀번호</td>
					<td>
						<input type="password" name="memberPw" value="">
					</td>
					<td>이름</td>
					<td>
						<input type="text" name="memberName" value="<%=memberName%>">
					</td>
				</tr>
				<tr>
					<td>
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		<%
			}
		%>
	</form>
</body>
</html>