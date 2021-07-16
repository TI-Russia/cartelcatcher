select [oid]
      ,ltrim(replace(replace(replace(replace(REPlace(REPLACE([phone],'-',''),'+',''),'(',''),')',''),' ',''),'/','')) as phone 
      ,[usecnt]
      ,[weight] into ##fixphones 
  FROM [orgphonesLT] ;

  update ##fixphones set phone= concat('7',substring(phone,2,20)) where (left(phone,1)='8');
  update ##fixphones set phone= concat('7',substring(phone,1,20)) where (left(phone,1)='9');
  update ##fixphones set phone= concat('7',phone)                 where (left(phone,1)<>'7') and len(phone)=10;
  select * from ##fixphones where (left(phone,1)<>'7') order by phone
  select oid,phone,sum(usecnt) as usecnt, sum(weight) as weight from ##fixphones group by oid,phone
  drop table ##fixphones;




update purchases set discount=(select sum(contractsLT.price) as totalSum from contractsLT where purchases.purchasenumber=contractsLT.purchasenumber group by contractslt.purchasenumber)

update purchases set discount=(select sum(contractsLT.price) as totalSum from contractsLT where purchases.purchasenumber=contractsLT.purchasenumber and purchases.lot=contractslt.lot group by contractslt.purchasenumber,contractslt.lot)

 update concurents set sum=(select sum(contractsLT.price) as totalSum from contractsLT where concurents.purchasenumber=contractslt.purchasenumber group by contractslt.purchasenumber)
  where purchasenumber in (select purchasenumber from concurents where sum=0 group by purchasenumber having (count(*) =1));

update concurents set sum=(select sum(contractsLT.price) as totalSum from contractsLT where concurents.purchasenumber=contractslt.purchasenumber group by contractslt.purchasenumber)
  where purchasenumber in (select purchasenumber from concurents where sum=0 group by purchasenumber having (count(*) =1));

  select purchasenumber from concurents where sum=0 group by purchasenumber having (count(*) >1)