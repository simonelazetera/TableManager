<%@ include file="top.jsp" %>
<title>Table Manager</title>

</head>
<body>
<%
request.getSession();
String tableName = (String) session.getAttribute("TableName");
String idEdit = request.getParameter("idEdit");
%>
<div class="col-xs-6 top20">
	<h1>Update done</h1>
	<form action="view.jsp" method="POST">
		<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		<input id="tableName" name="tableName" value="<%=tableName %>" class="hidden"/>
		<input type="submit" value="Go back to the table" />
	</form>
</div>
</body>
</html>