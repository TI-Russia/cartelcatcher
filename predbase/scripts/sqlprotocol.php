
<?php
global $sql_id;
include "commonsql.php";

function getoid($id,$inn)
 {
   $stmt = sqlsrv_query ($id, "select oid from orgs where inn='".$inn."';");
   $coid=0;
   if( $stmt === false ) {
	$f=fopen('prot_errors.log','a+');
         fwrite($f,toutf(sqlsrv_errors()[0][2])."\n");
	 fwrite($f,'error finding inn:'.toutf($inn)."\n"); 
	fclose($f);
            } else  
	{
	while($row = sqlsrv_fetch_array($stmt)) 
           	{  $coid=$row[0];  }
	sqlsrv_free_stmt($stmt);  	
	}
    return $coid;
  }
function execSQLP($db,$sql)
{
//  echo 'running:'.$sql."\n";
  $stmt = sqlsrv_query ($db, $sql);
  sqlsrv_free_stmt($stmt);
  return true;
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

function exec_sql($id,$args)
 { 
 $rs=$args[1];$n=count($args[0]);
if ($n>=1)
{
 for ($i=0; $i<$n;$i++) 
   { $inn=$args[0][$i];
     if ($inn!="")  //нахер пустые данные
    {	
     $sum=$args[2][$i];$oid=getoid($id,$inn);
     if ($sum=="") {$sum=0;}; 	
     $tm=_sql_validate_value($args[3][$i]);
     $lot=$args[4][$i];
  $sql="if not exists (select * from concurents where oid=".$oid." and purchasenumber='".$rs."' and lot=".$lot. " )\n
               BEGIN insert into dbo.concurents (purchasenumber,oid,sum,appdate,lot) 
                                       values ('".$rs."',".$oid.",".$sum.",".$tm.",".$lot.");
					end;";
   $stmt = sqlsrv_query ($id, $sql);
  if( $stmt === false ) {
	$f=fopen('prot_errors.log','a+');fwrite($f,toutf(sqlsrv_errors()[0][2])."\n");
	 fwrite($f,toutf($sql)."\n"); fclose($f);
            } else  {sqlsrv_free_stmt($stmt);  	}
   };
   };
  }  	
 }
?>
