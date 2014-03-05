<?php

$cc = `geoip-lookup {$_SERVER['REMOTE_ADDR']}`;
$cc = trim($cc);
$http_lang = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
$lang = 'en';
$langs = array('en_US', 'en_GB');
$fql = 'en_US';
$espanol = explode(',', 'AR,BO,CL,CO,CR,CU,DO,EC,SV,GQ,GU,HN,MX,NI,PA,PY,PE,PR,ES,UY,VE');

if( in_array($cc, $espanol) || strtolower(substr($http_lang, 0, 2))=='es' ){
	$lang = 'es';
	$fql = 'es_MX.UTF8';
	$langs = array('en_ES.UTF-8', 'es_MX.UTF-8', 'es_ES.UTF-8');
}

putenv("LC_ALL=$fql");
setlocale(LC_ALL, $langs);



function __($str) {
	global $lang;
	$traducciones = [
		'Algo va a suceder' => 'Somehting\'s going to happen',
		'Saltar video' => 'Skip video',
		'Sigue @censuraMX' => 'Follow @censuraMX',
		'1dmx.org (censurado)' => '1dmx.org (censored)',
		'%d de %B de %Y' => '%B %d, %Y',
		'El gobierno mexicano a través de la embajada de Estados Unidos, censura el sitio 1dmx.org, un portal ciudadano que denunciaba las violaciones a los derechos humanos.' => 'The mexican government, through the embassy of the United States, censors the website 1dmx.org, a citizen\'s portal that denounced human rights violations.'
	];
	return $lang=='es' ? $str : $traducciones[$str];
}