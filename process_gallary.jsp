<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<!-- Add jQuery library -->
	<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>

	<!-- Add mousewheel plugin (this is optional) -->
	<script type="text/javascript" src="js/jquery.mousewheel.pack.js?v=3.1.3"></script>

	<!-- Add fancyBox main JS and CSS files -->
	<script type="text/javascript" src="js/jquery.fancybox.pack.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="css/jquery.fancybox.css?v=2.1.5" media="screen" />

	<!-- Add Thumbnail helper (this is optional) -->
	<link rel="stylesheet" type="text/css" href="css/jquery.fancybox-thumbs.css?v=1.0.7" />
	<script type="text/javascript" src="js/jquery.fancybox-thumbs.js?v=1.0.7"></script>



	<script type="text/javascript">
		$(document).ready(function() {

			$('.fancybox-thumbs').fancybox({
				prevEffect : 'none',
				nextEffect : 'none',

				closeBtn  : true,
				arrows    : true,
				nextClick : true,

				helpers : {
					thumbs : {
						width  : 50,
						height : 50
					}
				}
			});
		});
	</script>
		
	
	
</head>
<body>
	<p>  
			
	
			<% int i = 1;
			for(i=1;i<5;i++) { 
			 System.out.print(i);
			 %>
			<a class="fancybox-thumbs" data-fancybox-group="thumb" href="upload/img/degin<%=i%>.jpg"><%} i =1;%><input type="image" src="upload/img/degin1.jpg"> </a> 
	</p>

</body>
</html>