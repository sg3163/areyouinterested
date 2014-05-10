<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="edu.columbia.dao.DataManager" %>
<%@ page import="edu.columbia.vo.Event" %>
<%@ page import="edu.columbia.vo.User" %>
<%@ page import="edu.columbia.vo.Invitee" %>

<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.net.URL" %>

<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>


<%
String url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=s6psksgf6nn43x8hqv2yefnb";
String jsonString = "";
BufferedReader reader = new BufferedReader(new InputStreamReader(new URL(url).openStream()));
char c;
while(true){
	c = (char) reader.read();
	jsonString += c;
	if(jsonString.endsWith("{country-code}\"}"))
		break;
}
reader.close();
JSONObject json = (JSONObject) JSONValue.parse(jsonString);
JSONArray movies = (JSONArray) json.get("movies");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Event Detail</title>
<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="areyouinterested.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="jquery/jquery-2.1.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<style type="text/css">
	.container-fluid .row {
		margin: 0;
	}
</style>
</head>
<body>

<% 
	Event event = DataManager.getEvent("21"); 
	JSONObject movie = null;
	
	if (event.getType().equalsIgnoreCase("M")) {
		for(int i=0; i<movies.size(); i++) {
			movie = (JSONObject)movies.get(i);
			
			if (movie.get("title").toString().trim().equalsIgnoreCase(event.getTitle()))
				break;
			else
				movie = null;
		}
	}
%>

<div class="page-header" style="padding-left:15px">
	<h1><%= event.getTitle() %></h1>
	
<%
	if (event.getType().equalsIgnoreCase("M") && movie != null && movie.get("posters") != null) {
%>
		<br/><img src="<%= ((JSONObject)movie.get("posters")).get("profile") %>" width="120" style="min-height:115px" alt="Rio 2" title="Rio 2">
<%
	}
%>
</div>

<div style="padding-left:15px">
<table cellspacing="0" cellpadding="0" table-width="fixed" width="100%">
	<cols>
		<col width="150px"/>
		<col width="*"/>
	</cols>
<%
  if (event.getType().equalsIgnoreCase("M")) {
%>	  
	<tr>
		<td class="label20">Type:</td>
		<td class="text20">Movie</td>
	</tr>
<%
  } else if (event.getType().equalsIgnoreCase("R")) {
%>
	<tr>
		<td class="label20">Type:</td>
		<td class="text20">Restaurant</td>
	</tr>
<%
  } else if (event.getType().equalsIgnoreCase("X")) {
%>
	<tr>
		<td class="label20">Type:</td>
		<td class="text20">Miscellaneous</td>
	</tr>
<%
	}
%>
	<tr>
		<td class="label20">Location:</td>
		<td class="text20"><%= event.getLocation() %></td>
	</tr>
	<tr>
		<td class="label20">Date/Time:</td>
  	<td class="text20"><%= event.getDateTime() %></td>
  </tr>
  <tr>
  	<td class="label20">Description:</td>
		<td class="text20"><%= event.getDescription() %></td>
	</tr>
	<tr>
		<td class="label20">Host:</td>
		<td class="text20"><%= event.getHost().getFirstName() %> <%= event.getHost().getLastName() %></td>
	</tr>
</div>

<div style="padding-left:15px">
<table cellspacing="0" cellpadding="0" table-width="fixed" width="100%">
	<tr height="20px"><td/></tr>
	<tr valign="top">
		<td>
<h4><u>Invited People - Accepted</u></h4>
<% 
	for (Invitee invitee : event.getInvitees()) { 
		if (invitee.getStatus().equalsIgnoreCase("A")) { 
%>
<%= invitee.getFirstName() %> <%= invitee.getLastName() %><br>
<% 
		}
	} 
%>
		</td>
		<td>
<h4><u>Invited People - Rejected</u></h4>
<% 
	for (Invitee invitee : event.getInvitees()) { 
		if (invitee.getStatus().equalsIgnoreCase("R")) { 
%>
<%= invitee.getFirstName() %> <%= invitee.getLastName() %><br>
<% 
		}
	} 
%>		
		</td>
		<td>
<h4><u>Invited People - Not Responded</u></h4>
<% 
	for (Invitee invitee : event.getInvitees()) { 
		if (invitee.getStatus().equalsIgnoreCase("I")) { 
%>
<%= invitee.getFirstName() %> <%= invitee.getLastName() %><br>
<% 
		}
	} 
%>		
		</td>
	</tr>
	<tr height="15px"><td/></tr>
</table>		
</div>
</body>
</html>