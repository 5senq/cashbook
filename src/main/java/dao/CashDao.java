package dao;


import vo.*;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class CashDao {
	// cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName"
					+" FROM cash c"
					+" INNER JOIN category ct"
					+" ON c.category_no = ct.category_no"
					+" WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? AND c.member_id =?"
					+" ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		stmt.setInt(3, date);
		stmt.setString(4, memberId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(int year, int month, String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName"
					+" FROM cash c"
					+" INNER JOIN category ct"
					+" ON c.category_no = ct.category_no"
					+" WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND c.member_id = ?"
					+" ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		stmt.setString(3, memberId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// deleteCashAction.jsp
	public int deleteCashListByDate(int cashNo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM cash WHERE cash_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("삭제 성공");
		} else {
			System.out.println("삭제 실패");
		}
		
		return row;
	}
	
	// updateCash.jsp
	public int updateCashListByDate(int cashNo, int categoryNo, String cashDate, long cashPrice, String cashMemo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE cash SET category_no = ?, cash_date = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		stmt.setString(2, cashDate);
		stmt.setLong(3, cashPrice);
		stmt.setString(4, cashMemo);
		stmt.setInt(5, cashNo);
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
		
		return row;
	}
	
	// 
	public Cash selectUpdateCashData(int cashNo) throws Exception {
		Cash cash = new Cash();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_date cashDate, cash_price cashPrice, cash_memo cashMemo, updatedate FROM cash WHERE cash_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			cash.setCashNo(rs.getInt("cashNo"));
			cash.setCategoryNo(rs.getInt("categoryNo"));
			cash.setCashDate(rs.getString("cashDate"));
			cash.setCashPrice(rs.getLong("cashPrice"));
			cash.setCashMemo(rs.getString("cashMemo"));
			cash.setUpdatedate(rs.getString("updatedate"));
		}
		
		return cash;
	}
	
	// insertCash.jsp
	public int insertCashListByDate(Cash cash) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		
		row = stmt.executeUpdate();
		if(row == 0) {
			System.out.println("입력 실패");
		} else {
			System.out.println("입력 성공");
		}
		
		stmt.close();
		conn.close();
		
		return row;
	}
}
