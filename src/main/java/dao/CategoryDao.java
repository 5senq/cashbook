package dao;

import vo.*;
import util.*;
import java.sql.*;
import java.util.*;

public class CategoryDao {
	// admin -> 카테고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> list = null; // 참조타입은 처음에 null로 받는 것이 좋다
		list = new ArrayList<Category>();
		
		String sql = "SELECT"
					+"	 category_no categoryNo"
					+"	, category_kind categoryKind"
					+"	, category_name categoryName"
					+"	, updatedate"
					+"	, createdate"
					+" FROM category";
		
		DBUtil dbUtil = new DBUtil();
		
		// db자원(jdbc api자원) 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1 - 셀렉트 절의 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate")); // DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		
		// db자원(jdbc api자원) 반납
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	// cash 입력시 <select> 목록 출력
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		// ORDER BY category_kind
		return categoryList;
	}
}
