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
<%= events.size() %>

</body>
</html>