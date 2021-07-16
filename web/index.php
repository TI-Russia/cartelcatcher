<div style="height= 100vh; background: #ffffff url('images/44fz.jpg'); height: 1000vh; 
background-repeat: no-repeat;
position: relative;
background-size: 100% auto;
background-attachment: scroll;">
<br>

<style>
   div.navbar
    { 
position:absolute;
      top:100px;
      left:300px;
      width:500px;
      height:400px;
    }
span.boxed {
    position:absolute;
    background: #c0E5efc0; /* Цвет фона */
    color: #fff; /* Цвет текста */
    padding: 15px; /* Поля вокруг текста */
    width: 350px;
    height: 20px;
    top: 10px;
    border-radius: 5px; /* Уголки */
   }
.boxed a {font: bold 12px Verdana, Arial, Helvetica, sans-serif; color: #3D3D3D; padding: 0px 0px 0px 10px; text-decoration:none; cursor:pointer;}
.boxed a:hover {font: bold 12px Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF; padding: 0px 0px 0px 10px; text-decoration:none; cursor:pointer;}
  </style>

<?php
 
 include "filer.php";
 include "sql.php";
 echo "
<div class='navbar'>      
<span class='boxed'><a href=orgsex.php>Поиск и просмотр данных по организациям</a><br></span>
        <br>
       <span class='boxed' style='top:80px;'><a href=purchases.php>Поиск и просмотр сведений о закупках </a><br></span>
       <span class='boxed' style='top:160px;'><a href=contractsex.php>Поиск и просмотр сведений по контрактам</a><br></span>
       <span class='boxed' style='top:240px;'><a href=groups.php>Просмотр групп компаний</a><br></span>
       <span class='boxed' style='top:320px;'><a href=cartels.php>Просмотр сведений о картелях</a></span><br>
</div>";
       	

?>
</div>