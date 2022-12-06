<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");

	// 세션 정보가 없을시 로그인 페이지로 이동
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	// 관리자 레벨이 아닐시 가계부 페이지로 이동
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
			return;
		}
	}
	// 수정하려는 memberId값이 없을시 list 페이지로 이동
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp");
	}
	
	String updateMemberId = request.getParameter("memberId");
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(updateMemberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberLevelForm</title>
</head>
<body>
	<div>
		<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" method="post">
			<table>
				<tr>
					<th>회원 내역</th>
				</tr>
				<tr>
					<th>회원 ID</th>
					<td><input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>회원 닉네임</th>
					<td><input type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>회원 레벨</th>
					<td>
						<%
							if(member.getMemberLevel() == 1) {
						%>
								<input type="radio" name="memberLevel" value="0">일반회원
								<input type="radio" name="memberLevel" value="1" checked="checked">관리자
						<%
							} else {
						%>
								<input type="radio" name="memberLevel" value="0" checked="checked">일반회원
								<input type="radio" name="memberLevel" value="1">관리자
						<%
							}
						%>
					</td>
				</tr>
			</table>
			<input type="hidden" name="memberNo" value="<%=member.getMemberNo()%>">
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp">뒤로</a>
		<button type="submit">수정</button>
	</div>
</body>
</html>