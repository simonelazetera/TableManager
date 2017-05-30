<%@ include file="top.jsp" %>
<title>Table Manager - add row</title>

</head>
<body>
	<h1 class="pad-left15">Add Row</h1>
	<form id="addRow" action="add.jsp" method="post" class="pad-left15">
<%
	String dbUrl = getServletContext().getInitParameter("dbUrl");
	String user = getServletContext().getInitParameter("user");
	String pass = getServletContext().getInitParameter("pass");
	request.getSession();
	String tableName = (String) session.getAttribute("TableName");
	TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");
	
	List<String> columns;
	List<String> typeColumns;
	List<Integer> sizeColumns;
	List<Integer> columnsIsNullable;
	
	tableExecute.getConnection(dbUrl,user,pass);
	
	
	try{	    
		columns = tableExecute.getColumns(); 
		
		for(int i = 0; i < columns.size(); i++) {
%>		
		<%=columns.get(i) %>: <input type="text" name="<%=columns.get(i) %>" /><br><br>
<%
		}
	   
	    
	}catch (Exception e) {
		e.printStackTrace();
	}
	
%>
		<input type="submit" value="Add row"/>	
	</form>
	
	<div class="col-xs-6 top20">
		<form action="view.jsp" method="POST">
			<input type="submit" value="Go back to the table" />
		</form>
	</div>
	
	
<%@ include file="js.jsp" %>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	jQuery.validator.addMethod("accept", function(value, element, param) {
		  return value.match(new RegExp("." + param + "$"));
	});
	$("#addRow").validate({
	    rules: {
	   	<%
	   	columns = tableExecute.getColumns();
	   	typeColumns = tableExecute.getType(tableName);
	   	sizeColumns = tableExecute.getColumnsSize(tableName);
	   	columnsIsNullable = tableExecute.isColumnsNullable(tableName);
		   	for(int i = 0; i < columns.size(); i++) { %>
		   		<%=columns.get(i) %>: {
	   			<%if (columnsIsNullable.get(i) == 0){%>
	   				required: true,
		   		<%} else { %> 
		   			required: false,
		   		<%} %>	
		   		<%if (typeColumns.get(i).equals("INT") || typeColumns.get(i).equals("FLOAT") || typeColumns.get(i).equals("SMALLINT")){%>
		   		    number: true
		   		<%} else { %> 
		   			accept: "[a-zA-Z]+"
		   		<%} %>
		   		},
   			<%} %>
	    },
	    messages: {
	    	<%
	    	columns = tableExecute.getColumns();
	    	typeColumns = tableExecute.getType(tableName);
		   	sizeColumns = tableExecute.getColumnsSize(tableName);
		   	columnsIsNullable = tableExecute.isColumnsNullable(tableName);
	    	for(int i = 0; i < columns.size(); i++) { %>
    			<%=columns.get(i) %>: {
					<%if (typeColumns.get(i).equals("INT") || typeColumns.get(i).equals("FLOAT") || typeColumns.get(i).equals("SMALLINT")){%>
    				number: "only numbers",
				<%} else { %>
					accept: "only character",
				<%} %>
				},
    		<%} %>
	    },
	    submitHandler: function(form) {
	      form.submit();
	    }
	  });
	});
</script>
<%tableExecute.closeConnection(); %>
</body>
</html>
