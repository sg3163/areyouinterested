<html>
<head>
    <meta charset="utf-8">
    <!-- Set the viewport so this responsive site displays correctly on mobile devices -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>New Invitation Page</title>
    <!-- Include bootstrap CSS -->
    <link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="areyouinterested.css">
    <link rel="stylesheet" href="selectize/css/stylesheet.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="jquery/jquery-2.1.0.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="selectize/dist/js/standalone/selectize.js"></script>
	<script src="selectize/index.js"></script>
    <style type="text/css">
	    .container-fluid .row {
	        margin: 0;
	    }
	</style>
    <script>
		$(function() {
		$( "#datepicker" ).datepicker();
		});
	</script>
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
		
		var friendsArr = [];
		
		function updateStatusCallback(response) {
			
			if (response.status === 'connected') {
			    // the user is logged in and has authenticated your
			    // app, and response.authResponse supplies
			    // the user's ID, a valid access token, a signed
			    // request, and the time the access token 
			    // and signed request each expire
			    var uid = response.authResponse.userID;
			    var accessToken = response.authResponse.accessToken;
			    getFriends();
	
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
		            	friendsArr[index] = friend.name;
		        //        alert(friend.name + ' has id:' + friend.id);
		            });
		        } else {
		            alert("Error!");
		        }
		    });
		}
		
		window.fbAsyncInit
	</script>
</head>
<body>
	<div class="page-header">
	  <h1>Invitation</h1>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-lg-2 col-md-3 col-sm-4 col-xs-8">
				<h4 class="button-class">Invitees</h4>
				<!-- <h3><span class="label-primary">Invitees</span></h3> -->
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			  	<input type="text" class="form-control" placeholder="Type Friend's names or group names">
			 </div>
		</div>
		<div class="row">
			<div class="col-lg-2 col-md-2 col-sm-4 col-xs-8">
			     <select class="form-control btn-primary">
				    <option>Movie</option>
				    <option>Restaurant</option>
				    <option>Event</option>
				  </select>
			  </div>
			  <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<div class="control-group">
				<select id="select-to" class="contacts" placeholder="Type Friend's names"></select>
			</div>
			  </div>
			  <div class="col-lg-4 col-md-4 col-sm-6 col-xs-10">
				<input type="text" id="datepicker">
			  </div>
		</div>
		<div class="row" height="300">
			<div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
				
			</div><textarea class="form-control" rows="5"></textarea>
		</div>
		<div class="row">
			<div class="col-lg-2 col-md-3 col-sm-4 col-xs-8">
				<button type="button" class="btn btn-primary">Send Invite</button>
			</div>
		</div>
	</div>
<!-- Include jQuery and bootstrap JS plugins -->
<script src="bootstrap/dist/js/bootstrap.min.js"></script>
<script>
		var REGEX_EMAIL = '([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@' +
						  '(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)';

		var formatName = function(item) {
			return $.trim(item.name);
		};

		$('#select-to').selectize({
			persist: false,
			maxItems: null,
			valueField: 'name',
			labelField: 'name',
			searchField: ['name'],
			sortField: [
				{field: 'name', direction: 'asc'}
			],
			options: [
				{name: 'Nikola Tesla'},
				{name: 'Brian Reavis'},
				{name: 'Jill Jakka'}
			],
			render: {
				item: function(item, escape) {
					var name = formatName(item);
					return '<div>' +
						(name ? '<span class="name">' + escape(name) + '</span>' : '') /* +
						(item.email ? '<span class="email">' + escape(item.email) + '</span>' : '') +*/
					'</div>';
				},
				option: function(item, escape) {
					var name = formatName(item);
					var label = item.name;
					var caption = item.name;
					return '<div><span class="label">' + escape(label) + '</span></div>';
				}
			}/*,
			create: function(input) {
				if ((new RegExp('^' + REGEX_EMAIL + '$', 'i')).test(input)) {
					return {email: input};
				}
				var match = input.match(new RegExp('^([^<]*)\<' + REGEX_EMAIL + '\>$', 'i'));
				if (match) {
					var name       = $.trim(match[1]);
					var pos_space  = name.indexOf(' ');
					var first_name = name.substring(0, pos_space);
					var last_name  = name.substring(pos_space + 1);

					return {
						email: match[2],
						first_name: first_name,
						last_name: last_name
					};
				}
				alert('Invalid email address.');
				return false;
			}*/
		});
	</script>
</body>
</html>