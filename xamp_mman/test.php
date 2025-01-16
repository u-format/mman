<?php
	$p = $_POST["p"];
	$a = $_POST["a"];

	$f = fopen("status.html", "w");

	// fwrite($f, "ip: $test\n &nbsp; hostname: $hostname\n map: $map\n gamemode: $gamemode");
	fwrite($f, "$p");


	fclose($f);
?>