<%@page import="packageTableManager.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">
    
    
<%
	String dbUrl = getServletContext().getInitParameter("dbUrl");
	String user = getServletContext().getInitParameter("user");
	String pass = getServletContext().getInitParameter("pass");
%>
