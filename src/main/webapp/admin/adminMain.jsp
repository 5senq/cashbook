<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	// C
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
			return;
		}
	}
	
	int beginRow = 0;
	int rowPerPage = 5;

	// M
	
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	
	// 최근 공지 5개, 최근 멤버 5명
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<div>
		<table>
			<tr>
				<th>최신 공지사항</th>
			</tr>
			<tr>
				<%
					for(Notice n : noticeList) {
				%>
						<td><%=n.getNoticeNo()%></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
			</tr>
			<tr>
				<%
					}
				%>
			</tr>
		</table>
	</div>
	<div>
		<table>
			<tr>
				<th>신규 가입회원</th>
			</tr>
			<tr>
				<%
					for(Member m : memberList) {
				%>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getCreatedate()%></td>
				</tr>
				<tr>
				<%
					}
				%>
			</tr>
		</table>
	</div>
	<div>
		<table>
			<tr>
				<th>신규 문의사항</th>
			</tr>
			<tr>
				<%
					for(HashMap<String, Object> h : helpList) {
				%>
						<td><%=h.get("helpNo")%></td>
						<td><%=h.get("helpMemo")%></td>
						<td><%=h.get("helpCreatedate")%></td>
			</tr>
			<tr>
				<%
					}
				%>
			</tr>
		</table>
	</div>
</body>
</html>