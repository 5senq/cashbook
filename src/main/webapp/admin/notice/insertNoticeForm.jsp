<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
</head>
<body>
	<div>
		<h1>공지사항 작성</h1>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp" method="post">
			<table>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="noticeMemo" placeholder="공지사항 내용을 입력해주세요."></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">뒤로</a>
		<button type="submit">공지</button>
	</div>
</body>
</html>