<%@ include file="top.jsp" %>
<%@page import="java.sql.*"%>
<title>Table Manager - Added row</title>

</head>
<body>
<%
String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");

TableExecute tableExecute = new TableExecute(tableName);
tableExecute.getConnection();
try{
	Enumeration<String> enu = request.getParameterNames();
	tableExecute.addRow(enu, request);

}catch (Exception e) {
	e.printStackTrace();
}
tableExecute.closeConnection();
%>

	<h1 class="pad-left15">Added row</h1>
	
	<div class="col-xs-6 top20">
		<form action="view.jsp" method="POST">
			<input id="tableName" name="tableName" value="<%=tableName %>" class="hidden"/>
			<input type="submit" value="Go back to the table" />
		</form>
	</div>

</body>
</html>
