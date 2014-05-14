<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Date" %>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="areyouinterested.css">
<title>AYI-Movies</title>
</head>
<body>
	<div>
		<h1><strong>Movies in Theaters</strong></h1>
	</div>
	<div>
		<div>
			<h3>Now playing in theaters</h3>
		</div>
		<div>
			<span>Arrange by Release Date</span>
		</div>
		<div>
			<h4><%=new Date()%></h4>
		</div>
		<% for(int i=0;i<movies.size();i++){
				JSONObject movie = (JSONObject)movies.get(i);
				JSONObject posters = (JSONObject)movie.get("posters");
				JSONObject ratings = (JSONObject)movie.get("ratings");
				JSONArray casts = (JSONArray)movie.get("abridged_cast");%>
		<hr>
		<div>
			<img src="<%=posters.get("profile")%>" width="120" style="min-height:115px" alt="Rio 2" title="Rio 2">
			<div>
				<h2><%=movie.get("title") %></h2>
				<span>Tomatometer: <%=ratings.get("critics_score") %>%</span>
			</div>
			<div>
				<%for(int j=0;j<casts.size();j++){
					JSONObject actor = (JSONObject)casts.get(j);
					out.print(actor.get("name"));
					if(j!=casts.size()-1)
						out.print(", ");
				}%>
			</div>
			<p>
				<%=movie.get("synopsis") %>
			</p>
			<div>
				<%=movie.get("year") %>, <%=movie.get("mpaa_rating") %>, <%=movie.get("runtime") %> min
			</div>
			<a href="newInvitation.jsp?title=<%=movie.get("title") %>>">Next</a>
		</div>
		<%} %>
	</div>
</body>
</html>
