<%@ page import="edu.columbia.dao.DataManager" %>
<%@ page import="edu.columbia.vo.Event" %>
<%@ page import="edu.columbia.vo.User" %>
<%@ page import="edu.columbia.vo.Invitee" %>
<%@ page import="java.util.ArrayList" %>


<html>
<head>
<meta charset="utf-8" />
<title></title>
<script>

</script>
</head>
<body>

<% ArrayList<Event> events = DataManager.getEvents("jensen@email.com"); %>
<% Event event2 = DataManager.getEvent("21"); %>
   <h3><%= events.size() + " events"%></h3>
	 <% for (Event event : events) { %>
		   <%= "EventID: " + event.getID() + ", Type: " + event.getType() + ", Title: " + event.getTitle() + ", Location: " + event.getLocation() + ", DateTime: " + event.getDateTime() + ", Description: " + event.getDescription() %> <br>
	 		 <%= "Host UserID: " + event.getHost().getID() + ", email: " + event.getHost().getEmail() + ", FirstName: " + event.getHost().getFirstName() + ", LastName: " + event.getHost().getLastName() %><br>
		   
		   <% for (Invitee invitee : event.getInvitees()) { %>
		       <%= "Invitee UserID: " + invitee.getID() + ", email: " + invitee.getEmail() + ", FirstName: " + invitee.getFirstName() + ", LastName: " + invitee.getLastName() + ", Status: " + invitee.getStatus() %><br>
<% } %>
<br>
<% } %>

</body>
</html>