<?php require('lib/lang.php'); ?>
<!DOCTYPE html>
<html lang="<?= preg_replace("/_/", '-', substr($fql, 0,5)) ;?>">
<head>
	<meta charset="utf-8" />
	<meta name="Viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
	<title>1dmx</title>

	<link rel="stylesheet" href="assets/css/main.css" />
	<!--[if lt IE 9]>
	<script src="js/html5shiv.js"></script>
	<![endif]-->
</head>
<body>
	<?php require('lib/main.php'); ?>
	<div id="fb-root"></div>

	<?
	if( !$cookie->guachado ):
		$class = "por-guachar";
	?> 
	<section id="video">
		<h1><?= __('Algo va a suceder') ;?></h1>
		<div id="timer">
			00:00:10
		</div>
		<a href="#" id="saltar-video" class="boton"><?= __('Saltar video') ;?></a>
	</section>	
	<? endif; ?>

	<section id="content" class="<?= $class ;?>">
		<div class="inline" id="header">
			<img id="logo" src="/assets/img/logo.png" />
			<div id="social">
				<a href="https://twitter.com/censuramx" class="twitter-follow-button" data-show-count="false" data-lang="es"><?= __('Sigue @censuraMX') ;?></a>
				<div class="fb-share-button" data-href="http://op1d.mx" data-width="100px" data-type="button" data-lang="es"></div>
			</div>
			<a href="http://original.op1d.mx" class="boton"><?= __('1dmx.org (censurado)') ;?></a>
		</div>


		<div id="update">
			<div class="inline">
				<p class="fecha"><?= strftime(__('%d de %B de %Y'), strtotime('03/05/2014')) ?></p>
				<div>
					<? include("partials/update.{$lang}.php") ;?>
					<p style="text-align:center">
						<img src="/assets/img/censura.jpg" style="width:100%;"/>
					</p>
				</div>
			</div>
		</div>

		<section id="comunicado">
			<div class="inline">
				<p class="fecha"><?= strftime(__('%d de %B de %Y'), strtotime('03/04/2014')) ?></p>
				<div id="comunicado-body">
					<? include("partials/comunicado.{$lang}.php") ;?>
				</div>
			</div>
		</section>

		<section id="video-content">
			<div class="inline">
				<h2>#CensuraMX 1Dmx.org - <?= __('Algo va a suceder') ;?></h2>
				<iframe id="video-replay" width="420" height="315" src="//www.youtube.com/embed/m2zpjJteZPI" frameborder="0" allowfullscreen></iframe>
				<p><?= __('El gobierno mexicano a través de la embajada de Estados Unidos, censura el sitio 1dmx.org, un portal ciudadano que denunciaba las violaciones a los derechos humanos.') ;?></p>
			</div>
		</section>

	</section>

	<? if (!$cookie->guachado): ?>
	<script src="//www.youtube.com/iframe_api"></script>
	<? endif; ?>
	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	  ga('create', 'UA-46061468-1', 'op1d.mx');
	  ga('send', 'pageview');
	</script>
	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=432295506893938";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
	<script src="assets/js/main.js"></script>
</body>
</html>