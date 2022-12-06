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
	
	// 공지사항 번호가 없을시 list 페이지로 이동
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice noticeByNo = noticeDao.selectNoticeByNo(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
	<div>
		<h1>공지사항 수정</h1>
	</div>
	<div>
		<table>
			<tr>
				<th>기존 공지사항</th>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=noticeByNo.getNoticeMemo()%></td>
			</tr>
		</table>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post">
			<table>
				<tr>
					<th>수정사항</th>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="noticeMemo" placeholder="수정할 내용을 작성해주세요."></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="noticeNo" value="<%=noticeByNo.getNoticeNo()%>">
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">뒤로</a>
		<button type="submit">수정</button>
	</div>
</body>
</html>