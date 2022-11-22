package dao;

import vo.Member;
import util.DBUtil;
import java.sql.*;

public class MemberDao {
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		/*
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
		
		--> DB를 연결하는 코드(명령들)가 Dao method를 공통으로 중복된다.
		--> 이 중복되는 코드를 하나의 이름(method)으로 만들자.
		--> 입력값과 반환값을 결정해야 한다.
		--> 입력값은 없지만 반환값은 Connection타입의 결과값이 남아야한다.
		
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id=? AND member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberPw(rs.getString("memberName"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember; 
	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		return resultRow;
	}
}