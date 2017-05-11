package packageTableManager;

import java.sql.*;
import java.util.*;

import com.mysql.jdbc.ResultSetMetaData;
import com.mysql.jdbc.Statement;

public class TableExecute {

	private static List<String> columns;
	private static List<String> value;
	private String tableName;
	
	private Connection myConn = null;
	private Statement myStmt = null;
	private ResultSet myRs = null ;
	private ResultSetMetaData data = null;
	
	private String dbUrl = "jdbc:mysql://localhost:3306/world";
	private String user = "root";
	private String pass = "root";
	
	public static int count = 0;
	
	
	public TableExecute(String tableName) {
		this.tableName = tableName;
	}
	
	public void getConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		myConn = DriverManager.getConnection(dbUrl, user, pass);
		myStmt = (Statement) myConn.createStatement();
	}
	
	
	public int numColumns() throws SQLException{
		String sql = "select * from " + tableName + " limit 1";
		myRs = myStmt.executeQuery(sql);
		data = (ResultSetMetaData) myRs.getMetaData();
		int numColonne = data.getColumnCount();
		return numColonne;
	}
	
	public List<String> getColumns() throws SQLException{
		columns = new ArrayList<String>();
		String sql = "select * from " + tableName + " limit 1";
		myRs = myStmt.executeQuery(sql);
		data = (ResultSetMetaData) myRs.getMetaData();
		
		for (int i=1;i<=numColumns();i++){
			columns.add(data.getColumnName(i));
		}
		return columns;
	}
	
	public List<String> getValue() throws SQLException{
		value = new ArrayList<String>();
		String sql = "select * from " + tableName;
		myRs = myStmt.executeQuery(sql);
		
		while (myRs.next()) {
			for (int i = 1; i <= columns.size();  i++){
				value.add(myRs.getString(i));
			}
		}
		return value;
	}
	
	public int numRow() throws SQLException{
		String sql = "select * from " + tableName;
		myRs = myStmt.executeQuery(sql);
		while (myRs.next()) {
			count++;
		}		
		return count;
	}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		TableExecute ut = new TableExecute("city");
		
		ut.getConnection();
		ut.getColumns();
		ut.getValue();
		
		System.out.println("\nlista colonne: ");
		System.out.println(columns.size());
		
		for(int i = 0; i < columns.size(); i++) {
		    System.out.println(columns.get(i));
		}
	}
	
	
}
