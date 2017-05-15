<%@ include file="top.jsp" %>
<title>Table Manager - view table</title>
</head>
<body>

<%
	List<String> columns;
	List<String> value;

	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	
	if (tableName.equals("")){	
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
		
		TableExecute tableExecute = new TableExecute(tableName);
		
		tableExecute.getConnection();
		columns = tableExecute.getColumns();
		value = tableExecute.getValue();
%>
<div class="col-xs-6 top20">
	<form action="addRow.jsp" method="POST">
		<input type="hidden" name="tableName" value="<%=tableName %>" />
		<input type="submit" value="Add row" />
	</form>
</div>

<div class="col-xs-12 top15">
	<table>
		<tr>
		<% for(int i = 0; i < columns.size(); i++) {
		%>
			<th><%=columns.get(i) %></th>
		<% } %>
			<th>editable column</th>
		</tr>
		
		<%for (int i = 1; i <= tableExecute.numRow(); i++){ %>
		<tr>
			<%for (int j = (columns.size()*i)-columns.size(); j < columns.size()*i; j++){ %>
				<td><%=value.get(j) %></td>
			<% } %>
				<td>
					<form action="editrow.jsp" method="POST">
						<input type="text" id="idEdit" name="idEdit" class="hidden" value="<%=value.get((columns.size()*i)-columns.size()) %>" />
						<input type="hidden" name="tableName" value="<%=tableName %>">
						<input type="submit" value="edit" class="editTable">
					</form>
				</td>
		</tr>
		<% } %>
	</table>
</div>

<% 
	}
%>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
</script>
</body>
</html>