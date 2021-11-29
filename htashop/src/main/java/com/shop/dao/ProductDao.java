package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.shop.vo.Products;

import utils.ConnectionUtil;

public class ProductsDao {
	
	/**
	 * 모든 상품정보를 반환한다.
	 * @return 상품정보
	 * @throws SQLException
	 */
	public List<Products> getAllProducts() throws SQLException {
		List<Products> productList = new ArrayList<>();
		
		String sql = "select PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_NAME, "
				+ "PRODUCT_PRICE, PRODUCT_STOCK, PRODUCT_IS_SOLDOUT, "
				+ "PRODUCT_UPDATED_DATE, PRODUCT_SALES_RATE "
	            + "from shop_products ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Products product = new Products();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setCategory(rs.getString("PRODUCT_CATEGORY"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setPrice(rs.getInt("PRODUCT_PRICE"));
			product.setStock(rs.getInt("PRODUCT_STOCK"));
			product.setSoldOut(rs.getBoolean("PRODUCT_IS_SOLDOUT"));
			product.setUpdatedDate(rs.getDate("PRODUCT_UPDATED_DATE"));
			product.setSalesRate(rs.getInt("PRODUCT_SALES_RATE"));
			
			productList.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
