<?php
echo "zip parser ver 1.0\r\n";
parse_str(implode('&', array_slice($argv, 1)), $_GET);
 if (!isset($_GET['dir']))
{
$dir="./ftp.zakupki.gov.ru/fcs_regions/";} else 
{$dir=$_GET['dir'];}

//$dir="./ftp.zakupki.gov.ru/fcs_regions/";
 $fname = array();

include 'filer.php';
include 'protocolsxml.php';
include 'sqlprotocol.php';
$fname=scanfiles($dir);
echo $dir .' '. count($fname)."\n";
$sql_id=sql_connect();
// logging data loading 
//   logOpen($sql_id,1,'loadtorgi',1);$prc=1;
   $d=count($fname);
   for($n=0; $n<count($fname); $n++) 
    { 
        $t = $fname[$n];
if ((strpos($t,"rotoco")!==false)&&(strpos($t,"Month")==false))
 {
   $t1 = pathinfo($t);$fx=$t1['basename'];	
	echo $n.":".$fx."\r";
	$d=checkAddFile($sql_id,$fx,0,2);
     if ($d==0) 
      {
        $zip = new ZipArchive();
         if ($zip->open($t, ZIPARCHIVE::CHECKCONS)==true)
           { for ($i = 0 ; $i < $zip->numFiles; $i++) 
		{ $fn=$zip->getNameIndex($i);
                 if (strpos($fn,".xml")!==false) 
	   		{ if (
 				(strpos($fn,"EF3_")!==false)||(strpos($fn,"EFSing")!==false)||(strpos($fn,"lPRO_")!==false)||(strpos($fn,"lPPI")!==false)
				||(strpos($fn,"lOK1")!==false)||(strpos($fn,"lZK")!==false)||(strpos($fn,"lOU2")!==false)
				)
              		 { 
		 		$buf=$zip->getfromindex($i);
     				$fd=XmlProtocolParse($buf);
			        exec_sql($sql_id,$fd);		
	        		unset($fd);unset($buf);
			 }
	    	}
		}
	    if ($zip->numFiles>0) {$zip->close();};
	  }
	unset($zip);
	$d=checkAddFile($sql_id,$fx,1,2);
       };	

      } //true file
  } //files for

  sql_close($sql_id);

?>