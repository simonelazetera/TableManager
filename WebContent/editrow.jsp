<%@ include file="top.jsp" %>
<%@page import="java.sql.*"%>
<title>Table Manager - edit row</title>

</head>
<body>
	<h1 class="pad-left15">Edit Row</h1>
	<form id="editRow" action="updateRow.jsp" method="post" class="pad-left15">
<%
	String idEdit = request.getParameter("idEdit");
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	
	List<String> columns;
	List<String> valueByPKey;
	
	TableExecute tableExecute = new TableExecute(tableName);
	tableExecute.getConnection();

	try{	
		String pkey = "";
	    pkey = tableExecute.getPrimaryKey();	    
		columns = tableExecute.getColumns();
		valueByPKey = tableExecute.getValueByPKey(idEdit); 
		
		for(int i = 0; i < columns.size(); i++) {
			if(!columns.get(i).equals(pkey)) {
%>		
		<%=columns.get(i) %>: <input type="text" name="<%=columns.get(i) %>" value="<%=(valueByPKey.get(i) == null ? " " : valueByPKey.get(i)) %>"/><br><br>
<%
			}
		}
	   
	    
	}catch (Exception e) {
		e.printStackTrace();
	}
	
	tableExecute.closeConnection();
%>
		<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		<input type="hidden" name="tableName" value="<%=tableName %>" />
		<input type="submit" value="Update row"/>	
	</form>
	
	<div class="col-xs-6 top20">
		<form action="view.jsp" method="POST">
			<input id="tableName" name="tableName" value="<%=tableName %>" class="hidden"/>
			<input type="submit" value="Go back to the table" />
		</form>
	</div>
</body>
</html>
