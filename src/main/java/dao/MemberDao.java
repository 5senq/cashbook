package dao;


import vo.*;
import util.*;
import java.sql.*;
import java.util.*;

public class MemberDao {
	public Member login(Member paramMember) {
		Member resultMember = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			System.out.println("prepareStatement SQL Query : " + sql);
			
			rs = stmt.executeQuery();
			System.out.println("SQL executeQuery");
			
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberNo(rs.getInt("memberNo"));
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				System.out.println("SQL Set");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultMember;
	}
	
	public int insertMember(Member paramMember) {
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO member(member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), NOW(), NOW())";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberName());
			stmt.setString(3, paramMember.getMemberPw());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("입력 성공");
			} else {
				System.out.println("입력 실패");
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
				} catch (Exception e){
					e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	public int insertMember1(Member member) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO member(member_id, member_name, member_pw, updatedate, createdate) VALUES(?, ?, PASSWORD(?), NOW(), NOW())";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberName());
			stmt.setString(3, member.getMemberPw());
			
			row = stmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int selectDuplicateInsertMember(Member paramMember) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT * FROM member WHERE member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				row = row + 1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	/*
	public boolean selectMemberIdCheck(String memberId) throws Exception {
		boolean result = false;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT * FROM member WHERE member_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return result;
	}
	*/
	public int updateMember(Member paramMember) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE member SET member_id = ?, member_name = ?, updatedate = CURDATE() WHERE member_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberName());
			stmt.setInt(3, paramMember.getMemberNo());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("수정 실패");
			} else {
				System.out.println("수정 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int selectDuplicateUpdateMember(Member paramMember, String sessionMemberId) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				if(paramMember.getMemberId().equals(sessionMemberId)) {
					dbUtil.close(rs, stmt, conn);
					return row;
				} else {
					row = row + 1;
					System.out.println("Duplicated ID");
					
					dbUtil.close(rs, stmt, conn);
					return row;
				}
			} else {
				dbUtil.close(rs, stmt, null);
					
				sql = "SELECT member_id memberId FROM member WHERE member_id = ?";
				
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, paramMember.getMemberId());
				
				rs = stmt.executeQuery();
				
				if(rs.next()) {
					row = row + 1;
					System.out.println("Duplicated ID");
					
					dbUtil.close(rs, stmt, conn);
					
					return row;
				}	
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int updateMemberPw(Member paramMember, String changePw) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT member_no memberNo, member_id memberId, member_pw memberPw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			rs = stmt.executeQuery();
		
			if(rs.next()) {
				sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";
				
				PreparedStatement updateStmt = conn.prepareStatement(sql);
				updateStmt.setString(1, changePw);
				updateStmt.setString(2, paramMember.getMemberId());
				
				row = updateStmt.executeUpdate();
				
				if(row == 0) {
					System.out.println("변경 실패");
				} else {
					System.out.println("변경 성공");
				}
				
				updateStmt.close();
			
			} else {
				System.out.println("현재 비밀번호가 맞지 않습니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public boolean deleteMemberCheck(Member paramMember) {
		boolean result = false;

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			rs = stmt.executeQuery();
		
			if(rs.next()) {
				result = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int deleteMember(Member paramMember) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			row = stmt.executeUpdate();
		
			if(row == 0) {
				System.out.println("삭제 실패");
			} else {
				System.out.println("삭제 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	//
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = null;

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, updatedate, createdate, member_level memberLevel FROM member ORDER BY createdate DESC LIMIT ?, ?";

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<Member>();
		
			while(rs.next()) {
				
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberName(rs.getString("memberName"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setCreatedate(rs.getString("createdate"));
				m.setUpdatedate(rs.getString("updatedate"));
				
				list.add(m);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	//
	public int deleteMemberByAdmin(Member member) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM member WHERE member_no = ? AND member_id = ? AND member_level = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberNo());
			stmt.setString(2, member.getMemberId());
			stmt.setInt(3, member.getMemberLevel());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("탈퇴 실패");
			} else {
				System.out.println("탈퇴 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	//
	public int selectMemberCount() {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT COUNT(*) cnt FROM member";
			
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
		
			if(rs.next()) {
				row = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	//
	public int updateMemberLevel(Member member) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE member SET member_level = ?, updatedate = NOW() WHERE membere_no = ? AND member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
			stmt.setString(3, member.getMemberId());
			
			row = stmt.executeUpdate();
		
			if(row == 0) {
				System.out.println("업데이트 실패");
			} else {
				System.out.println("업데이트 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	//
	public Member selectMemberByAdmin(String memberId) {
		Member member = null;
	
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT * FROM member WHERE member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			
			member = new Member();
		
			if(rs.next()) {
				member.setMemberId(rs.getString("member_id"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberNo(rs.getInt("member_no"));
				member.setMemberLevel(rs.getInt("member_level"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return member;
	}
}

	

