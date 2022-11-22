<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller : session, request
	
	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// session에 저장된 멤버(현재 로그인 사용자)를 Member타입에 저장 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
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
			year = year - 1;
		}
		if(month == 12) {
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
	if((beginBlank + lastDate) % 7 !=0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력 출력 + 일별 cash 목록
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
										<a href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<=%=date%>">
											<%=date%>
										</a>
									</div>
									<div>
										<%
											for(HashMap<String, Object> m : list) {
												String cashDate = (String)(m.get("cashDate"));
												if(Integer.parseInt(cashDate.substring(8)) == date) {
										%>
													<%=(String)(m.get("categoryKind"))%>
													<%=(String)(m.get("categoryName")) %>
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
</body>
</html>