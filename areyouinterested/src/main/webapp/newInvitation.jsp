<html>
<head>
    <meta charset="utf-8">
    <!-- Set the viewport so this responsive site displays correctly on mobile devices -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>New Invitation Page</title>
    <!-- Include bootstrap CSS -->
    <link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="selectize/normalize.css">
    <link rel="stylesheet" href="selectize/css/stylesheet.css">
    <link rel="stylesheet" href="areyouinterested.css">
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
			  
			  $("#sendInviteBtn").click(function() {
				  
				  var title = $('#select-movie')[0].value;
				  if(!title) {
					  alert("Please select Movie");
					  return false;
				  }
				  
				  var dateTime = $("#datepicker")[0].value;
				  if(!dateTime) {
					  alert("Please select Date");
					  return false;
				  }
				  
				  var description = $("#description")[0].value;
				  var invitees = [];
				  
				  var $select = $('#select-to').selectize();
				  var selectize = $select[0].selectize;
				  var selectedValues = selectize.getValue();
				  
				  for(var i=0;i<selectedValues.length;i++) {
					  invitees[i] = {"email":selectedValues[0], "firstName":selectize.getItem(selectedValues[i])[0].innerText};
				  }
				  
				  if(!invitees || invitees.length <1) {
					  alert("Please select Invitees");
					  return false;
				  }
				  
			//	  var firstSelection = selectize.getItem(selectedValues[0]);
				  
			//	  "invitees": [{"email":"457456", "firstName":"harsha345"},{"email":"8645", "firstName":"machhha"} ]
				  
				  var data = {"type": "M", "title": title, "dateTime": dateTime, "description" : description,
						  		action: "A", "host" :{"email":userFacebookId, "firstName": firstName, "lastName":lastName },
						  		 "invitees":invitees}
				  
					$.post("saveInvitation",
							  {
							    data:JSON.stringify(data),
							    city:"Duckburg"
							  },
							  function(data,status){
							    alert("Data: " + data + "\nStatus: " + status);
					});
				});
			  
		});
		
	/*	
		
		$("#sendInviteBtn").click(function() { 
			alert("Button Clicked")
		});*/
		
		var userFacebookId = <%=request.getParameter("fbid")%>;
		var firstName = "<%=request.getParameter("firstName")%>";
		var lastName = <%=request.getParameter("lastName")%>;
		
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
		            	friendsArr[index] = {id: friend.id, name: friend.name};
		        //        alert(friend.name + ' has id:' + friend.id);
		            });
		            initSelectize();
		        } else {
		            alert("Error!");
		        }
		    });
		}
		
		function initSelectize() {
			$('#select-to').selectize({
				persist: false,
				maxItems: null,
				valueField: 'id',
				labelField: 'name',
				searchField: ['name'],
				sortField: [
					{field: 'name', direction: 'asc'}
				],
				options: friendsArr,
				render: {
					item: function(item, escape) {
						var name = $.trim(item.name);
						return '<div>' +
							(name ? '<span class="name">' + escape(name) + '</span>' : '') /* +
							(item.email ? '<span class="email">' + escape(item.email) + '</span>' : '') +*/
						'</div>';
					},
					option: function(item, escape) {
						var name = $.trim(item.name);
						var label = item.name;
						var caption = item.name;
						return '<div><span class="name">' + escape(label) + '</span></div>';
					}
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
			  	<select id="select-to" class="contacts" placeholder="Type Friend's name"></select>
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
				<select id="select-movie" placeholder="Find a movie..."></select>
			</div>
			  </div>
			  <div class="col-lg-4 col-md-4 col-sm-6 col-xs-10">
				<input id="datepicker" type="text">
			  </div>
		</div>
		<div class="row" height="300">
			<div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
				
			</div><textarea id="description" class="form-control" rows="5"></textarea>
		</div>
		<div class="row">
			<div class="col-lg-2 col-md-3 col-sm-4 col-xs-8">
				<button id="sendInviteBtn" type="button" class="btn btn-primary">Send Invite</button>
			</div>
		</div>
	</div>
<!-- Include jQuery and bootstrap JS plugins -->
<script src="bootstrap/dist/js/bootstrap.min.js"></script>
<script>
				// <select id="select-movie"></select>
				$('#select-movie').selectize({
					theme: 'movies',
					valueField: 'title',
					labelField: 'title',
					searchField: 'title',
					options: [],
					create: false,
					render: {
						option: function(item, escape) {
							var actors = [];
							for (var i = 0, n = item.abridged_cast.length; i < n; i++) {
								actors.push('<span>' + escape(item.abridged_cast[i].name) + '</span>');
							}

							return '<div>' +
								'<img src="' + escape(item.posters.thumbnail) + '" alt="">' +
								'<span class="title">' +
									'<span class="name">' + escape(item.title) + '</span>' +
								'</span>' +
								'<span class="description">' + escape(item.synopsis || 'No synopsis available at this time.') + '</span>' +
								'<span class="actors">' + (actors.length ? 'Starring ' + actors.join(', ') : 'Actors unavailable') + '</span>' +
							'</div>';
						}
					},
					load: function(query, callback) {
						if (!query.length) return callback();
						$.ajax({
							url: 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json',
							type: 'GET',
							dataType: 'jsonp',
							data: {
								q: query,
								page_limit: 10,
								apikey: 's6psksgf6nn43x8hqv2yefnb'
							},
							error: function() {
								callback();
							},
							success: function(res) {
								console.log(res.movies);
								callback(res.movies);
							}
						});
					}
				});
				</script>
</body>
</html>