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
	
	if(request.getParameter("commentNo") == null || request.getParameter("commentNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp");
		return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.selectCommentOne(commentNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCommentForm</title>
</head>
<body>
	<div>
		<h1>문의사항 답변 수정</h1>
	</div>
	<div>
		<table>
			<tr>
				<th>수정 전 내용</th>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=comment.getCommentMemo()%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=comment.getCreatedate()%></td>
			</tr>
			<tr>
				<th>수정일</th>
				<td><%=comment.getUpdatedate()%></td>
			</tr>
		</table>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/comment/updateCommentAction.jsp" method="post">
			<table>
				<tr>
					<th>수정사항</th>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="commentMemo" placeholder="수정할 내용을 입력해주세요."></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="commentNo" value="<%=comment.getCommentNo()%>">
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">뒤로</a>
		<button type="submit">수정</button>
	</div>
</body>
</html>