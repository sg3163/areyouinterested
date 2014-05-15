<%@ page import="edu.columbia.dao.DataManager" %>
<%@ page import="edu.columbia.vo.Event" %>
<%@ page import="java.util.ArrayList" %>
<%
	//get the event list from database here and save it to eventList
	ArrayList<Event> hostList = new ArrayList<Event>();
	ArrayList<Event> inviteList = new ArrayList<Event>();
	if(request.getParameter("email")!=null){
		hostList = DataManager.getHostingEvents(request.getParameter("email"));
		inviteList = DataManager.getInvitedEvents(request.getParameter("email"));
	}
%>
<html>
<head>
<meta charset="utf-8" />
<title>Are You Interested</title>
<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="areyouinterested.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="jquery/jquery-2.1.0.js"></script>

<script src="jquery/url.js"></script>
<script>
	$( document ).ready(function() {
		
		$.ajaxSetup({ cache: true });
		  $.getScript('//connect.facebook.net/en_US/all.js', function(){
		    FB.init({
		      appId: '441365315993395',
		    });     
		    $('#loginbutton,#feedbutton').removeAttr('disabled');
		    FB.getLoginStatus(updateStatusCallback);
		  });
		  
	});
	
	function updateStatusCallback(response) {
	//	alert('testing');
		if (response.status === 'connected') {
		    // the user is logged in and has authenticated your
		    // app, and response.authResponse supplies
		    // the user's ID, a valid access token, a signed
		    // request, and the time the access token 
		    // and signed request each expire
		    var uid = response.authResponse.userID;
		    var accessToken = response.authResponse.accessToken;
		    //alert('Welcome to Facebook ' +uid);
		    
		    //getFriends();

		    if(window.url("?email")==null){
		    	FB.api('/me', function (response) {
					location.href = "index.jsp?email="+response.email+"&fbid="+response.id+"&name="+response.name;
				});
		    }

		  } else if (response.status === 'not_authorized') {
		    // the user is logged in to Facebook, 
		    // but has not authenticated your app
			  alert('Please authenticate the app' + response);
		  } else {
		    // the user isn't logged in to Facebook.
		    alert('Please login to Facebook');
		  }
	}
	
	function getFriends() {
	    FB.api('/me/friends', function(response) {
	        if(response.data) {
	            $.each(response.data,function(index,friend) {
	                alert(friend.name + ' has id:' + friend.id);
	            });
	        } else {
	            alert("Error!");
	        }
	    });
	}
	
	
	
	function greet() {
		FB.api('/me', function (response) {
			location.href = "index.jsp?id="+response.email;
		});
	}
	

</script>
</head>
<body>
	<h1>Are You Interested?</h1>
	<h2 >Welcome, <%=request.getParameter("name") %>!</h2>
	<span><a href="movies.jsp">movies</a> | restaurants</span>	
	<table>
		<tr>
			<td><h3>My Events</h3></td><td><h3>Invitations</h3></td>
		</tr>
		<%
		String event;
		int maxLength = (hostList.size()>inviteList.size()?hostList.size():inviteList.size());
		for(int i=0;i<maxLength;i++){%>
		<tr>
			<td><a href="eventDetail.jsp?eventid=<%=(hostList.size()>i?hostList.get(i).getID():null) %>"><%=(hostList.size()>i?hostList.get(i).getTitle():"") %></a></td><td><a href="eventDetail.jsp?eventid=<%=(inviteList.size()>i?inviteList.get(i).getID():null) %>"><%=(inviteList.size()>i?inviteList.get(i).getTitle():"")%></a></td>
		</tr>
		<%}%>
	</table>
	<a href='newInvitation.jsp?email=<%=request.getParameter("email")%>&fbid=<%=request.getParameter("fbid")%>&firstName=<%=request.getParameter("name") %>'>Create A New Event</a>
</body>
</html>