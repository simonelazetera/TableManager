<%@ include file="top.jsp" %>
<title>Table Manager - table configuration</title>
</head>
<body>

<%
	List<String> columns = null;
	List<String> type = null;
	
	request.getSession();
	String tableName = (String) session.getAttribute("TableName");
	TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");
	
	if(!UtilsFunction.isEmpty(tableName)){
		tableExecute.getConnection();
		columns = tableExecute.getColumns();
		type = tableExecute.getType(tableName);
	}
%>

<div class="col-xs-6 top15">
	<form id="form-nameTable" method="POST">
		<input type="text" id="tableName" name="tableName" value="<%=tableName %>" class="width-auto"/>
		<div class="left15 width-auto button-tableName" id="button-tableName">
			<button type="submit" class="width-full" onclick="getTable()">Apply</button>
		</div>
	</form>
</div>

<% if(!UtilsFunction.isEmpty(tableName)){ %>
<div class="col-xs-12 top20">
<% for (int i=0;i<columns.size();i++){ %>
	<p><%=i+1 %>° column: <%=columns.get(i) %>, type: <%=type.get(i) %></p>
<% } %>

<button type="submit" onclick="window.location.href='default.jsp'">Go back</button>
</div>

<% }
	if(!UtilsFunction.isEmpty(tableName)){
		tableExecute.closeConnection();
	}
%>

<%@ include file="js.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function getTable(){
		$("#button-tableName").html("<div class=\"left15 load\"><img src=\"images/load.gif\" class=\"img-responsive\"/></div>");
		setTimeout(function(){$("#form-nameTable").submit();}, 2000);
		<% tableExecute.writeProperties(); %>
	}
</script>
</body>
</html>
