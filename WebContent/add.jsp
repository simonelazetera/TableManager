<%@ include file="top.jsp" %>
<title>Table Manager - Added row</title>

</head>
<body>
<%
String idEdit = request.getParameter("idEdit");

request.getSession();
String tableName = (String) session.getAttribute("TableName");
TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");

tableExecute.getConnection();
int rowsAffected = 0; 

try{
	Enumeration<String> enu = request.getParameterNames();
	rowsAffected = tableExecute.addRow(enu, request);
}catch (Exception e) {
	e.printStackTrace();
}
%>
	<div class="col-xs-6 top20">
	<%if (rowsAffected > 0){ %>
		<form id="add" action="addSuccess.jsp" method="POST">
		</form>
	<%} else { %>
		<form id="add" action="addError.jsp" method="POST">
		</form>
	<%} %>
	</div>
<%@ include file="js.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#add").submit();
});
</script>
<%tableExecute.closeConnection();  %>
</body>
</html>