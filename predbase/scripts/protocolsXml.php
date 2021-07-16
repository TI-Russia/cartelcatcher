<?php 
/*global $flag;
global $nno; //purchasenumber
global $curtag;
global $inn;
global $appd;
global $INNt;
global $wp;
global $fp;
global $rn;  //rn - флаг что мы внутри цены
global $orgname;
global $fullname;
global $taglevel;
*/
    function startElement($parser, $name, $attrs)
    {
//	echo 'open:'.$name."\n";
        global $flag;
	global $curtag;
	global $taglevel;
	global $rn;
	$taglevel=$taglevel+1;
	if (($name=='APPREJECTEDREASON')&&($flag<80)) {$flag=80+$flag;};
	if (($name=='APPLICATION')&&($flag>80)) {$flag=$flag-80;};
        if ((strpos("xx".$name,'PROTOCOLLOT')>0)
		||(strpos("xx".$name,'PROTOCOLINFO')>0)) 
		{ if (($flag==10)||($flag==12)) {$flag=12;} else {$flag=2;};};
        if (strpos("xx".$name,'EF3')>0) { $flag=1;};
	if (strpos("xx".$name,'COSTCRITERIONINFO')>0) {$rn=1;};
                                                               
	if (strpos($name,'LZK')>0) {$flag=1;};
	if (strpos($name,'LEZK')>0) {$flag=1;};
        if (strpos($name,'LOK1')>0) {$flag=10;};              //особый вид протоколов с оценками.
        if (strpos($name,'LEOK3')>0) {$flag=10;};              //особый вид протоколов с оценками.
	if ($flag>0) { $curtag=$name; 
	             };
//	
//echo $name;
//        print_r($attrs);
    }
    function endElement($parser, $name)
    {
    global $flag;
    global $curtag;	
    global $taglevel;
    global $rn;
    $taglevel=$taglevel-1;
    $curtag="";
   
   if (strpos("xx".$name,'COSTCRITERIONINFO')>0) {$rn=0;};
   if (strpos("xx".$name,'CONTRACTCONDITION')>0) {$rn=0;};
    if ($flag==2)
      {
     if (strpos("xx".$name,'PROTOCOLLOT')>0) 
         { $flag=0; };
      }	
    }

  function parseData ($parser, $data)
    {
        global $curtag;
        global $flag;
	global $inn,$INNt;
	global $wp,$ad,$appd,$lot,$lots;
	global $fp,$rn,$nno,$taglevel;

//       if (strpos("xx".$curtag,'NS3:')>0) 
//	{ $curtag=substr($curtag,4); //	  echo $curtag."\n";
//        };
//       if (strpos("xx".$curtag,'NS7:')>0) 
//	{ $curtag=substr($curtag,4); //	  echo $curtag."\n";
//        };
//echo $rn.':'.$flag.':'.$taglevel.':'.$curtag.':'.$data."\n";
       switch ($flag) 
	{
	case 81:
        case 82:
	case 90:
	case 92:
		{ 
		switch ($curtag)
		 {
		 case 'REASON': if ($INNt!=""){
				array_push($inn,$INNt);$INNt="";
				array_push($wp,0);
				array_push($ad,$appd);$appd="";
				array_push($lots,$lot);}; break;
		 };
		};break;
 	case 10:
       	case 1:{                          
		  switch ($curtag)
		 {
      		  case 'NS7:PURCHASENUMBER':
      		  case 'OOS:PURCHASENUMBER':
		  case 'PURCHASENUMBER':$nno=$data;break;
		 }
                };break;
       case 12:{
		  switch ($curtag)
		 {
 		  case 'LOTNUMBER':$lot=$data;break;	
		  case 'NS7:APPDT':
  	          case 'APPDATE':$appd=$data;break;
		  case 'CRITERIONCODE':if ($data=='CP') {$rn=1;};break;
		  case 'INN':
		  case 'NS3:INN': $INNt=$data;break;
		  case 'OFFER':
		  case 'NS7:OFFER':if ($rn==1)
				{ 
				//echo 'offer:'.$INNt.':'.$data.':'.$appd.':'.$lot."\n";
				array_push($inn,$INNt);$INNt="";
				array_push($wp,$data);
				array_push($ad,$appd);$appd="";
				array_push($lots,$lot);
			};
			break;	
		 }
	      };break;
	case 2:{
		  switch ($curtag)
		 {
 		  case 'LOTNUMBER':$lot=$data;break;
		  case 'NS7:APPDT':
	          case 'APPDATE':$appd=$data;break;
		  case 'NS3:INN':
			        if ($fp!="")
				{
				//echo 'Ns3:INN:'.$data.':'.$fp.':'.$appd.':'.$lot."\n";
				array_push($inn,$data);
				array_push($wp,$fp);$fp="";
				array_push($ad,$appd);$appd="";
				array_push($lots,$lot);
				} else {$INNt=$data;};
				break;
		  case 'OOS:INN':
		  case 'INN':$INNt=$data;//array_push($inn,$data);
				break;
		  case 'NS7:FINALPRICE': //keep;
				$fp=$data;break;				
		  case 'PRICE':
		  case 'WINNERPRICE':
       				//echo 'Winnerprice:'.$INNt.':'.$data.':'.$appd.':'.$lot."\n";
				array_push($inn,$INNt);$innt="";
				array_push($wp,$data);
				array_push($ad,$appd);$appd="";
				array_push($lots,$lot);
			break;
		  case 'OOS:ORGANIZATIONNAME':
		  case 'ORGANIZATIONNAME':
 		  default: ;//echo "<-".$curtag."->";
		 };
	      };break;
	};
    }
                                                
function XmlProtocolParse (&$d)
{
$parser = xml_parser_create();
global $flag;
//arrays
global $inn,$wp,$ad,$lots;
global $nno,$fp,$rn,$lot;
global $appd,$ad;
$flag=0;$fp='';$taglevel=0;$appd="";
$inn=array();$wp=array();$ad=array();$lots=array();$nno="";$rn="";$lot=1;
  xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, true);
  xml_set_element_handler($parser, "startElement", "endElement");
  xml_set_character_data_handler($parser,"parseData");
  xml_parse($parser, $d, true);
  xml_parser_free($parser);
 return array($inn,to1251($nno),$wp,$ad,$lots);
}
?>