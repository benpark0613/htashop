package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.shop.vo.Customer;

import utils.ConnectionUtil;

public class CustomerDao {
	
	/**
	 * 지정된 아이디에 해당하는 사용자 정보를 반환한다.
	 * @param customerId 사용자 아이디
	 * @return 사용자 정보
	 * @throws SQLException
	 */
	public Customer getCustomerById(String customerId) throws SQLException {
		String sql = "select CUSTOMER_NO, CUSTOMER_ID, CUSTOMER_PASSWORD, CUSTOMER_EMAIL, CUSTOMER_NAME, "
		        + "CUSTOMER_BIRTHDAY, CUSTOMER_TEL, CUSTOMER_GENDER, CUSTOMER_ADDRESS, CUSTOMER_CREATED_DATE, "
		        + "CUSTOMER_POINT, CUSTOMER_IN_OUT, CUSTOMER_GRADE "
		        + "from SHOP_CUSTOMER "
		        + "where CUSTOMER_ID = ? ";
		
		Customer customer = null;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, customerId);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			customer = new Customer();
			customer.setCustomerNo(rs.getInt("CUSTOMER_NO"));
			customer.setCustomerId(rs.getString("CUSTOMER_ID"));
			customer.setCustomerPassword(rs.getString("CUSTOMER_PASSWORD"));
			customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
			customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
			customer.setCustomerBirthday(rs.getDate("CUSTOMER_BIRTHDAY"));
			customer.setCustomerTel(rs.getString("CUSTOMER_TEL"));
			customer.setCustomerGender(rs.getString("CUSTOMER_GENDER"));
			customer.setCustomerAddress(rs.getString("CUSTOMER_ADDRESS"));
			customer.setCustomerCreatedDate(rs.getDate("CUSTOMER_CREATED_DATE"));
			customer.setCustomerPoint(rs.getInt("CUSTOMER_POINT"));
			customer.setCustomerInOut(rs.getBoolean("CUSTOMER_IN_OUT"));
			customer.setCustomerGrade(rs.getString("CUSTOMER_GRADE"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return customer;
	}
	
	
	/**
	 * 지정된 이메일에 해당하는 사용자 정보를 반환한다.
	 * @param customerEmail 사용자 이메일
	 * @return 사용자 정보
	 * @throws SQLException
	 */
	public Customer getCustomerByEmail(String customerEmail) throws SQLException {
		String sql = "select CUSTOMER_NO, CUSTOMER_ID, CUSTOMER_PASSWORD, CUSTOMER_EMAIL, CUSTOMER_NAME, "
		        + "CUSTOMER_BIRTHDAY, CUSTOMER_TEL, CUSTOMER_GENDER, CUSTOMER_ADDRESS, CUSTOMER_CREATED_DATE, "
		        + "CUSTOMER_POINT, CUSTOMER_IN_OUT, CUSTOMER_GRADE "
		        + "from SHOP_CUSTOMER "
		        + "where CUSTOMER_EMAIL = ? ";
		
		Customer customer = null;
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, customerEmail);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			customer = new Customer();
			customer.setCustomerNo(rs.getInt("CUSTOMER_NO"));
			customer.setCustomerId(rs.getString("CUSTOMER_ID"));
			customer.setCustomerPassword(rs.getString("CUSTOMER_PASSWORD"));
			customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
			customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
			customer.setCustomerBirthday(rs.getDate("CUSTOMER_BIRTHDAY"));
			customer.setCustomerTel(rs.getString("CUSTOMER_TEL"));
			customer.setCustomerGender(rs.getString("CUSTOMER_GENDER"));
			customer.setCustomerAddress(rs.getString("CUSTOMER_ADDRESS"));
			customer.setCustomerCreatedDate(rs.getDate("CUSTOMER_CREATED_DATE"));
			customer.setCustomerPoint(rs.getInt("CUSTOMER_POINT"));
			customer.setCustomerInOut(rs.getBoolean("CUSTOMER_IN_OUT"));
			customer.setCustomerGrade(rs.getString("CUSTOMER_GRADE"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return customer;
	}
	

}
