<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    
    $query="SELECT tel AS value FROM `v_calendriervaccenf` WHERE jour <= 0 UNION ALL SELECT tel AS value FROM `v_calendriervat` WHERE jour <= 0";
    // 
    
    $querry = $app->getPDO()->prepare($query);
    $querry->execute();
    while ($row = $querry->fetch()) {
        $tel = trim($row["value"]);
        // if(strlen($tel)==13){
             echo json_encode(["RESPONSE"=>$app->sendMessage($tel,"Votre programme de vaccination est atteint. Passez demain à votre structure hospitalière")]);
        // }
  
    }
    
?>
