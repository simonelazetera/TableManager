<%@ include file="top.jsp" %>
<title>Table Manager - upgrade done</title>

</head>
<body>
<%
String dbUrl = getServletContext().getInitParameter("dbUrl");
String user = getServletContext().getInitParameter("user");
String pass = getServletContext().getInitParameter("pass");
request.getSession();
String tableName = (String) session.getAttribute("TableName");
TableExecute tableExecute = (TableExecute) session.getAttribute("TableExecute");
String idEdit = request.getParameter("idEdit");
tableExecute.getConnection(dbUrl,user,pass);

int rowsAffected = 0;

try{
	
	Enumeration<String> enu = request.getParameterNames();
	rowsAffected = tableExecute.updateRow(enu, idEdit, request);
%>
	<div class="col-xs-6 top20">
	<%if (rowsAffected > 0){ %>
		<form id="update" action="updateSuccess.jsp" method="POST">
			<input type="hidden" name="idEdit" value="<%=idEdit %>" />
		</form>
	<%} %>	
	</div>
<%
}catch (Exception e) {
	String errorMessage = e.getMessage();
%>
	<div class="col-xs-6 top20">
		<h1>Update error</h1>
        <p><%=errorMessage %></p>
        <form action="editrow.jsp" method="POST">
			<input type="hidden" name="idEdit" value="<%=idEdit %>" />
			<input type="submit" value="Go to the form" />
		</form>
     </div>
<%} %>
	
<%@ include file="js.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#update").submit();
});
</script>
<%tableExecute.closeConnection();  %>
</body>
</html>
