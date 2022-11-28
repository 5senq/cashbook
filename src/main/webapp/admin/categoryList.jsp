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
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	// 최근 공지 5개, 최근 멤버 5명
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/.jsp">고객센터</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리</a></li> <!-- 목록, 레벨수정, 강제탈퇴 -->
	</ul>
	<div>
		<!-- categoryList contents -->
		<h1>카테고리 목록</h1>
		<a href="<%=request.getContextPath()%>/admin/adminList.jsp">카테고리 추가</a>
		<table>
			<tr>
				<th>번호</th>
				<th>수입/지출</th>
				<th>이름</th>
				<th>마지막 수정일</th>
				<th>생성일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 모델데이터 categoryList 출력 -->
		</table>
	</div>
</body>
</html>