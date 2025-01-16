<?php
	$command = $_POST["command"];
	
	$f = fopen("index.html", "w");

	fwrite($f, "$command");
	fclose($f);
?>