<%@ include file="conn.jsp" %>
<%@ include file="top.jsp" %>

<title>Table Manager - edit row</title>

</head>
<body>
	<h1 class="pad-left15">Edit Row</h1>
	<form id="editRow" action="updateRow.jsp" method="post" class="pad-left15">
<%
	String idEdit = request.getParameter("idEdit");
	String tableName = tableManager.isNull(request.getParameter("tableName"), "city");

	try{

		DatabaseMetaData meta = myConn.getMetaData();
		
		String pkey = "";
		String columName = "";
		
		ResultSet rs = meta.getPrimaryKeys(null, null, tableName);
	    while (rs.next()) {
	      pkey = rs.getString("COLUMN_NAME");
	    }
		

	    String select = "SELECT * FROM " + tableName + " WHERE " + pkey + " = " + "'" + idEdit + "'";

	    ResultSet resultSet = myStmt.executeQuery(select);

	   
	    ResultSet res = meta.getColumns(null, null, tableName, null);
	    
	    while (resultSet.next()){
			while (res.next()) {
				columName=res.getString("COLUMN_NAME");
				if(!columName.equals(pkey)) {
%>		
		<%=res.getString("COLUMN_NAME") %>: <input type="text" name="<%=res.getString("COLUMN_NAME")  %>" value="<%=(resultSet.getString(res.getString("COLUMN_NAME")) == null ? " " : resultSet.getString(res.getString("COLUMN_NAME"))) %>" /><br><br>
<%
				}
			}
		}
	   
	    
	}catch (Exception e) {
		e.printStackTrace();
	}
%>
		<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		<input type="hidden" name="tableName" value="<%=tableName %>" />
		<input type="submit" value="Update row"/>	
	</form>
</body>
</html>