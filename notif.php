<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    $data = json_decode(file_get_contents('php://input'),true);

    $idMere = $data['idMere'];

    $querry = "SELECT COUNT(calendriervaccenf.idEnfant) as value FROM calendriervaccenf, enfant, vaccin WHERE datePrev<=DATE(NOW()) AND calendriervaccenf.idEnfant = enfant.idEnfant AND calendriervaccenf.idVaccin = vaccin.idVaccin AND enfant.idMere = '$idMere'";
    $count = $app->getValues($querry);
        //if($app->fetchPrepared($querry)){
            echo ($count);
        // }else{
        //     return null;
        // }

?>