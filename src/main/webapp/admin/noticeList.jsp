<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}
	
	// M : notice list
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(0, 0);
	int noticeCount = noticeDao.selectNoticeCount(); // -> lastPage
	
	// 최근 공지 5개, 최근 멤버 5명
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리</a></li> <!-- 목록, 레벨수정, 강제탈퇴 -->
	</ul>
	<div>
		<!-- noticeList contents -->
		<h1>공지</h1>
		<a href="<%= %>">공지입력</a>
		<table>
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list) {
					
				}
			%>
		</table>
	</div>
</body>
</html>