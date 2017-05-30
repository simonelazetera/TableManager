<%@ include file="top.jsp" %>
<title>Table Manager - table configuration</title>
</head>
<body>

<%
	String dbUrl = getServletContext().getInitParameter("dbUrl");
	String user = getServletContext().getInitParameter("user");
	String pass = getServletContext().getInitParameter("pass");
	List<String> columns = null;
	List<String> type = null;
	
	String location = getServletContext().getInitParameter("configuration");
	
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	TableExecute tableExecute = new TableExecute(tableName);
	
	if(!UtilsFunction.isEmpty(tableName)){
		tableExecute.getConnection(dbUrl,user,pass);
		columns = tableExecute.getColumns();
		type = tableExecute.getType(tableName);
		tableExecute.writeProperties(location);
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
</div>

<% }
	if(!UtilsFunction.isEmpty(tableName)){
		tableExecute.closeConnection();
	}
%>

<div class="col-xs-12 top15">
<button type="submit" onclick="window.location.href='default.jsp'">Go back</button>
</div>

<%@ include file="js.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function getTable(){
		$("#button-tableName").html("<div class=\"left15 load\"><img src=\"images/load.gif\" class=\"img-responsive\"/></div>");
		if($("#tableName").val() != ""){
			setTimeout(function(){$("#form-nameTable").submit();}, 2000);
		}
	}
</script>
</body>
</html>
