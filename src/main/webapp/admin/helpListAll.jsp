<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

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
	
	HelpDao helpDao = new HelpDao();
	
	int helpListCount = helpDao.selectHelpListCount();
	int lastPage = (int)Math.ceil(((double)(helpListCount) / rowPerPage));
	
	if(currentPage < 1) {
		response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp?currentPage = 1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp?currentPage=" + lastPage);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage;
	
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListAll</title>
</head>
<body>
	<div>
		<table>
			<tr>
				<th>번호</th>
				<th>문의내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답변내용</th>
				<th>답변일</th>
				<th>답변추가 / 수정 / 삭제</th>
			</tr>
			<tr>
				<%
					for(HashMap<String, Object> m : list) {
				%>
						<td><%=m.get("helpNo")%></td>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("memberId")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<td>
							<%
								if(m.get("commentMemo") == null) {
							%>
									<span>답변 미작성</span>
							<%
								} else {
							%>
									<span><%=m.get("commentMemo")%></span>
							<%
								}
							%>
						</td>
						<td>
							<%
								if(m.get("commentMemo") == null) {
							%>
									<span>답변 미작성</span>
							<%		
								} else {
							%>
									<span><%=m.get("commentCreatedate")%></span>
							<%
								}
							%>
						</td>
						<td>
							<%
								if(m.get("commentMemo") == null) {
							%>
									<a href="<%=request.getContextPath()%>/admin/help/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변 입력</a>
							<%
								} else {
							%>
									<a href="<%=request.getContextPath()%>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변 수정</a>
									<a href="<%=request.getContextPath()%>/admin/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">답변 삭제</a>
							<%
								}
							%>
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
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage = 1">처음</a>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%
			}
		%>
		<%=currentPage%> / <%=lastPage%>
		<%
			if(currentPage < lastPage) {
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
</body>
</html>