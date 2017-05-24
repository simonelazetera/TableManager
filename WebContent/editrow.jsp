<%@ include file="top.jsp" %>
<title>Table Manager - edit row</title>

</head>
<body>
	<h1 class="pad-left15">Edit Row</h1>
	<form id="editRow" action="updateRow.jsp" method="post" class="pad-left15">
<%
	String idEdit = request.getParameter("idEdit");
	request.getSession();
	String tableName = (String) session.getAttribute("TableName");
	TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");
	
	List<String> columns;
	List<String> valueByPKey;
	List<String> typeColumns;
	
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
	
%>
		<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		<input type="submit" value="Update row"/>	
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
		$("#editRow").validate({
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