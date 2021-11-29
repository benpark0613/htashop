package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Customer;
import com.shop.vo.Review;
import com.shop.vo.Review;
public class ReviewDao {
	
	public List<Review> getAllReviewByCustomerNo(int customerNo)throws SQLException{
		
		String sql = "select REVIEW_NO, REVIEW_TITLE, REVIEW_VIEW_COUNT, REVIEW_CREATED_DATE "
				+ "from SHOP_REVIEW "
				+ "where CUSTOMER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, customerNo);
		ResultSet rs = pstmt.executeQuery();
		List<Review> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			Review review = new Review();
			review.setReviewNo(rs.getInt("REVIEW_NO"));
			review.setTitle(rs.getString("REVIEW_TITLE"));
			review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			review.setViewCount(rs.getInt("REVIEW_VIEW_COUNT"));
			
			reviewList.add(review);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		
		return reviewList;
	}
	
	
}
