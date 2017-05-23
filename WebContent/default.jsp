<%@ include file="top.jsp" %>
<title>Table Manager - select table</title>
</head>
<body>

<% 
	String tableName = UtilsFunction.notNull(request.getParameter("tableName"), "");
	TableExecute tableExecute = new TableExecute(tableName);
	List<String> tableList;
	
	
if(tableName.equals("")){
%>

<div class="col-xs-6 top15">
	<button class="width-auto" onclick="window.location.href='config.jsp'">add table</button>
<%
	if (tableExecute.readTable().size() != 0){ 
		for (String tb:tableExecute.readTable()) { 
%>
			<form action="default.jsp" method="post" >
				<input type="submit" id="tableName" name="tableName" value="<%=tb %>" class="width-auto table-list"/>
			</form>
<%	 		}
	} else { 
%>
		<input type="text" value="no table selected" class="width-auto" disabled />
<% 
	} 
}else{
	response.setHeader("REFRESH","0;URL=view.jsp");
}
%>
	
</div>

</body>
</html>
