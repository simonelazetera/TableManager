package packageTableManager;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;

import com.mysql.jdbc.ResultSetMetaData;
import com.mysql.jdbc.Statement;

public class TableExecute {

	private static List<String> columns;
	private static List<String> value;
	private static List<String> valueByPKey;
	private String tableName;
	private String pKey;
	
	private Connection myConn = null;
	private Statement myStmt = null;
	private ResultSet myRs = null ;
	private ResultSet res = null ;
	private ResultSetMetaData data = null;
	private DatabaseMetaData meta = null;
	private PreparedStatement ps = null;
	
	private String dbUrl = "jdbc:mysql://localhost:3306/world";
	private String user = "root";
	private String pass = "root";
	
	public static int count = 0;
	public static int numKey = 0;
	
	
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
	
	public String getPrimaryKey() throws SQLException{
		meta = myConn.getMetaData();
		myRs = meta.getPrimaryKeys(null, null, tableName);
	    while (myRs.next()) {
	      pKey = myRs.getString("COLUMN_NAME");
	    }
		return pKey;
	}
	
	public List<String> getValueByPKey(String idEdit) throws SQLException{
		valueByPKey = new ArrayList<String>();
		meta = myConn.getMetaData();
		res = meta.getColumns(null, null, tableName, null);
		String sql = "SELECT * FROM " + tableName + " WHERE " + getPrimaryKey() + " = '"  + idEdit + "'";
		myRs = myStmt.executeQuery(sql);
		while (myRs.next()) {
			while (res.next()){ 
				valueByPKey.add(myRs.getString(res.getString("COLUMN_NAME")));
			}
		}
		return valueByPKey;
	}
	
	public void updateRow(Enumeration<String> enu, String idEdit, ServletRequest request) throws SQLException{
	    int i = 0;
		String sql = "UPDATE " + tableName + " SET ";
		
	    while (enu.hasMoreElements()) {
	        String parameterName = (String) enu.nextElement();
	        String parameterValue = request.getParameter(parameterName);
	        
	        if (parameterValue != request.getParameter("idEdit") && parameterValue != tableName){
		        if(i == 0){
				sql += parameterName + " = " + (parameterValue == "" ? null : "'" + parameterValue + "'");
			}else{
				sql +=", " + parameterName + " = " + (parameterValue == "" ? null : "'" + parameterValue + "'");	
			}
			i++;
			}
	    	}
	    
		sql +=  " WHERE " + getPrimaryKey() + " = " + "'" + idEdit + "'";
		ps = myConn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public void addRow(Enumeration<String> enu, ServletRequest request) throws SQLException{
	    int i = 0;
		String sql = "INSERT INTO " + tableName + " VALUES (";
		
	    while (enu.hasMoreElements()) {
	        String parameterName = (String) enu.nextElement();
	        String parameterValue = request.getParameter(parameterName);
	        
	        if (parameterValue != tableName){
			if(i == 0){
		        	sql += (parameterValue == "" ? null : "'" + parameterValue + "'");
			}else{
				sql +=", " + (parameterValue == "" ? null : "'" + parameterValue + "'");	
			}
			i++;
			}
	    	}
	    
	    sql += ")";
		ps = myConn.prepareStatement(sql);
		ps.executeUpdate();
	}
	
	public int numPrimaryKey() throws SQLException{
		meta = myConn.getMetaData();
		myRs = meta.getPrimaryKeys(null, null, tableName);
		while (myRs.next()){
			numKey++;
		}
		return numKey;
	}
	
	public void closeConnection() throws SQLException{
		myRs.close();
		myStmt.close();
		myConn.close();
	}
	
	public void writeProperties(List<String> propcolumns, List<String> propvalue) throws FileNotFoundException, IOException {
		Properties props = new Properties();
		int index = 0;
		props.load(new FileInputStream("C:/Users/slazeter/workspace/TableManager/"+fileName));
		
		if(!UtilsFunction.isEmpty(props.getProperty("table-list"))){
			String [] arr = props.getProperty("table-list").split(",");
			
			for(String val:arr){
				if(!val.equals(tableName)){
					props.setProperty("table-list", props.getProperty("table-list")+","+tableName);
				}
			}
		}else{
			props.setProperty("table-list", tableName);
		}
		
		for(String valore:propcolumns){
        	props.setProperty("table-"+tableName+"-columns",
        					((index == 0) ? valore : props.getProperty("table-"+tableName+"-columns")+","+valore));
       		props.setProperty("table-"+tableName+"-"+propcolumns.get(index), propvalue.get(index));
        	index++;
        }
		
		OutputStream out = new FileOutputStream("C:/Users/slazeter/workspace/TableManager/"+fileName);
        props.store(out, "properties tables");
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
