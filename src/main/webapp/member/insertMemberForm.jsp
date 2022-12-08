<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
%>

<!DOCTYPE html>
<html class="h-100" lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<title>insertMemberForm</title>
		<!-- Favicon icon -->
		<link rel="icon" type="image/png" sizes="16x16" href="../resources/images/favicon.png">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
		<link href="../resources/css/style.css" rel="stylesheet">
	</head>

	<body class="h-100">
    
		<!--*******************
			Preloader start
		********************-->
		<div id="preloader">
			<div class="loader">
				<svg class="circular" viewBox="25 25 50 50">
					<circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
				</svg>
			</div>
		</div>
		<!--*******************
			Preloader end
		********************-->
	
		<div class="login-form-bg h-100">
			<div class="container h-100">
				<div class="row justify-content-center h-100">
					<div class="col-xl-6">
						<div class="form-input-content">
							<div class="card login-form mb-0">
								<div class="card-body pt-5">
	                                
									<a class="text-center"> <h4>회원가입</h4></a>
	        
									<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post" class="mt-5 mb-5 login-input">
										<div class="form-group">
											<input type="text" class="form-control" name="memberId" placeholder="아이디" required>
										</div>
										<div class="form-group">
											<input type="text" class="form-control" name="memberName" placeholder="닉네임" required>
										</div>
										<div class="form-group">
											<input type="password" class="form-control" name="memberPw" placeholder="비밀번호" required>
										</div>
										<button class="btn login-form__btn submit w-100">회원가입</button>
									</form>
									<p class="mt-5 login-form__footer">혹시 회원이신가요?&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-primary">로그인</a></p>
	 							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    
		<!--**********************************
						Scripts
		***********************************-->
		<script src="../resources/plugins/common/common.min.js"></script>
		<script src="../resources/js/custom.min.js"></script>
		<script src="../resources/js/settings.js"></script>
		<script src="../resources/js/gleek.js"></script>
		<script src="../resources/js/styleSwitcher.js"></script>
	</body>
</html>





