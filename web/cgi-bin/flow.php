<?php
include 'filer.php';
function execSQLP($db,$sql)
{
  echo 'running:'.$sql."\n";
  $stmt = sqlsrv_query ($db, $sql);
  sqlsrv_free_stmt($stmt);
  return true;
};

function execSQL($db,$sql)
{
  echo 'running:'.$sql."\n";
  $stmt = sqlsrv_query ($db, $sql);
  if( $stmt === false ) { echo ($sql.'<br>'); die(toutf(sqlsrv_errors()[0][2])); }
  sqlsrv_free_stmt($stmt);
  return true;
};

function getPending($db,$proc)
{

  $sql="select count (*) from workflow where (laststatus=2) and (pendingprocedure='".$proc."')";
//  echo $sql."\n";
  $stmt = sqlsrv_query ($db, $sql);
  if( $stmt === false ) { echo ($sql.'<br>'); die(toutf(sqlsrv_errors()[0][2])); }
   while($row = sqlsrv_fetch_array($stmt)) 
   {
    $r=$row[0]; echo $r;
    }
  sqlsrv_free_stmt($stmt);	
  return $r;
};
function logOpen($db,$id,$func,$done)
 {
$r='';  
$sql='declare @re int; 
	execute @re=logOperation '.$id.','.$func.','.$done.';select @re;';
  $stmt = sqlsrv_query ($db, $sql);
  if( $stmt === false ) { echo ($sql.'<br>'); die(toutf(sqlsrv_errors()[0][2])); }
   while($row = sqlsrv_fetch_array($stmt)) 
  {  $r=$row[0]; }
   sqlsrv_free_stmt($stmt);
   return $r;
 };
?>
