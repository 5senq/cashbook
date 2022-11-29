<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	
	// Controller : session, request
	
	request.setCharacterEncoding("UTF-8");
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	// session에 저장된 멤버(현재 로그인 사용자)를 Member타입에 저장 
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// request 연도 + 월
	int year = 0;
	int month = 0;
	
	// 연도, 월 구하는 알고리즘
	if((request.getParameter("year") == null) || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 경우
		if(month == -1) {
			month = 11;
			year = year -1;
		} else if(month == 12) {
			month = 0;
			year = year + 1;
		}
	}
	// 출력하고자 하는 월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7) 구하기
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	// begin blank 개수는 firstDay - 1
	
	// 마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 가 7로 나누어 떨어져야한다. --> totalTd
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	long totalCash = 0;
	long expenseCash = 0;
	long importCash = 0;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1, memberId);
	// ArrayList 형태로 저장되어 있는 cashDao.selectCashListByMonth method로 (loginMember.getMemberId(), year, month+1)을 보내고, 결과값 ArrayList<HashMap> 형태로 list값에 세팅한다
	
	// View : 달력 출력 + 일별 cash 목록 출력
%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>cashList</title>
	</head>
	<body>
		<div>
			<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
			<%=loginMember.getMemberName()%> 님
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
			<%
				if(loginMember.getMemberLevel() > 0) {
			%>
					<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
			<%		
				}
			%>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a>
			<%=year%> 년 <%=month+1%> 월
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year<%=year%>&month=<%=month+1%>">다음달&#8702;</a>
		</div>
		<div>
			<!-- 달력 -->
			<table border="1">
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
				<tr>
					<%
						for(int i=1; i<=totalTd; i++) {
					%>
							<td>
								<%
									int date = i - beginBlank; // i는 td의 갯수라서 출력하면 안됨
									if(date > 0 && date <= lastDate) {
								%>
										<div>
											<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
												<%=date%>
											</a>
										</div>
										<div>
											<%
												for(HashMap<String, Object> m : list) { // 위 세팅된 ArrayList<HashMap> list를 CashDao Class에서 HashMap<String, Object> m으로 생성했기때문에 foreach문이 다음과 같이 쓰임
													String cashDate = (String)(m.get("cashDate")); // m.get 앞 String은 형변환을 해줌
													if(Integer.parseInt(cashDate.substring(8)) == date) {
											%>
														<%=(String)(m.get("categoryKind"))%>
														<%=(String)(m.get("categoryName"))%>
														&nbsp;
														<%=(Long)(m.get("cashPrice"))%>원
														<br>
											<%			
													}
												}
											%>
										</div>
								<%		
									}
								%>
							</td>
					<%
						if(i%7 == 0 && i != totalTd) {
					%>
				</tr>
				<tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
					<%
							}
						}
					%>
				</tr>
			</table>	
		</div>
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">뒤로</a>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
	</body>
</html>