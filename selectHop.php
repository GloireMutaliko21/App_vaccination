<?php

    
    include "Connexion.php";

    $app=new App('id17494911_esantevacci');
    $event=$_POST['event'];
   
    
    if($event=='FIND_HOPITAL'){
        $query = "SELECT concat(idHopital,'-',denomination) hopital FROM hopital";
        echo json_encode(   $app->fetchPrepared($query));
    }
     
    if ($event=='FIND_ENFANT') {

        $idMere =$_POST['idMere'];
        $querry = "SELECT noms,idMere,datePrev,jour FROM v_calendriervaccenf WHERE idMere ='$idMere' ORDER BY datePrev ASC";
        echo json_encode($app->fetchPrepared($querry));
        //SELECT DATEDIFF(DATE(NOW()),`datePrev`) FROM `calendriervaccenf`;
    }
    if ($event=='FIND_ENFANT_CAL_ACTIF') {

        $idMere =$_POST['idMere'];
        $querry = "SELECT noms,idMere,datePrev,jour FROM v_calendriervaccenf WHERE idMere ='$idMere' ORDER BY datePrev ASC";
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
    if ($event=='CALENDARS') {
        $idMere =$_POST['idMere'];
        $querry = "SELECT enfant.noms as nom,enfant.idEnfant,enfant.idMere,mere.idMere,calendriervaccenf.datePrev,calendriervaccenf.idVaccin,calendriervaccenf.idEnfant,nomVaccin FROM calendriervaccenf,enfant,mere,vaccin WHERE calendriervaccenf.idEnfant=enfant.idEnfant AND enfant.idMere = mere.idMere AND mere.idMere = '$idMere' AND calendriervaccenf.idVaccin = vaccin.idVaccin";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='FIND_NOTIF') {
        $idMere =$_POST['idMere'];
        $querry = "SELECT * FROM calendriervaccenf, enfant, vaccin WHERE datePrev<=DATE(NOW()) AND calendriervaccenf.idEnfant = enfant.idEnfant AND calendriervaccenf.idVaccin = vaccin.idVaccin AND enfant.idMere = '$idMere'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if($event=='MESSAGE_NOTIF'){
        $querry = "SELECT v_calendriervaccenf.tel, v_calendriervaccenf.datePrev, v_calendriervat.tel, v_calendriervat.datePrevue FROM v_calendriervaccenf, v_calendriervat WHERE v_calendriervaccenf.jour <= 0 OR v_calendriervat <= 0";
    }

?>