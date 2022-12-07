package dao;

import vo.*;

import java.sql.*;

import util.DBUtil;

public class CommentDao {
	// 선택
	public Comment selectCommentOne(int commentNo) {
		Comment comment = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT * FROM comment WHERE comment_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				comment = new Comment();
				comment.setCommentNo(rs.getInt("comment_no"));
				comment.setHelpNo(rs.getInt("help_no"));
				comment.setCommentMemo(rs.getString("comment_memo"));
				comment.setMemberId(rs.getString("member_id"));
				comment.setUpdatedate(rs.getString("updatedate"));
				comment.setCreatedate(rs.getString("createdate"));
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
		return comment;
	}
	
	// 추가
	public int insertComment(Comment comment) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("입력 실패");
			} else {
				System.out.println("입력 성공");
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
	
	// 수정
	public int updateComment(Comment comment) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE comment SET comment_memo = ?, updatedate = NOW() WHERE comment_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
			
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
	
	// 삭제
	public int deleteComment(Comment comment) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM comment WHERE comment_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getCommentNo());
			
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

}
