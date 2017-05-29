package packageTableManager;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;

import com.mysql.jdbc.ResultSetMetaData;
import com.mysql.jdbc.Statement;

public class TableExecute extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static List<String> columns;
	private static List<String> valueByPKey;
	private static List<Integer> sizeColumns;
	private static List<Integer> columnsIsNullable;
	private String tableName;
	private String pKey;
	private static List<String> type;
	
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
	
	public static int count;
	public static int numKey;
	public static int rowsAffected;
		
	public static File fileName = new File("src/properties.properties");
	public static Properties props = new Properties();
	
	
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
	
	/*public List<String> getValue() throws SQLException{
		value = new ArrayList<String>();
		String sql = "select * from " + tableName;
		myRs = myStmt.executeQuery(sql);
		
		while (myRs.next()) {
			for (int i = 1; i <= columns.size();  i++){
				value.add(myRs.getString(i));
			}
		}
		return value;
	}*/
	
	public List<List<String>> getAllRows() throws SQLException{
		List<List<String>> row = new ArrayList<List<String>>();
		List<String> temp;
		String sql = "select * from " + tableName;
		myRs = myStmt.executeQuery(sql);
		
		while (myRs.next()) {
				temp = new ArrayList<String>();
			for (int i=1;i<=columns.size();i++){
				temp.add(myRs.getString(i));
			}
			row.add(temp);
		}
		return row;
	}
	
	public int numRow() throws SQLException{
		count = 0;
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
	
	public int updateRow(Enumeration<String> enu, String idEdit, ServletRequest request) throws SQLException{
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
		rowsAffected = ps.executeUpdate();
		return rowsAffected;
	}
	
	public int addRow(Enumeration<String> enu, ServletRequest request) throws SQLException{
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
		rowsAffected = ps.executeUpdate();
		return rowsAffected;
	}
	
	
	public int numPrimaryKey() throws SQLException{
		numKey=0;
		meta = myConn.getMetaData();
		myRs = meta.getPrimaryKeys(null, null, tableName);
		while (myRs.next()){
			numKey++;
		}
		return numKey;
	}
	
	public void closeConnection() throws SQLException{
		if(myRs!=null){
			myRs.close();
		}
		if(myStmt!=null){
			myStmt.close();
		}
		if(myConn!=null){
			myConn.close();
		}
	}
	
	/*public void writeProperties(List<String> propcolumns, List<String> propvalue) throws FileNotFoundException, IOException{
		Properties props = new Properties();
		int index = 0;
		
		if(fileName.exists()){
			props.load(new FileInputStream("C:/Users/slazeter/workspace/TableManager/"+fileName));
		}
		
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
	}*/
	
	/*public void writeProperties() throws FileNotFoundException, IOException{		
		if(fileName.exists()){
			props.load(new FileInputStream(fileName));
		}

		boolean equal = false;
		if(!UtilsFunction.isEmpty(props.getProperty("table-list"))){
			String [] arr = props.getProperty("table-list").split(",");
			
			for(int i=0;i<arr.length;i++){
				if(arr[i].trim().equals(tableName)){
					equal = true;
					break;
				}
			}
			if(!equal){
				props.setProperty("table-list", props.getProperty("table-list")+","+tableName);
			}
		}else{
			props.setProperty("table-list", tableName);
		}
		
		OutputStream out = new FileOutputStream(fileName);
        props.store(out, "properties tables");
	}*/
	
	
	public void writeProperties(String filename) throws FileNotFoundException, IOException{
		File fileName = new File(filename);
		
		try
        {
			if (fileName.exists()) {
				props.load(new FileInputStream(filename));
			}
			
            boolean equal = false;
            if(!UtilsFunction.isEmpty(props.getProperty("table-list"))){
    			String [] arr = props.getProperty("table-list").split(",");
    			
    			for(int i=0;i<arr.length;i++){
    				if(arr[i].trim().equals(tableName)){
    					equal = true;
    					break;
    				}
    			}
    			if(!equal){
    				props.setProperty("table-list", props.getProperty("table-list")+","+tableName);
    			}
    		}else{
    			props.setProperty("table-list", tableName);
    		}
    		
    		OutputStream out = new FileOutputStream(fileName);
            props.store(out, "properties tables");
            
        }catch (Exception e) {
        	e.printStackTrace();
		}
	}
	
	public List<String> getType(String tableName) throws FileNotFoundException, IOException, SQLException{
		type = new ArrayList<String>();
		meta = myConn.getMetaData();
		res = meta.getColumns(null, null, tableName, null);
		
		while(res.next()){
			type.add(res.getString("TYPE_NAME"));
		}
		return type;
	}
	
	public List<String> readTable(String filename) throws FileNotFoundException, IOException{
		String [] temp = {};
		List<String> listTable = new ArrayList<String>();
		try{
			props.load(new FileInputStream(filename));
			if(!props.getProperty("table-list").equals("")){
				temp = props.getProperty("table-list").split(",");
			}
			for(int i = 0; i < temp.length; i++){
		       	listTable.add(temp[i].trim());
		    }
		}catch (Exception e) {
			e.printStackTrace();
		}
		return listTable;
	}
	
	
	public List<Integer> getColumnsSize(String tableName) throws FileNotFoundException, IOException, SQLException{
		sizeColumns = new ArrayList<Integer>();
		meta = myConn.getMetaData();
		res = meta.getColumns(null, null, tableName, null);
		
		while(res.next()){
			sizeColumns.add(res.getInt("COLUMN_SIZE"));
		}
		return sizeColumns;
	}
	
	public List<Integer> isColumnsNullable(String tableName) throws FileNotFoundException, IOException, SQLException{
		columnsIsNullable = new ArrayList<Integer>();
		meta = myConn.getMetaData();
		res = meta.getColumns(null, null, tableName, null);
		
		while(res.next()){
			columnsIsNullable.add(res.getInt("NULLABLE"));
		}
		return columnsIsNullable;
	}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException, FileNotFoundException, IOException {
		TableExecute ut = new TableExecute("e");
				
		//ut.getConnection();
		//ut.getColumns();
		
		//List<List<String>> w = new ArrayList<List<String>>();
		//w=ut.getAllRows();
		//System.out.println(w);
		
		//System.out.println(ut.numPrimaryKey());
		
		//System.out.println(ut.readTable());
		
		//System.out.println(fileName.exists());
		
		ut.writeProperties("C:/Users/slazeter/workspace/TableManager/properties.properties");
				
	}
	
	
}

