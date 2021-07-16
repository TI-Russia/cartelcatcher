<?php
include 'sql.php';
include 'flow.php';
echo "daemon runs\n";

$db=sql_connect();

if (getPending($db,'fileupdatecontracts')==1) {
     echo 'running: update contracts';
     logOpen($db,1,'fileupdatecontracts',0);
     exec("start getc.cmd >nul &");	
     };
if (getPending($db,'fileupdatenotice')==1) {
     echo 'running: update notification';
     logOpen($db,1,'fileupdatenotice',0);
     exec("start getn.cmd >nul &");	
     };
if (getPending($db,'fileupdatetorgi')==1) {
     echo 'running: update torgi';
     logOpen($db,1,'fileupdatetorgi',0);
     exec("start getp.cmd >nul &");	
     };

if (getPending($db,'loadtorgi')==1) {
     echo 'running: loading protocols';
     logOpen($db,1,'loadtorgi',0);
     exec("start loadp.cmd >nul &");	
     };
if (getPending($db,'loadnotice')==1) {
     echo 'running: loading notifications';
     logOpen($db,1,'loadnotice',0);
     exec("start loadn.cmd >nul &");	
     };

if (getPending($db,'loadcontracts')==1) {
     echo 'running: load data';
     logOpen($db,1,'loadcontracts',0);
     exec("start loadc.cmd >nul &");	
     //logOpen($db,0,'loadcontracts',100); 	
     };

//case "loadtorgi":
                   
if (getPending($db,'ConcurentsLTupdate')==1)
   {
     logOpen($db,1,'ConcurentsLTupdate',1);
     execSQLP($db,'declare @r int;execute createConcurentsLT;select @r=1');
     logOpen($db,0,'ConcurentsLTupdate',100);
   }

if (getPending($db,'contractsLTupdate')==1)
   {
     logOpen($db,1,'contractsLTupdate',1);
     execSQLP($db,'declare @r int;execute createcontractsLT;select @r=1');
     logOpen($db,0,'contractsLTupdate',100);
   }
if (getPending($db,'PurchasesLTupdate')==1)
   {
     logOpen($db,1,'PurchasesLTupdate',1);
     execSQLP($db,'declare @r int;execute createpurchasesLT;select @r=1');
     logOpen($db,0,'PurchasesLTupdate',100);
   }

if (getPending($db,'contractsupdate')==1)
   {
     logOpen($db,1,'contractsupdate',1);
     execSQL($db,'declare @r int;execute createcontractsLT;select @r=1');
     logOpen($db,1,'contractsupdate',20);
     execSQLP($db,'declare @r int;execute createOrgphonesEx;select @r=1;select @r');
     logOpen($db,1,'contractsupdate',30);
     execSQLP($db,'declare @r int;execute cleanupPhones;select @r=1;select @r');
     logOpen($db,1,'contractsupdate',40);
     execSQLP($db,'declare @r int;execute CreateOrgphonesLT_NonUsed;select @r=1;select @r');
     logOpen($db,1,'contractsupdate',50);
     execSQLP($db,'declare @r int;execute createOrgEmailsEx;select @r=1;select @r');
     logOpen($db,1,'contractsupdate',70);
     execSQLP($db,'declare @r int;execute createOrgEmailsLT;select @r=1;select @r');
     logOpen($db,1,'contractsupdate',90);
     execSQLP($db,'declare @r int;execute cleanupEmails;select @r=1;select @r');
     logOpen($db,0,'contractsupdate',100);
    };
if (getPending($db,'findgroups')==1) {
     echo 'running: find cartels';
     logOpen($db,1,'findgroups',0);
     $sql='execute findallgroupsLT;'; $stmt = sqlsrv_query ($db, $sql);  sqlsrv_free_stmt($stmt);		
     logOpen($db,0,'findgroups',100); 	
     };

if (getPending($db,'findcartels')==1) {
     echo 'running: find cartels';
     logOpen($db,1,'findcartels',0);
//     $sql='execute cleanupPhonesLTC;';  $stmt = sqlsrv_query ($db, $sql);  sqlsrv_free_stmt($stmt);		
//     logOpen($db,1,'findcartels',1);
     $sql='execute findallcartels;'; $stmt = sqlsrv_query ($db, $sql);  sqlsrv_free_stmt($stmt);		
     logOpen($db,0,'findcartels',100); 	
//     exec("start getc.cmd >nul &");	
     };

sql_close($db);
?>