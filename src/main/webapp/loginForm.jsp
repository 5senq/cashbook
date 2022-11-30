<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
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

<html class="light-style layout-menu-fixed" data-theme="theme-default" data-assets-path="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/" data-base-url="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo" data-framework="laravel" data-template="vertical-menu-laravel-template-free">

<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

	<title>Login Basic - Pages | Sneat - HTML Laravel Free Admin Template </title>
	<meta name="description" content="Most Powerful &amp; Comprehensive Bootstrap 5 HTML Admin Dashboard Template built for developers!" />
	<meta name="keywords" content="dashboard, bootstrap 5 dashboard, bootstrap 5 design, bootstrap 5, bootstrap 5 free, free admin template">
	<!-- laravel CRUD token -->
	<meta name="csrf-token" content="bBEB0Fv4SPTbYSpLRsS1VawNrXrFhmPUq2cqCoxJ">
	<!-- Canonical SEO -->
	<link rel="canonical" href="https://themeselection.com/item/sneat-bootstrap-html-laravel-admin-template/">
	<!-- Favicon -->
	<link rel="icon" type="image/x-icon" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/img/favicon/favicon.ico" />

	<!-- Include Styles -->
	<!-- BEGIN: Theme CSS-->
	<!-- Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/fonts/boxicons.css?id=b821a646ad0904f9218f56d8be8f070c" />

	<!-- Core CSS -->
	<link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/css/core.css?id=7a74a9d0cfeabd283069bfaa3de33eaa" />
	<link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/css/theme-default.css?id=3d127db9612959fd1b1297d4adb3d55e" />
	<link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/css/demo.css?id=8a804dae81f41c0f9fcbef2fa8316bdd" />

	<link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css?id=98fefe4424f0148a6e7c70b613511b33" />

	<!-- Vendor Styles -->


	<!-- Page Styles -->
	<!-- Page -->
	<link rel="stylesheet" href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/css/pages/page-auth.css">

	<!-- Include Scripts for customizer, helper, analytics, config -->
	<!-- laravel style -->
	<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/js/helpers.js"></script>

	<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
	<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/js/config.js"></script>

	<!-- beautify ignore:end -->

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async="async" src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
	
		function gtag() {
		dataLayer.push(arguments);
		}
		gtag('js', new Date());
		gtag('config', 'GA_MEASUREMENT_ID');
	</script>

	<!-- Place this tag in your head or just before your close body tag. -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
	<style>
		label {
			width:900px;
		}
		
		a:link {
		color: gray;
		background-color: transparent;
		text-decoration: none;
		}
	
		a:visited {
		color: gray;
		background-color: transparent;
		text-decoration: none;
		}
	
		a:hover {
		color: gray;
		background-color: transparent;
		text-decoration: none;
		}
	
		a:active {
		color: gray;
		background-color: transparent;
		text-decoration: none;
		}
	</style>
</head>

