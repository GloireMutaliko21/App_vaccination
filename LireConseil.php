<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    $data = json_decode(file_get_contents('php://input'),true);

        $querry = "SELECT contenu, datePub FROM conseil ORDER BY datePub DESC";

        //if($app->fetchPrepared($querry)){
            echo json_encode($app->fetchPrepared($querry));
        // }else{
        //     return null;
        // }

?>