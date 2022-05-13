package com.globalin.connect;

import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

public class JdbcTest {
	
	//이 메소드는 테스트용 메소드에요
	@Test
	public void testConnection() {
		
	 try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin@local:1521:XE", "system", "1234");
		assertNotNull(conn);
	} catch (ClassNotFoundException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	
	}
}
