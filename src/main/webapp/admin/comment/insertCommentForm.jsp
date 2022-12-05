<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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
	
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelp(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCommentForm</title>
</head>
<body>
	<div>
		<h1>문의사항 답변 작성</h1>
	</div>
	<div>
		<table>
			<tr>
				<th>회원 문의사항</th>
			</tr>
			<tr>
				<th>문의내용</th>
				<td><%=help.getHelpMemo()%></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=help.getMemberId()%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=help.getCreatedate()%></td>
			</tr>
		</table>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/comment/insertCommentAction.jsp" method="post">
			<table>
				<tr>
					<th>답변작성</th>
				</tr>
				<tr>
					<th>답변</th>
					<td><textarea name="commentMemo" placeholder="답변을 입력해주세요."></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="helpNo" value="<%=helpNo%>">
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">뒤로</a>
			<button type="submit">답변작성</button>
		</div>
	</div>
</body>
</html>