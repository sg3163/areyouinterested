<%@ page import="edu.columbia.dao.DataManager" %>
<%@ page import="edu.columbia.vo.Event" %>
<%@ page import="java.util.ArrayList" %>


<html>
<head>
<meta charset="utf-8" />
<title>Demo</title>
<script>

</script>
</head>
<body>
<h1>Welcome to Are you Interested?</h1>
<h2>Work in Progress</h2>

<script src="js/jquery-2.1.0.js"></script>
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
		alert('testing');
		if (response.status === 'connected') {
		    // the user is logged in and has authenticated your
		    // app, and response.authResponse supplies
		    // the user's ID, a valid access token, a signed
		    // request, and the time the access token 
		    // and signed request each expire
		    var uid = response.authResponse.userID;
		    var accessToken = response.authResponse.accessToken;
		    alert('Welcome to Facebook ' +uid);
		    
		    // get facebook friends
		    FacebookClient facebookClient = new DefaultFacebookClient(accessToken);
		    Connection friends = facebookClient.fetchConnection("me/friends", User.class);
		    String friends = "";
		   	
		    for (User user : friends.getData()) {
		    	friends += user.getId() + ": " + user.getName() + ", ";
		    }
		    
		    alert(friends);

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
	
	window.fbAsyncInit
</script>
</body>
</html>