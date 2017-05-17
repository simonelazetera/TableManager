<%@ include file="top.jsp" %>
<title>Table Manager - table configuration</title>
</head>
<body>

<%
	List<String> columns = null;
	
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	
	TableExecute tableExecute = new TableExecute(tableName);
	
	if(!UtilsFunction.isEmpty(tableName)){
		tableExecute.getConnection();
		columns = tableExecute.getColumns();
	}
%>

<div class="col-xs-6 top15">
	<form id="form-nameTable" method="POST">
		<input type="text" id="tableName" name="tableName" value="<%=tableName %>" class="width-auto"/>
		<div class="left15 width-auto button-tableName" id="button-tableName">
			<button type="submit" class="width-full" onclick="getTable()">apply</button>
		</div>
	</form>
</div>

<% if(!tableName.equals("")){ %>
<div class="col-xs-12 top20">
<% for (int i=0;i<columns.size();i++){ %>
	<p><%=i+1 %>° column: <%=columns.get(i) %>
		<select class="left15">
			<option>test</option>
		</select>
	</p>
<% } %>
</div>


<div class="col-xs-6 top20">
	<form action="default.jsp" method="POST">
		<input type="text" id="selectedTable" name="selectedTable" class="hidden" value="<%=tableName %>"/>
		<input type="submit" value="save" />
	</form>
</div>

<% } %>

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
