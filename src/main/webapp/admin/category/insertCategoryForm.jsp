<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
</head>
<body>
	<div>
		<h1>카테고리 추가</h1>
	</div>
	<div>
		<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
			<table>
				<tr>
					<th>카테고리 종류</th>
					<td>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출">지출
					</td>
				</tr>
				<tr>
					<th>카테고리 이름</th>
					<td>
						<input type="text" name="categoryName" placeholder="카테고리 이름을 입력해주세요.">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">뒤로</a>
		<button type="submit">추가</button>
	</div>
</body>
</html>