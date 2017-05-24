<%@ include file="top.jsp" %>
<title>Table Manager - upgrade done</title>

</head>
<body>
<%
request.getSession();
String tableName = (String) session.getAttribute("TableName");
TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");
String idEdit = request.getParameter("idEdit");
tableExecute.getConnection();

int rowsAffected = 0;

try{
	
	Enumeration<String> enu = request.getParameterNames();
	rowsAffected = tableExecute.updateRow(enu, idEdit, request);
	
}catch (Exception e) {
	e.printStackTrace();
}

%>
	<div class="col-xs-6 top20">
	<%if (rowsAffected > 0){ %>
		<form id="update" action="updateSuccess.jsp" method="POST">
			<input type="hidden" name="idEdit" value="<%=idEdit %>" />
			<input id="tableName" name="tableName" value="<%=tableName %>" class="hidden"/>
		</form>
	<%} else { %>
		<form id="update" action="updateError.jsp" method="POST">
			<input type="hidden" name="idEdit" value="<%=idEdit %>" />
			<input id="tableName" name="tableName" value="<%=tableName %>" class="hidden"/>
		</form>
	<%} %>
	</div>
	
<%@ include file="js.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#update").submit();
});
</script>
<%tableExecute.closeConnection();  %>
</body>
</html>