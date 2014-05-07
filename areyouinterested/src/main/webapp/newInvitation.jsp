<html>
<head>
    <meta charset="utf-8">
    <!-- Set the viewport so this responsive site displays correctly on mobile devices -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>New Invitation Page</title>
    <!-- Include bootstrap CSS -->
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
    <script>
		$(function() {
		$( "#datepicker" ).datepicker();
		});
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
			  	<input type="text" class="form-control" placeholder="Type Movie.. e.g. titanic">
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
</body>
</html>