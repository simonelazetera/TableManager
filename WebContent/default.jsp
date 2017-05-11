<%@ include file="top.jsp" %>
<title>Table Manager - select table</title>
</head>
<body>

<% String selectedTable = UtilsFunction.notNull(request.getParameter("selectedTable"), ""); %>

<div class="col-xs-6 top15 inline-flex">

<%
	if (!UtilsFunction.isEmpty(selectedTable)){ %>
		<form action="view.jsp" method="post" >
			<input type="submit" id="tableName" name="tableName" value="<%=selectedTable %>" class="width-auto"/>
		</form>
<% } else { %>
		<input type="text" value="no table selected" class="width-auto" disabled />
<% } %>

	<button class="left15 width-auto" onclick="window.location.href='config.jsp'">select table</button>
</div>

</body>
</html>