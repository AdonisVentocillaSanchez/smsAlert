<?php

if(empty($_GET)){
echo "no hay información";
$lat = ""; 
  $lng = "";
  $telefono = " ";
  $detalle1 = " ";
  $detalle2 = " ";
}else{
  $lat = $_GET['lat']; 
  $lng = $_GET['lng'];
  $telefono = $_GET['t'];
  $fractura = $_GET['f'];
  $movimiento = $_GET['m'];
  
  if($telefono==null){
    $celular =" ";
  }else {
    $celular =$telefono;
  }
 if($fractura==null){
  $detalle1 = "";
}elseif($fractura==1){
 $detalle1 = "Golpes Leves";
}
elseif($fractura==2){
 $detalle1 = "Fracturas Leves";
}
elseif($fractura==3){
 $detalle1 = "Fracturas Graves";
}
if($movimiento==null){
 $detalle2 = "";
}elseif($movimiento==1){
$detalle2= "Sin Movimiento";
}
elseif($movimiento==2){
$detalle2 = "Movimiento Parcial";
}
elseif($movimiento==3){
$detalle2 = "Atrapado";
}
}
  
?>
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.3.js"></script>
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      
    </style>
    
  </head>
  <body onload="init_map(<?php echo $lat;?>,<?php echo $lng;?>)" class="bg-primary">
  <nav class="navbar navbar-light bg-primary">
    <span class="navbar-brand mb-0 h1 text-white">Estatus de Emergencia</span>
  </nav>
  <div class="container" style="height:80vh">
      <div class="row " style="height:100%">
      <div class="col-sm-5 bg-light rounded" style="padding: inherit;width: 100%;height: 60%;">
          <div class="row-sm-1 bg-info rounded" style="position: inherit;z-index:60; width:auto;padding: 10px;color: black;text-align: center;">
          <h5> Telefono : <?php echo $celular;?> </h5></div>
          <div id="map" style="position:relative;z-index:3;"></div>
        </div>
        <div class="col-sm-2 bg-primary" style="height:auto;width:40px;">
          
        </div>
        <div class="col-sm-5 bg-light rounded" style="padding: 90px 20px;text-align: center;height:60%">
          <h2>Mi estado :</h2>
          <h2><?php echo $detalle1;?></h2>
          <h2><?php echo $detalle2;?></h2>
        </div>
      </div>
  </div>
  
  </body>

</html>
<script type="text/javascript">

  
  var map;
 
  function init_map(lat,lng) {
    console.log(lat);
        var map_options = {
            zoom: 17,
            center: new google.maps.LatLng(lat,lng)
          }
        map = new google.maps.Map(document.getElementById("map"), map_options);
       marker = new google.maps.Marker({
            map: map,
            position: new google.maps.LatLng(lat,lng)
        });
      
        infowindow = new google.maps.InfoWindow({
            content: '<strong>Aqui estoy</strong>'
        });
        google.maps.event.addListener(marker, "click", function () {
            infowindow.open(map, marker);
        });
        infowindow.open(map, marker);
    }
    

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=&amp;libraries=geometry,places" async defer></script>
