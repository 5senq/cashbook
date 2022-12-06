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
	
	// 삭제하려는 memberId값이 없을시 list 페이지로 이동
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp");
	}
	
	String deleteMemberId = request.getParameter("memberId");
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(deleteMemberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberByAdminForm</title>
</head>
<body>
	<div>
		<form action="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminAction.jsp" method="post">
			<table>
				<tr>
					<th>회원 내역</th>
				</tr>
				<tr>
					<th>회원 번호</th>
					<td><input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly"></td>
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
					<td><input type="text" name="memberLevel" value="<%=member.getMemberLevel()%>" readonly="readonly"></td>
			</table>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp">뒤로</a>
		<button type="submit">회원삭제</button>
	</div>
</body>
</html>