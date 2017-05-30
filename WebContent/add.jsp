<%@ include file="top.jsp" %>
<title>Table Manager - Added row</title>

</head>
<body>
<%
String dbUrl = getServletContext().getInitParameter("dbUrl");
String user = getServletContext().getInitParameter("user");
String pass = getServletContext().getInitParameter("pass");
String idEdit = request.getParameter("idEdit");

request.getSession();
String tableName = (String) session.getAttribute("TableName");
TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");

tableExecute.getConnection(dbUrl,user,pass);
int rowsAffected = 0; 

try{
	Enumeration<String> enu = request.getParameterNames();
	rowsAffected = tableExecute.addRow(enu, request);
	%>
	<div class="col-xs-6 top20">
	<%if (rowsAffected > 0){ %>
		<form id="update" action="addSuccess.jsp" method="POST">
			<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		</form>
	<%} %>	
	</div>
<%
}catch (Exception e) {
	String errorMessage = e.getMessage();
%>
	<div class="col-xs-6 top20">
		<h1>Add error</h1>
        <p><%=errorMessage %></p>
        <form action="addRow.jsp" method="POST">
			<input type="hidden" name="idEdit" value="<%=idEdit %>" />
			<input type="submit" value="Go to the form" />
		</form>
     </div>
<%} %>
<%@ include file="js.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#add").submit();
});
</script>
<%tableExecute.closeConnection();  %>
</body>
</html>
