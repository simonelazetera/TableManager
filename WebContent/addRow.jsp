<%@ include file="top.jsp" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<title>Table Manager - add row</title>

</head>
<body>
	<h1 class="pad-left15">Add Row</h1>
	<form id="editRow" action="add.jsp" method="post" class="pad-left15">
<%
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	
	List<String> columns;
	
	TableExecute tableExecute = new TableExecute(tableName);
	tableExecute.getConnection();

	try{	
		String pkey = "";
	    pkey = tableExecute.getPrimaryKey();	    
		columns = tableExecute.getColumns(); 
		
		for(int i = 0; i < columns.size(); i++) {
%>		
		<%=columns.get(i) %>: <input type="text" name="<%=columns.get(i) %>" /><br><br>
<%
		}
	   
	    
	}catch (Exception e) {
		e.printStackTrace();
	}
	
	tableExecute.closeConnection();
%>
		<input type="hidden" name="tableName" value="<%=tableName %>" />
		<input type="submit" value="Add row"/>	
	</form>
	
	<div class="col-xs-6 top20">
		<form action="view.jsp" method="POST">
			<input type="submit" value="Go back to the table" />
		</form>
	</div>
</body>
</html>