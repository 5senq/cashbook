<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	// int lastPage = 0;
	
	NoticeDao noticeDao = new NoticeDao();
	
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage; // 공지사항 카운트해서 lastPage 구하기
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	System.out.println("lastPage=" + lastPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<!-- 공지(5개)목록 페이징 -->
	<div>
		<table>
			<thead>
				<tr>
					<th>공지사항</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<%
						for(Notice n : list) {
					%>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
					<%
						}
					%>
				</tr>
			</tbody>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">첫 페이지</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
				%>
						<span><%=currentPage%> / <%=lastPage%></span>
				<%
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막 페이지</a>
		</div>
	</div>
	
	<!-- 로그인 폼 -->
	<h1>로그인</h1>	
	<div>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>
		<button type="submit">로그인</button>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
	</div>
</body>
</html>