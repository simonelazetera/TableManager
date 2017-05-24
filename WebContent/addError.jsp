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
	<h1>Add error</h1>
	<form action="addRow.jsp" method="POST">
		<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		<input type="submit" value="Go to the form" />
	</form>
</div>
</body>
</html>