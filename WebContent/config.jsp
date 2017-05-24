<%@ include file="top.jsp" %>
<title>Table Manager - table configuration</title>
</head>
<body>

<%
	List<String> columns = null;
	List<String> type = null;
	
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	
	TableExecute tableExecute = new TableExecute(tableName);
	
	if(!UtilsFunction.isEmpty(tableName)){
		tableExecute.getConnection();
		columns = tableExecute.getColumns();
		type = tableExecute.getType(tableName);
	}
%>

<div class="col-xs-6 top15">
	<form id="form-nameTable" method="POST">
		<div class="left15 width-auto button-tableName" id="button-tableName">
			<button type="submit" class="width-full" onclick="getTable()">apply</button>
		</div>
	</form>
</div>

<% if(!UtilsFunction.isEmpty(tableName)){ %>
<div class="col-xs-12 top20">
<form method="post" action="write-properties.jsp">
<% for (int i=0;i<columns.size();i++){ %>
	<p><%=i+1 %>° column: <%=columns.get(i) %>, type: <%=type.get(i) %></p>
<% } %>

<input type="submit" value="Go back"/>
</form>
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
	}
</script>
</body>
</html>
