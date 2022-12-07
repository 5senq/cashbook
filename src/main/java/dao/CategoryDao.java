package dao;

import vo.*;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class CategoryDao {
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind FROM category ORDER BY category_kind ASC";
		
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<Category>();
			
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setCategoryKind(rs.getString("categoryKind"));
				
				list.add(category);
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
	
	public ArrayList<Category> selectCategoryListByAdmin() {
		ArrayList<Category> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind, updatedate, createdate FROM category ORDER BY category_kind ASC";
			
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			list = new ArrayList<Category>();
			
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setUpdatedate(rs.getString("updatedate"));
				category.setCreatedate(rs.getString("createdate"));
				
				list.add(category);
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
	
	public int selectCategoryCount() {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT COUNT(*) cnt FROM category";

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
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO category(category_name, category_kind, updatedate, createdate) VALUES(?, ?, NOW(), NOW())";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setString(2, category.getCategoryKind());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("실패");
			} else {
				System.out.println("성공");
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
	
	public int deleteCategory(int categoryNo) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM category WHERE category_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("실패");
			} else {
				System.out.println("성공");
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
	
	// admin -> updateCategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
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
		return category;
	}
	
	// admin -> updateCategoryAction.jsp
	public int updateCategory(Category category) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE category SET category_name = ?, updatedate = NOW() WHERE category_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setInt(2, category.getCategoryNo());
			
			row = stmt.executeUpdate();
			
			if(row == 0) {
				System.out.println("실패");
			} else {
				System.out.println("성공");
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
