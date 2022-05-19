<?php

    include "Connexion2.php";

    $app=new App('esantevacci');
    $event=$_POST['event'];
   
    
    if($event=='FIND_HOPITAL'){
        $query = "SELECT concat(idHopital,'-',denomination) hopital FROM hopital";
        echo json_encode(   $app->fetchPrepared($query));
    }
     
    if ($event=='FIND_ENFANT') {

        $idMere =$_POST['idMere'];
        $querry = "SELECT dateNaissance,noms,sexe,poids,taille,idMere,datePrev,DATEDIFF(`datePrev`,DATE(NOW())) FROM enfant, calendriervaccenf WHERE idMere ='$idMere' AND enfant.idEnfant = calendriervaccenf.idEnfant ORDER BY datePrev ASC";
        echo json_encode($app->fetchPrepared($querry));
        //SELECT DATEDIFF(DATE(NOW()),`datePrev`) FROM `calendriervaccenf`;
    }
    if ($event=='FIND_ENFANT_ONLY') {

        $idMere =$_POST['idMere'];
        $querry = "SELECT * FROM enfant WHERE idMere ='$idMere'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='FIND_MERE') {
        $idMere =$_POST['idMere'];
        $querry = "SELECT * FROM mere WHERE idMere = '$idMere'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='FIND_NOTIF') {
        $idMere =$_POST['idMere'];
        $querry = "SELECT * FROM calendriervaccenf, enfant, vaccin WHERE datePrev<=DATE(NOW()) AND calendriervaccenf.idEnfant = enfant.idEnfant AND calendriervaccenf.idVaccin = vaccin.idVaccin AND enfant.idMere = '$idMere'";
        echo json_encode($app->fetchPrepared($querry));
    }
    

?>