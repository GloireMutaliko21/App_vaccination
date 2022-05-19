<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    $data = json_decode(file_get_contents('php://input'),true);

        $loginM = $data['loginM'];
        $pwM = $data['pwM'];

        $querry = "SELECT * FROM mere WHERE loginM = '$loginM' AND pwM = '$pwM'";


        // if($app->getValues($querry)){
        echo json_encode($app->fetchPrepared($querry));
        // }else{
        //     return null;
        // }

?>