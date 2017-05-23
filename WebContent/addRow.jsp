<%@ include file="top.jsp" %>
<title>Table Manager - add row</title>

</head>
<body>
	<h1 class="pad-left15">Add Row</h1>
	<form id="addRow" action="add.jsp" method="post" class="pad-left15">
<%
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	
	List<String> columns;
	List<String> typeColumns;
	
	TableExecute tableExecute = new TableExecute(tableName);
	tableExecute.getConnection();
	
	
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
		<input type="hidden" name="tableName" value="<%=tableName %>" />
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
			   	for(int i = 0; i < columns.size(); i++) {
			   		if (typeColumns.get(i).equals("INT")){%>
				   		<%=columns.get(i) %>: {
			   			    number: true,
			   			},
			   		<%} else { %>
			   			<%=columns.get(i) %>: { accept: "[a-zA-Z]+" },
					<%}
				}%>
		    },
		    messages: {
		    	<%
		    	columns = tableExecute.getColumns();
		    	typeColumns = tableExecute.getType(tableName);
		    	for(int i = 0; i < columns.size(); i++) {
		    		if (typeColumns.get(i).equals("INT")){%>
		    			<%=columns.get(i) %>: "only numbers",
					<%} else { %>
						<%=columns.get(i) %>: "only character",
					<%}
	    		}%>
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