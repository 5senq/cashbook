package dao;

import vo.*;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class NoticeDao {
	// loginForm.jsp
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			
			list.add(n);
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	//
	public int selectNoticeCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return count;
	}
	
	public int insertNotice(Notice notice) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		
		row = stmt.executeUpdate();
		if(row == 0) {
			System.out.println("공지사항 등록 실패");
		} else {
			System.out.println("공지사항 등록 성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET notice_memo = ?, updatedate = NOW() WHERE notice_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("공지사항 수정 실패");
		} else {
			System.out.println("공지사항 수정 성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	public int deleteNotice(Notice notice) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("삭제 실패");
		} else {
			System.out.println("삭제 성공");
		}
		
		return row;
	}
	
	public Notice selectNoticeByNo(int noticeNo) throws Exception {
		Notice notice = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate, updatedate FROM notice WHERE notice_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			notice = new Notice();
			
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeMemo(rs.getString("noticeMemo"));
			notice.setUpdatedate(rs.getString("updatedate"));
			notice.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return notice;
	}
}
