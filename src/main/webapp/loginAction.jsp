<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	// Controller
	String memberId = request.getParameter("memberId"); // loginForm에서 넘겨받음
	
	Member paramMember = new Member(); // 모델 호출시 매개값 (vo.Member Class를 이용하여 paramMember를 새로 선언)
	paramMember.setMemberId(request.getParameter("memberId")); // 새로 선언된 paramMember에 넘겨받은 값 세팅
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	// 분리된 Model 호출
	MemberDao memberDao = new MemberDao(); // memberDao method를 이용해 memberDao를 새로 선언
	Member resultMember = memberDao.login(paramMember); // 위에서 내려온 paramMember값을 MemberDao.login() Class에 보내고 결과값으로 resutlMember값을 받음
	
	String redirectUrl = "/loginForm.jsp"; // redirectUrl값에 필요시 돌아갈 주소값 세팅
	
	if(resultMember !=null) { // MemberDao에서 넘겨받은 결과 resultMember값이 null이 아니라면 수행
		session.setAttribute("loginMember", resultMember); // session안에 loginId & Name을 저장
		redirectUrl = "/cash/cashList.jsp"; // 로그인 후 cashList 화면으로 가겠습니다
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);

%>