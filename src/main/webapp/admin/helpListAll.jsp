<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	int currentPage = 1;
	// request.getParameter("currentPage")
	int rowPerPage = 10;
	int beginRow = (1-currentPage) * rowPerPage;
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListAll</title>
</head>
<body>
	<!-- header include -->
	<!-- 고객센터 문의 목록 -->
	<table>
		<tr>
			<th>문의내용</th>
			<th>회원아이디</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변추가 / 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap m : list) {
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td><%=m.get("commentMemo")%></td>
					<td><%=m.get("commentCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/admin/insertComment.jsp?helpNo=<%=m.get("helpNo")%>">답변입력</a>
						<%		
							} else {
						%>
						
						<%		
							}
						%>
				</tr>
		<%
			}
		%>
	</table>
	<!-- footer include -->
</body>
</html>