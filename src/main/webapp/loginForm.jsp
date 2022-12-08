<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	// int lastPage = 0;
	
	NoticeDao noticeDao = new NoticeDao();
	
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage; // 공지사항 카운트해서 lastPage 구하기
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	System.out.println("lastPage=" + lastPage);
%>

<!DOCTYPE html>
<html class="h-100" lang="en">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<title>loginForm</title>
		<!-- Favicon icon -->
		<link rel="icon" type="image/png" sizes="16x16" href="resources/images/favicon.png">
		<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous"> -->
		<link href="resources/css/style.css" rel="stylesheet">
	    
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
							<div class="">
								<div class="card-body pt-5">
									<h4 class="card-title">최근 공지</h4>
									<div id="activity">
										
										<div class="media border-bottom-1 pt-3 pb-3">
											<div class="media-body">
												<h5>Received New Order</h5>
												<p class="mb-0">I shared this on my fb wall a few months back,</p>
											</div><span class="text-muted ">April 24, 2018</span>
										</div>
										
										<div class="media border-bottom-1 pt-3 pb-3">
											<div class="media-body">
												<h5>iPhone develered</h5>
												<p class="mb-0">I shared this on my fb wall a few months back,</p>
											</div><span class="text-muted ">April 24, 2018</span>
										</div>
										
										<div class="media border-bottom-1 pt-3 pb-3">
											<div class="media-body">
												<h5>3 Order Pending</h5>
												<p class="mb-0">I shared this on my fb wall a few months back,</p>
											</div><span class="text-muted ">April 24, 2018</span>
										</div>
										
										<div class="media border-bottom-1 pt-3 pb-3">
											<div class="media-body">
												<h5>Join new Manager</h5>
												<p class="mb-0">I shared this on my fb wall a few months back,</p>
											</div><span class="text-muted ">April 24, 2018</span>
										</div>
										
										<div class="media border-bottom-1 pt-3 pb-3">
											<div class="media-body">
												<h5>Branch open 5 min Late</h5>
												<p class="mb-0">I shared this on my fb wall a few months back,</p>
											</div><span class="text-muted ">April 24, 2018</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-6">
						<div class="form-input-content">
							<div class="card login-form mb-0">
								<div class="card-body pt-5">
									<a class="text-center"><h4>로그인</h4></a>
									<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" class="mt-5 mb-5 login-input">
										<div class="form-group">
											<input type="text" class="form-control" name="memberId" placeholder="아이디">
										</div>
										<div class="form-group">
											<input type="password" class="form-control" name="memberPw" placeholder="비밀번호">
										</div>
										<button type="submit" class="btn login-form__btn submit w-100">로그인</button>
									</form>
									<p class="mt-5 login-form__footer">아직 회원이 아니신가요?&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="text-primary">회원가입</a></p>
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
		<script src="resources/plugins/common/common.min.js"></script>
		<script src="resources/js/custom.min.js"></script>
		<script src="resources/js/settings.js"></script>
		<script src="resources/js/gleek.js"></script>
		<script src="resources/js/styleSwitcher.js"></script>
	</body>
</html>





