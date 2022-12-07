package dao;

import vo.*;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class NoticeDao {
	// loginForm.jsp
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<Notice>();
		
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				
				list.add(n);
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
	public int selectNoticeCount() {
		int count = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT COUNT(*) FROM notice";
			
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
		
			while(rs.next()) {
				count = rs.getInt("COUNT(*)");
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
		return count;
	}
	
	public int insertNotice(Notice notice) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			
			row = stmt.executeUpdate();
		
			if(row == 0) {
				System.out.println("공지사항 등록 실패");
			} else {
				System.out.println("공지사항 등록 성공");
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
	
	public int updateNotice(Notice notice) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE notice SET notice_memo = ?, updatedate = NOW() WHERE notice_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
		
			row = stmt.executeUpdate();
		
			if(row == 0) {
				System.out.println("공지사항 수정 실패");
			} else {
				System.out.println("공지사항 수정 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int deleteNotice(Notice notice) {
		int row = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
			
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
	
	public Notice selectNoticeByNo(int noticeNo) {
		Notice notice = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate, updatedate FROM notice WHERE notice_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			
			rs = stmt.executeQuery();
		
			if(rs.next()) {
				notice = new Notice();
				
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeMemo(rs.getString("noticeMemo"));
				notice.setUpdatedate(rs.getString("updatedate"));
				notice.setCreatedate(rs.getString("createdate"));
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
		return notice;
	}
}
