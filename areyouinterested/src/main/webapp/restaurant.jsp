<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="edu.columbia.dao.Yelp"%>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="java.util.Date" %>

<%
String consumerKey = "M1xZbc7G1pjbraUn368DnQ";
   String consumerSecret = "7s2LOMCSnK2LbZiYixn9Ikj55J4";
   String token = "8NbcixcyYntb1FR8sCTZDkgtLzaJOtBp";
   String tokenSecret = "CPTKfgOrfBbGUeH8uKzHPiB7i_A";

   Yelp yelp = new Yelp(consumerKey, consumerSecret, token, tokenSecret);
   String keyword = (request.getParameter("key")!=null?request.getParameter("key"):"tacos");
   String yelpresponse = yelp.search(keyword, 41, -74);

   JSONObject json = (JSONObject) JSONValue.parse(yelpresponse);
   JSONArray restaurants = (JSONArray) json.get("businesses");
   
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
		<h1><strong>Best Dinners in New York</strong></h1>
	</div>
	<div>
		<div>
			<h3>Tacos</h3>
		</div>
		<div>
			<span>Arrange by Ratings</span>
		</div>
		<div>
			<h4><%=new Date()%></h4>
		</div>
		<% for(int i=0;i<restaurants.size();i++){
				JSONObject restaurant = (JSONObject)restaurants.get(i);
				JSONObject location = (JSONObject)restaurant.get("location");
				JSONArray categories = (JSONArray)restaurant.get("categories");%>
		<hr>
		<div>
			<img src='<%=restaurant.get("image_url")%>' width="120" style="min-height:115px"/>
			<div>
				<h2><%=restaurant.get("name") %></h2>
				<span><img src='<%=restaurant.get("rating_img_url")%>'/></span>
			</div>
			<div>
				<%
				JSONArray display_address = (JSONArray)location.get("display_address");
				for(int j=0;j<display_address.size();j++){
					String addressLine = (String)display_address.get(j);
					out.print(addressLine);
				}%>
			</div>
			<div>
				<%
				for(int j=0;j<categories.size();j++){
					JSONArray categoryLine = (JSONArray)categories.get(j);
					out.print(categoryLine);
				}%>
			</div>
			<div>
				<%=restaurant.get("display_phone") %>
			</div>
			<p>
				<%=restaurant.get("snippet_text") %>
			</p>
			<a href="newInvitation.jsp?title=<%=restaurant.get("name") %>>">Next</a>
		</div>
		<%} %>
	</div>
</body>
</html>
