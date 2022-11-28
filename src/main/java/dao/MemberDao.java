package dao;


import vo.*;
import util.*;
import java.sql.*;
import java.util.*;

public class MemberDao {
	// 관리자 : 멤버 레벨 수정
	public int updateMemberLevel(Member member) {
		return 0;
	}
	
	// 관리자 : 멤버 수
	public int selectMemberCount() {
		return 0;
	}
	
	// 관리자 : 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		/*
		 ORDER BY createdate DESC
		 */
		return null;
	}
	
	// 관리자 : 멤버 강퇴(회원 넘버로 삭제)
	public int deleteMemberByAdmin(Member member) {
		return 0;
	}
	
	/*
	회원탈퇴
	public int deleteMember(Member member) {
		return 0;
	}
	*/
	
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
		String loginSql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = ?";
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
	
	// 회원정보 수정
	// updateMemberForm.jsp
	public ArrayList<HashMap<String, Object>> selectMemberListById(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> updateMemberList = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String updateSql = "SELECT member_no memberNo, member_id memberId, member_name memberName FROM member WHERE member_id = ?";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setString(1, memberId);
		ResultSet updateRs = updateStmt.executeQuery();
		while(updateRs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("memberNo", updateRs.getInt("memberNo"));
			m.put("memberId", updateRs.getString("memberId"));
			m.put("memberName", updateRs.getString("memberName"));
			updateMemberList.add(m);
		}
		
		updateRs.close();
		updateStmt.close();
		conn.close();
		
		return updateMemberList;
	}
	
	// updateMemberAction.jsp
	public int update(Member updateMember) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		int resultRow = 0;
		String upActSql = "UPDATE member SET mamber_name = ? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement upActStmt = conn.prepareStatement(upActSql);
		upActStmt.setString(1, updateMember.getMemberName());
		upActStmt.setString(2, updateMember.getMemberId());
		upActStmt.setString(3, updateMember.getMemberPw());
		resultRow = upActStmt.executeUpdate();
		if(resultRow == 1) {
			System.out.println("회원정보 수정완료");
		} else {
			System.out.println("회원정보 수정실패");
		}
		
		upActStmt.close();
		conn.close();
			
		return resultRow;
	}
	
	// updatePwAction.jsp
	public Member updateMemberPw(Member paramMember, String newPw) throws Exception {
		Member resultMember = null;
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 2. sql을 이용하여 Delete
		String newPwSql = "UPDATE member SET member_pw = PASSWORD(?), updatedate = CURDATE() WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement newPwStmt = conn.prepareStatement(newPwSql);
		newPwStmt.setString(1, newPw);
		newPwStmt.setString(2, paramMember.getMemberId());
		newPwStmt.setString(3, paramMember.getMemberPw());
		
		int row = newPwStmt.executeUpdate();
		
		if(row == 1) {
			
			resultMember = new Member();
			resultMember.setMemberId(paramMember.getMemberId());
			resultMember.setMemberPw(newPw);
			
		} 
		dbUtil.close(null, newPwStmt, conn);
		
		return resultMember;
	}
	
	// 입력한 두 비밀번호가 일치하는지 확인하는 method
	public boolean passwordCheck(String pw, String pwCheck) {
		boolean result = false;
		if(pw.equals(pwCheck)) {
			result = true;
		}
		return result;
	}

	// 회원탈퇴
	public boolean deleteMember(Member paramMember) throws Exception {
		boolean result = false;
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 2. sql을 이용하여 Delete
		String deleteSql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setString(1, paramMember.getMemberId());
		deleteStmt.setString(2, paramMember.getMemberPw());
		
		int row = deleteStmt.executeUpdate();
		
		if(row == 1) {
			result = true;
		}
		dbUtil.close(null, deleteStmt, conn);
		
		return result;
	}
}

	

