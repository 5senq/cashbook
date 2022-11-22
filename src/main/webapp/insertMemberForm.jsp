<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp">
		<table>
			<tr>
				<td>회원 아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>회원 비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>회원 이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
		</table>
		<button type = "submit">회원가입완료</button>
	</form>
</body>
</html>