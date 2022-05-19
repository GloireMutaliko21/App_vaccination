<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    $data = json_decode(file_get_contents('php://input'),true);

        $idMere = $data['idMere'];

        $querry = "SELECT * FROM enfant WHERE idMere = '$idMere'";
        echo json_encode($app->fetchPrepared($querry));
        

?>