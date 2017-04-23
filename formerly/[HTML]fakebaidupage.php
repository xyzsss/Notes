<?php 
	if( isset($_GET["wd"]) ){
		print_r(file_get_contents("http://www.baidu.com/s?wd=".$_GET["wd"]));
	}else{
		print_r( file_get_contents('http://www.baidu.com'));
	}
