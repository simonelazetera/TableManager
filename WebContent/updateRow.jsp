<%@ include file="top.jsp" %>
<title>Table Manager - upgrade done</title>

</head>
<body>
<%
PreparedStatement ps = null;
String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
String idEdit = request.getParameter("idEdit");
String pkey = "";

try{
	
	TableExecute tableExecute = new TableExecute(tableName);
	tableExecute.getConnection();
	
	DatabaseMetaData meta = myConn.getMetaData();
	ResultSet res = meta.getColumns(null, null, tableName, null);
	
	ResultSet rs = meta.getPrimaryKeys(null, null, tableName);
    while (rs.next()) {
      pkey = rs.getString("COLUMN_NAME");
    }
	
    int i = 0;
	String sql = "UPDATE " + tableName + " SET ";
	Enumeration<String> enu = request.getParameterNames();

    while (enu.hasMoreElements()) {
        String parameterName = (String) enu.nextElement();
        String parameterValue = request.getParameter(parameterName);
        
        if (parameterValue != idEdit && parameterValue != tableName){
	        if(i == 0){
	        	sql += parameterName + " = " + (parameterValue == "" ? null : "'" + parameterValue + "'");
			}else{
				sql +=", " + parameterName + " = " + (parameterValue == "" ? null : "'" + parameterValue + "'");	
			}
			i++;
			}
    	}
    
	sql +=  " WHERE " + pkey + " = " + "'" + idEdit + "'";
	System.out.println(sql);
	ps = myConn.prepareStatement(sql);
	ps.executeUpdate();

}catch (Exception e) {
	e.printStackTrace();
}
%>

	<h1 class="pad-left15">Upgrade done</h1>
	
	<div class="col-xs-6 top20">
		<form action="view.jsp" method="POST">
			<input type="submit" value="Go back to the table" />
		</form>
	</div>

</body>
</html>