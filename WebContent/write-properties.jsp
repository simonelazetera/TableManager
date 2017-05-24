<%@ include file="top.jsp" %>
<title>Table Manager - select table</title>
</head>
<body>

<%	
	request.getSession();
	String tableName = (String) session.getAttribute("TableName");
	TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");

	Enumeration<String> enuTemp = request.getParameterNames();
	List<String> columns = new ArrayList<String>();
	List<String> value = new ArrayList<String>();
	
	while(enuTemp.hasMoreElements()){
		String temp = enuTemp.nextElement();
		columns.add(temp);
		value.add(request.getParameter(temp));
	}

	columns.remove("selectedTable");
	value.remove(tableName);
	
	
	tableExecute.writeProperties(columns, value);
	
%>

<form action="default.jsp" method="post" id="form-properties">
</form>

<%@ include file="js.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#form-properties").submit();
});
</script>
</body>
</html>