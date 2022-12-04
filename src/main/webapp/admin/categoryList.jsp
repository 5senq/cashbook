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
	CategoryDao categoryDao = new CategoryDao();
	int categoryCount = categoryDao.selectCategoryCount();
	int lastPage = (int)Math.ceil(((double)(categoryCount) / rowPerPage));
	
	if(currentPage < 1) {
		response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp?currentPage = 1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp?currentPage=" + lastPage);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage;
	
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
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
			<tr>
				<%
					for(Category c : categoryList) {
				%>
						<td><%=c.getCategoryNo()%></td>
						<td><%=c.getCategoryKind()%></td>
						<td><%=c.getCategoryName()%></td>
						<td><%=c.getUpdatedate()%></td>
						<td><%=c.getCreatedate()%></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
						</td>
			</tr>
			<tr>
				<%
					}
				%>
			</tr>
		</table>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage = 1">처음</a>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}
		%>
		<%=currentPage%> / <%=lastPage%>
		<%
			if(currentPage < lastPage) {
		%>
				<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
</body>
</html>