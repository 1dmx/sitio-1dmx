<?php

function export($variable, $data) {
	$GLOBALS[$variable] = $data;
}

require_once('cookies.php');