<body>
	<!-- Responsive Table -->
	<div class="card">
		<h5 class="card-header">Notice</h5>
		<div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr class="text-nowrap">
						<th>#</th>
						<th><label>Notice</label></th>
						<th>Createdate</th>
				    </tr>
				</thead>
				<tbody>
					<%
						for(Notice n : list) {
					%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><label><%=n.getNoticeMemo()%></label></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<br>
			<div class="text-center">
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">◀</a>
					<%
						if(currentPage > 1) {
					%>
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">◁</a>
					<%
						}
					%>
							<span><%=currentPage%> / <%=lastPage%></span>
					<%
						if(currentPage < lastPage) {
					%>
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">▷</a>
					<%
						}
					%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">▶</a>
			</div>
		</div>
		<br>
	</div>
  
	<!-- Layout Content -->

	<!-- Content -->
	<div class="container-xxl">
		<div class="authentication-wrapper authentication-basic container-p-y">
			<div class="authentication-inner">
				<!-- Register -->
				<div class="card">
					<div class="card-body">
						<!-- Logo -->

						<div class="app-brand justify-content-center">
							<%
								/* 
								<a href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo" class="app-brand-link gap-2">
								<span class="app-brand-logo demo"><svg width="25" viewBox="0 0 25 42" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
								*/
							%>
              
							<defs>
								<path d="M13.7918663,0.358365126 L3.39788168,7.44174259 C0.566865006,9.69408886 -0.379795268,12.4788597 0.557900856,15.7960551 C0.68998853,16.2305145 1.09562888,17.7872135 3.12357076,19.2293357 C3.8146334,19.7207684 5.32369333,20.3834223 7.65075054,21.2172976 L7.59773219,21.2525164 L2.63468769,24.5493413 C0.445452254,26.3002124 0.0884951797,28.5083815 1.56381646,31.1738486 C2.83770406,32.8170431 5.20850219,33.2640127 7.09180128,32.5391577 C8.347334,32.0559211 11.4559176,30.0011079 16.4175519,26.3747182 C18.0338572,24.4997857 18.6973423,22.4544883 18.4080071,20.2388261 C17.963753,17.5346866 16.1776345,15.5799961 13.0496516,14.3747546 L10.9194936,13.4715819 L18.6192054,7.984237 L13.7918663,0.358365126 Z" id="path-1"></path>
								<path d="M5.47320593,6.00457225 C4.05321814,8.216144 4.36334763,10.0722806 6.40359441,11.5729822 C8.61520715,12.571656 10.0999176,13.2171421 10.8577257,13.5094407 L15.5088241,14.433041 L18.6192054,7.984237 C15.5364148,3.11535317 13.9273018,0.573395879 13.7918663,0.358365126 C13.5790555,0.511491653 10.8061687,2.3935607 5.47320593,6.00457225 Z" id="path-3"></path>
								<path d="M7.50063644,21.2294429 L12.3234468,23.3159332 C14.1688022,24.7579751 14.397098,26.4880487 13.008334,28.506154 C11.6195701,30.5242593 10.3099883,31.790241 9.07958868,32.3040991 C5.78142938,33.4346997 4.13234973,34 4.13234973,34 C4.13234973,34 2.75489982,33.0538207 2.37032616e-14,31.1614621 C-0.55822714,27.8186216 -0.55822714,26.0572515 -4.05231404e-15,25.8773518 C0.83734071,25.6075023 2.77988457,22.8248993 3.3049379,22.52991 C3.65497346,22.3332504 5.05353963,21.8997614 7.50063644,21.2294429 Z" id="path-4"></path>
								<path d="M20.6,7.13333333 L25.6,13.8 C26.2627417,14.6836556 26.0836556,15.9372583 25.2,16.6 C24.8538077,16.8596443 24.4327404,17 24,17 L14,17 C12.8954305,17 12,16.1045695 12,15 C12,14.5672596 12.1403557,14.1461923 12.4,13.8 L17.4,7.13333333 C18.0627417,6.24967773 19.3163444,6.07059163 20.2,6.73333333 C20.3516113,6.84704183 20.4862915,6.981722 20.6,7.13333333 Z" id="path-5"></path>
							</defs>
							<g id="g-app-brand" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
								<g id="Brand-Logo" transform="translate(-27.000000, -15.000000)">
									<g id="Icon" transform="translate(27.000000, 15.000000)">
										<g id="Mask" transform="translate(0.000000, 8.000000)">
											<mask id="mask-2" fill="white">
												<use xlink:href="#path-1"></use>
											</mask>
											<use fill="#696cff" xlink:href="#path-1"></use>
											<g id="Path-3" mask="url(#mask-2)">
												<use fill="#696cff" xlink:href="#path-3"></use>
												<use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-3"></use>
											</g>
											<g id="Path-4" mask="url(#mask-2)">
												<use fill="#696cff" xlink:href="#path-4"></use>
												<use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-4"></use>
											</g>
										</g>
										<g id="Triangle" transform="translate(19.000000, 11.000000) rotate(-300.000000) translate(-19.000000, -11.000000) ">
											<use fill="#696cff" xlink:href="#path-5"></use>
											<use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-5"></use>
										</g>
									</g>
								</g>
							</g>
</svg>
</span>
<%
/*
<span class="app-brand-text demo text-body fw-bolder">Sneat</span>
*/
%>
</a>
</div>
<!-- /Logo -->
<h4 class="mb-2">Welcome to account book👋</h4>
<p class="mb-4">Please sign-in to your account and create a household account book!</p>

<form id="formAuthentication" class="mb-3" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
<div class="mb-3">
<label for="email" class="form-label">Email or Username</label>
<input type="text" class="form-control" id="email" name="memberId" placeholder="Enter your email or username" autofocus>
</div>
<div class="mb-3 form-password-toggle">
<div class="d-flex justify-content-between">
<label class="form-label" for="password">Password</label>
<%
/*
<a href="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/auth/forgot-password-basic">
<small>Forgot Password?</small>
</a>
*/
%>
</div>
<div class="input-group input-group-merge">
<input type="password" id="password" class="form-control" name="memberPw" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" />
<%
/*
<span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
*/
%>
</div>
</div>
<%
/*
<div class="mb-3">
<div class="form-check">
<input class="form-check-input" type="checkbox" id="remember-me">
<label class="form-check-label" for="remember-me">
Remember Me
</label>
</div>
</div>
*/
%>
<div class="mb-3">
<button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>
</div>
</form>

<p class="text-center">
<span>New on our platform?</span>
<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">
<span>Create an account</span>
</a>
</p>
</div>
</div>
</div>
<!-- /Register -->
</div>
</div>
</div>
<!--/ Content -->

<!--/ Layout Content -->

<%
/*
<div class="buy-now">
<a href="https://themeselection.com/item/sneat-bootstrap-html-laravel-admin-template/" target="_blank" class="btn btn-danger btn-buy-now">Upgrade To Pro</a>
</div>
*/
%>

<!-- Include Scripts -->
<!-- BEGIN: Vendor JS-->
<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/libs/jquery/jquery.js?id=c9eab148c98f81221c99ba6da84fdbe2"></script>
<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/libs/popper/popper.js?id=3b2f93fa0eb2f0ed310a789319de72fc"></script>
<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/js/bootstrap.js?id=f4406bcd0acdeffbdcca24c2e1033ae6"></script>
<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js?id=2f948c841c6aca9e3a18f6ef2c65b140"></script>
<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/vendor/js/menu.js?id=3421096250c82e0d3760f641a4d2dba0"></script>
<!-- END: Page Vendor JS-->
<!-- BEGIN: Theme JS-->
<script src="https://demos.themeselection.com/sneat-bootstrap-html-laravel-admin-template-free/demo/assets/js/main.js?id=0c91cceb5195b308a36d5ac021b16464"></script>

<!-- END: Theme JS-->
<!-- Pricing Modal JS-->
<!-- END: Pricing Modal JS-->
<!-- BEGIN: Page JS-->
<!-- END: Page JS-->

</body>

</html>
