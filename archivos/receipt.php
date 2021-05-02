<?php

$tiempo = date("is");
$foto = $_POST['fot'];

if(isset($_POST['fot'])){
	$file = fopen('foto.txt','w+');
	fwrite($file, '
foto recibida
');
	fclose($file);

}

$replace = substr($foto, strpos($foto, ",")+1);
$foto_decodificada = base64_decode($replace);
$file1 = fopen( 'foto'.$tiempo.'.png', 'wb' );
fwrite( $file1, $foto_decodificada);
fclose( $file1 );


exit();
?>
