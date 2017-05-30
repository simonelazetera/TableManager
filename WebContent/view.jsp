<%@ include file="top.jsp" %>
<title>Table Manager - view table</title>
</head>
<body>

<%
	String dbUrl = getServletContext().getInitParameter("dbUrl");
	String user = getServletContext().getInitParameter("user");
	String pass = getServletContext().getInitParameter("pass");
	List<String> columns;

	request.getSession();
	String tableName = (String) session.getAttribute("TableName");
	TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");
	
	if (UtilsFunction.isEmpty(tableName)){	
%>	
		<div class="col-xs-10 top15">
			<h1>
				You haven't selected any tables
				you will be redirected to the selection page
			</h1>
		</div>
		<div class="col-xs-2 top15">
			<img src="images/countdown.gif" class="img-responsive">
		</div>
<%
		response.setHeader("REFRESH","5;URL=default.jsp");
	}else{
		
		//TableExecute tableExecute = new TableExecute(tableName);
		
		tableExecute.getConnection(dbUrl,user,pass);
		columns = tableExecute.getColumns();
%>
<div class="col-xs-3 col-sm-2 top20">
	<form action="addRow.jsp" method="POST">
		<input type="submit" value="Add row" />
	</form>
</div>
<div class="col-xs-6 top20">
	<form action="default.jsp" method="POST">
		<input type="submit" value="Go back to the home page" />
	</form>
</div>
<div class="col-xs-12 top15">
	<table>
		<tr>
		<% for(int i = 0; i < columns.size(); i++) {%>
			<th><%=columns.get(i) %></th>
		<% } %>
			<th>editable column</th>
		</tr>
		
		
		<%for (List<String> row:tableExecute.getAllRows()) { %>
		<tr>
			<%for (String col:row) { %>
				<td><%=col%></td>
			<% } %>
				<td>
					<form action="editrow.jsp" method="POST">
						<% if(tableExecute.numPrimaryKey() == 1) { %>
							<input id="idEdit" name="idEdit" class="hidden" value="<%=row.get(0) %>" />
						<% }else{
								for(int index=0;index<tableExecute.numPrimaryKey();index++){ 
						%>
									<input id="idEdit<%=index %>" name="idEdit<%=index %>" class="hidden" value="" />
						<%		} 
							} 
						%>
						<input id="tableName" name=tableName class="hidden" value="<%=tableName %>" />
						<input type="submit" value="edit" class="editTable">
					</form>
				</td>
		</tr>
		<% } %>
	</table>
</div>

<%
	tableExecute.closeConnection();

	}
%>

<%@ include file="js.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
</script>
</body>
</html>
