<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <!-- Set the viewport so this responsive site displays correctly on mobile devices -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap 3 Responsive Design Tutorial | RevillWeb.com</title>
    <!-- Include bootstrap CSS -->
    <link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="jquery/jquery-2.1.0.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
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
			<div class="col-lg-2
			 col-md-3 col-sm-4 col-xs-8">
				<h3><span class="label label-primary">Invitees</span></h3>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			  	<input type="text" class="form-control" placeholder="Type Friend's names or group names">
			 </div>
		</div>
		<div class="row">
			<div class="col-lg-2 col-md-3 col-sm-4 col-xs-8">
			     <select class="form-control btn-primary">
				    <option>Movie</option>
				    <option>Restaurant</option>
				    <option>Event</option>
				  </select>
			  </div>
			  <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			  	<input type="text" class="form-control" placeholder="Type Movie.. e.g. titanic">
			  </div>
		</div>
		<div class="row">
			<div class="col-lg-4 col-md-5 col-sm-6 col-xs-10">
				<p>Date: <input type="text" id="datepicker"></p>
			</div>
		</div>
		<div class="row" height="300">
		</div>
		<div class="row">
			
		</div>
	</div>
<!-- Include jQuery and bootstrap JS plugins -->
<script src="bootstrap/dist/js/bootstrap.min.js"></script>
</body>
</html>