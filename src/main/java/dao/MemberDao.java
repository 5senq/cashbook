package dao;

import vo.*;
import util.*;
import java.sql.*;

public class MemberDao {
	
	// ID 중복확인
	// 반환값 true : 이미 존재, false : 사용 가능
	public boolean selectMemberIdCk(String memberId) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String idSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(idSql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String insertSql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(insertSql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
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
		String loginSql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id=? AND member_pw=?";
		PreparedStatement loginStmt = conn.prepareStatement(loginSql);
		loginStmt.setString(1, paramMember.getMemberId());
		loginStmt.setString(2, paramMember.getMemberPw());
		ResultSet loginRs = loginStmt.executeQuery();
		if(loginRs.next() == false) {
		
		} else {
			resultMember = new Member();
			resultMember.setMemberId(loginRs.getString("memberId"));
			resultMember.setMemberPw(loginRs.getString("memberName"));
		}
		
		loginRs.close();
		loginStmt.close();
		conn.close();
		
		return resultMember; 
	}
}

	

