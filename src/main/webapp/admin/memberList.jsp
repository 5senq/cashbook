<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	// C
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
		}
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	
	// M
	MemberDao memberDao = new MemberDao();
	int memberCount = memberDao.selectMemberCount(); // -> lastPage
	int lastPage = (int)Math.ceil(((double)(memberCount) / rowPerPage));
	
	if(currentPage < 1) {
		response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp?currentPage = 1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp?currentPage=" + lastPage);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage;
	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리</a></li> <!-- 목록, 레벨수정, 강제탈퇴 -->
	</ul>
	<div>
		<!-- memberList contents -->
		<h1>멤버목록</h1>
		<table>
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : memberList) {
			%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberId=<%=m.getMemberId()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminForm.jsp?memberId=<%=m.getMemberId()%>">탈퇴</a></td>
					</tr>
			<%		
				}
			%>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage = 1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
			<%
				}
			%>
			<%=currentPage%> / <%=lastPage%>
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
</body>
</html>