<html>
<head>
<meta charset="utf-8" />
<title>Demo</title>
</head>
<body>
<h1>Work in Progress..</h1>
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
</script>
</body>
</html>