package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Product;


public class ProductDao {

	private static ProductDao  self = new ProductDao ();
	private ProductDao () {}
	public static ProductDao getInstance() {
		return self;
	}
	
	
	
	
	
	
	public List<Product> getProductListBySearch(String searchKeyword, String searchText) throws SQLException {
		List<Product> searchResults = new ArrayList<>();
		
		String sql = "select PRODUCT_CATEGORY, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_IS_SOLDOUT "
				+ "from shop_products ";
		if ("name".equals(searchKeyword)) {
			sql	+= "where PRODUCT_NAME like '%' || ? || '%' ";
		} else if ("price".equals(searchKeyword)) {
			sql	+= "where PRODUCT_NAME like '%' || ? || '%' ";
		} else if ("category".equals(searchKeyword)) {
			sql	+= "where PRODUCT_NAME like '%' || ? || '%' ";
		}
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, searchText);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Product product = new Product();
			product.setCategory(rs.getString("PRODUCT_CATEGORY"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setPrice(rs.getInt("PRODUCT_PRICE"));
			product.setSoldOut(rs.getBoolean("PRODUCT_IS_SOLDOUT"));
			searchResults.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return searchResults;
	}
	
	
	
	
	
	
	/**
	 * 지정된 범위에 속하는 상품리스트를 반환한다.
	 * @param begin 시작번호
	 * @param end 끝번호
	 * @return 범위에 해당하는 상품리스트
	 * @throws SQLException
	 */
	public List<Product> getProductListByRN(int begin, int end) throws SQLException {
		String sql = "select RN, PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_IMAGE "
					+ "from (select row_number() over (order by product_no) RN, "
					+ "             PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_IMAGE "
					+ "      from shop_products) "
					+ "where rn >= ? and rn <= ? ";
		
		List<Product> productList = new ArrayList<Product>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setCategory(rs.getString("PRODUCT_CATEGORY"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setPrice(rs.getInt("PRODUCT_PRICE"));
			product.setImage(rs.getString("PRODUCT_IMAGE"));
			productList.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productList;
	}
	
	
	/**
	 * shop_products테이블의 전체 레코드 갯수를 반환한다.
	 * @return 전체 레코드 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
					+ "from shop_products ";
		
		int totalProductsRecord = 0;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalProductsRecord = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalProductsRecord;
	}
	
	
	/**
	 * 지정된 상품번호에 해당하는 상품정보를 반환한다.
	 * @param no 상품번호
	 * @return 상품정보
	 * @throws SQLException
	 */
	public Product getProductDetailById(int no) throws SQLException{
		Product products = new Product();
		
		String sql = "select * from shop_products where product_no =? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			products = new Product();
			products.setNo(rs.getInt("product_no"));
			products.setName(rs.getString("product_name"));
			products.setCategory(rs.getString("product_category"));
			products.setPrice(rs.getInt("product_price"));
			products.setStock(rs.getInt("product_stock"));
			products.setSoldOut(rs.getBoolean("product_is_soldout"));
			products.setSalesRate(rs.getInt("PRODUCT_SALES_RATE"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	
	/**
	 * 모든 상품정보를 반환한다.
	 * @return 상품정보
	 * @throws SQLException
	 */
	public List<Product> getAllProducts() throws SQLException {
		List<Product> productList = new ArrayList<>();
		
		String sql = "select PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_NAME, "
				+ "PRODUCT_PRICE, PRODUCT_STOCK, PRODUCT_IS_SOLDOUT, "
				+ "PRODUCT_UPDATED_DATE, PRODUCT_SALES_RATE, PRODUCT_IMAGE "
	            + "from shop_products ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Product product = new Product();
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setCategory(rs.getString("PRODUCT_CATEGORY"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setPrice(rs.getInt("PRODUCT_PRICE"));
			product.setStock(rs.getInt("PRODUCT_STOCK"));
			product.setSoldOut(rs.getBoolean("PRODUCT_IS_SOLDOUT"));
			product.setUpdatedDate(rs.getDate("PRODUCT_UPDATED_DATE"));
			product.setSalesRate(rs.getInt("PRODUCT_SALES_RATE"));
			product.setImage(rs.getString("PRODUCT_IMAGE"));
			
			productList.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productList;
	}
}
