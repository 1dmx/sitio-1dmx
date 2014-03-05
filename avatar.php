<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="Viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
	<title>#CensuraMEXta</title>
	<link rel="stylesheet" href="/assets/css/avatar.css" />
</head>
<body>
	<div id="fb-root"></div>

	<header>
		<h1>#CensuraMEXta</h1>
		<p>Tampoco quiero que censuren internet</p>
	</header>

	<div id="editing-area">
		<div id="block"></div>
		<canvas id="canvas"></canvas>
		<a href="#" id="snap" class="boton icono"><img src="/assets/img/cam.svg" /></a>
	</div>
	<div id="snap-controls">
		<a href="#" id="save" class="boton" download="censuraMEXta.png">Guardar</a>
		<a href="#" id="save-to-facebook" class="boton">Publicar en FB</a>
	</div>

	<div id="inputs">
		<a href="#" id="upload-photo" class="boton">Sube una foto</a>
		<input type="file" name="photo" multiple="false" id="file-upload" />
		<a href="#" id="take-photo" class="boton">Tómate una foto</a>
		<a href="#" id="facebook" class="boton">Usa Facebook</a>
	</div>

	<div id="pictures">
	</div>

	

	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=432295506893938";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	  ga('create', 'UA-46061468-1', 'op1d.mx');
	  ga('send', 'pageview');
	</script>
	<script src="/assets/js/avatar.js"></script>
</body>
</html>