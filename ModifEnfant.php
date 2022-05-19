<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    $data = json_decode(file_get_contents('php://input'),true);

        $noms = $data['noms'];
        $idMere = $data['idMere'];

        $querry = "SELECT * FROM enfant WHERE noms = '$noms' AND idMere = '$idMere'";

        echo json_encode($app->fetchPrepared($querry));

?>