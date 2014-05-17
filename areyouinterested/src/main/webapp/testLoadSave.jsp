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

<%
	Event e = new Event(-1, "M", "save event test", "my location", "my date time", "save event test", "A");
	User h = new User(-1, "savetest@email.com", "save", "test", "A");
	e.setHost(h);
	Invitee i1 = new Invitee(-1, "invitee1@email.com", "invitee", "1", "A");
	Invitee i2 = new Invitee(-1, "invitee2@email.com", "invitee", "2", "A");
	Invitee i3 = new Invitee(-1, "invitee3@email.com", "invitee", "3", "A");
	e.addInvitee(i1);
	e.addInvitee(i2);
	e.addInvitee(i3);
	
	DataManager.saveEvent(e);

%>

</body>
</html>