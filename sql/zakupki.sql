USE [master]
GO
/****** Object:  Database [zakupki]    Script Date: 16.07.2021 17:57:42 ******/
CREATE DATABASE [zakupki]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'zakupki', FILENAME = N'G:\Zakupki\zakupki.mdf' , SIZE = 35257984KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'zakupki_log', FILENAME = N'G:\Zakupki\Zakupki_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%), 
( NAME = N'zakupki_log1', FILENAME = N'G:\Zakupki\zakupki_log1.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [zakupki] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [zakupki].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [zakupki] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [zakupki] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [zakupki] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [zakupki] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [zakupki] SET ARITHABORT OFF 
GO
ALTER DATABASE [zakupki] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [zakupki] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [zakupki] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [zakupki] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [zakupki] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [zakupki] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [zakupki] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [zakupki] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [zakupki] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [zakupki] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [zakupki] SET  DISABLE_BROKER 
GO
ALTER DATABASE [zakupki] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [zakupki] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [zakupki] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [zakupki] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [zakupki] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [zakupki] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [zakupki] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [zakupki] SET RECOVERY FULL 
GO
ALTER DATABASE [zakupki] SET  MULTI_USER 
GO
ALTER DATABASE [zakupki] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [zakupki] SET DB_CHAINING OFF 
GO
ALTER DATABASE [zakupki] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [zakupki] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'zakupki', N'ON'
GO
USE [zakupki]
GO
/****** Object:  UserDefinedTableType [dbo].[oidlist]    Script Date: 16.07.2021 17:57:43 ******/
CREATE TYPE [dbo].[oidlist] AS TABLE(
	[id] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[phonelist]    Script Date: 16.07.2021 17:57:43 ******/
CREATE TYPE [dbo].[phonelist] AS TABLE(
	[phone] [varchar](20) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[addContract]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addContract] 
	-- Add the parameters for the stored procedure here
	@oid int,
	@num varchar(22),
	@id  varchar(22),
	@pid varchar(22),
	@email varchar(100),
	@phone varchar(20),
	@price float,
	@date  date,
	@coid  int,
	@reg   int,
	@ver   int,
	@lot   int
	
	AS
	declare @tid int;
	declare @over int;
BEGIN
	SET NOCOUNT ON;
	 select @tid=(select  top 1 id FROM [contracts] WHERE [contractid]=@id and [oid]=@oid);
	if (@tid>0)
begin 
	  update [contracts] set contactemail=@email ,contactphone=@phone, ver=@ver, price=@price, coid=@coid, reg=@reg, date=@date, lot=@lot WHERE id=@tid;
end 
else
	 begin 
	  insert into [contracts] (oid,contractnumber,contractid,purchasenumber, contactemail,contactphone,price, coid, reg, date, ver,lot) values (@oid, @num, @id, @pid, @email, @phone,@price, @coid,@reg, @date, @ver,@lot);
	  SELECT @tid = @@IDENTITY;
	 end;
	 return @tid;
    END

GO
/****** Object:  StoredProcedure [dbo].[addContract1]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addContract1] 
	-- Add the parameters for the stored procedure here
	@oid int,
	@num varchar(22),
	@id  varchar(22),
	@pid varchar(22),
	@email varchar(100),
	@phone varchar(20),
	@price float,
	@ver   int
	
	AS
	declare @tid int;
	declare @over int;
BEGIN
	SET NOCOUNT ON;
	 select @tid=(select  top 1 id FROM [contracts1] WHERE [contractid]=@id and [oid]=@oid);
	if (@tid>0)
begin 
	  update [contracts1] set contactemail=@email ,contactphone=@phone, ver=@ver, price=@price  WHERE id=@tid;
end 
else
	 begin 
	  insert into [contracts1] (oid,contractnumber,contractid,purchasenumber, contactemail,contactphone,price,ver) values (@oid, @num, @id, @pid, @email, @phone,@price,@ver);
	  SELECT @tid = @@IDENTITY;
	 end;
	 return @tid;
    END


GO
/****** Object:  StoredProcedure [dbo].[addLoadedFile]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addLoadedFile] 
	-- Add the parameters for the stored procedure here
	@fn varchar(100),
	@mode int,
	@datatype int
	 
	
	AS
	declare @tid int;
 
BEGIN
	SET NOCOUNT ON;
	 select @tid=(select  top 1 id FROM [LoadedFiles] WHERE [filename]=@fn and [datatype]=@datatype);
	if (@tid>0)and(@mode=1)
begin 
	  update [LoadedFiles] set loaded=1, dateload=getdate() WHERE id=@tid;
end 
else 
 if (@tid>0) begin return @tid; end
       else 
	    begin
	      insert into [LoadedFiles] (filename,datatype) values (@fn,@datatype);
  	      SELECT @tid = 0;
	    end;
	 return @tid;
    END


GO
/****** Object:  StoredProcedure [dbo].[addOrg]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addOrg] 
	-- Add the parameters for the stored procedure here
	@inn varchar(12),
	@name varchar(200),
	@email varchar(100),
	@phone varchar(20) --,
	--@tid int output
	AS
	declare  @tid int,@res int,@_name varchar(200),
			@_email varchar(100),@_phone varchar(20)
 
BEGIN
	SET NOCOUNT ON;
	select @tid=[oid],@_name=[name] from [orgs]  where inn=@inn;
	if (@tid>0)
	 begin
	 -- print @tid;
	 if ((len(@_name)=0)and(len(@name)>0))
		begin 
		  update [orgs] set [name]=@name where [oid]=@tid;
		end;
	 end 
	 else
	 begin 
	  insert into [orgs] (name,inn,email,phone,n_phones,n_mails) values (@name, @inn, @email, @phone,0,0);
	  SELECT @tid = @@IDENTITY;
	 end;
	return @tid;
    END

GO
/****** Object:  StoredProcedure [dbo].[cleanupEmails]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cleanupEmails] 
	 as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
truncate table orgeMailsLT;
update orgEmailsEx set usecnt=(select cnt from dbo.DoubleMailsEx where doubleMailsEx.email=orgemailsEx.email);
insert into orgemailsLT(oid,email,usecnt,weight) select oid,email,usecnt,weight from orgemailsEx where (usecnt>1)and(usecnt<20)and(weight>1);
--delete from orgemailsLT where not exists  (select * from concurents where concurents.oid=OrgemailsLT.oid);

delete from orgEmailsLT where (oid in(select oid from orgs where inn=''));
delete from orgEmailsLT where (oid in(select oid from getbanksID(0)));
delete from orgemailsLT where oid in (18079,18287,19295,19388,17734,17767,23874,31278,19407,17986,93396,238602,59345,29361,94252,80354,42599,17883,24274,68988,18778,20619,61500,162954,240464,84050,528524,51372,225521,103868,70722,19872,19899,22186,42924,19396,69158,17778);
delete from orgemailsLT where oid in (241269,339992,195596,192347,123789,20205,585785,17999,159518,21229,68990,28271,115216,25709,19869,256884,208682,17728,103053,61503,42663,53400,40231,74030,264541,93395,124519,181066,184736,143686,17755,18724,20224,19304);
update orgemailsLT set usecnt=(select cnt from dbo.DoubleMailsLT where doublemailsLT.email=orgemailsLT.email);


END


GO
/****** Object:  StoredProcedure [dbo].[cleanupPhones]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cleanupPhones] 
	 as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
truncate table  orgphonesLT;
update orgphonesEx set usecnt=(select cnt from dbo.DoublePhonesEx where doublephonesEx.phone=orgphonesEx.phone);
insert into orgphonesLT (oid,phone,usecnt,weight) select oid,phone,usecnt,weight from orgphonesEx where (usecnt>1)and(usecnt<20)and(weight>1);
-- delete from orgphonesLT where not exists  (select * from concurents where concurents.oid=OrgphonesLT.oid);
delete from orgphonesLT where phone like '%0-0-0%';
delete from orgphonesLT where phone like '%123123123%';
delete from orgphonesLT where phone like '%0000000%';
delete from orgphonesLT where phone like '%7-777-7%';
delete from orgphonesLT where phone like '%7777777';
delete from orgphonesLT where phone like '7-000%';
delete from orgphonesLT where phone like '7-111%';
delete from orgphonesLT where phone like '%1234567';
delete from orgphonesLT where phone like '%5555555';
delete from orgphonesLT where phone like '%0010101';
delete from orgphonesLT where phone like '%222222';
delete from orgphonesLT where phone like '%111111';
delete from orgphonesLT where phone like '%000000%';
delete from orgphonesLT where phone like '%999999';
delete from orgphonesLT where phone like '%0-0000%';
delete from orgphonesLT where phone like '%--%';
delete from orgphonesLT where phone like '%доб%';
delete from orgphonesLT where phone like '%a%';
delete from orgphonesLT where phone like '%нет%';
delete from orgphonesLT where len(ltrim(phone))<8;
delete from orgphonesLT where (oid in(select oid from orgs where inn=''));
delete from orgphonesLT where (oid in(select oid from getbanksID(0)));
delete from orgphonesLT where oid in (18079,18287,19295,19388,17734,17767,23874,31278,19407,17986,93396,238602,59345,29361,94252,80354,42599,17883,24274,68988,18778,20619,61500,162954,240464,84050,528524,51372,225521,103868,70722,19872,19899,22186,42924,19396,69158,17778);
delete from orgphonesLT where oid in (241269,339992,195596,192347,123789,20205,585785,17999,159518,21229,68990,28271,115216,25709,19869,256884,208682,17728,103053,61503,42663,53400,40231,74030,264541,93395,124519,181066,184736,143686,17755,18724,20224,19304);
update orgphonesLT set usecnt=(select cnt from dbo.DoublePhonesLT where doublephonesLT.phone=orgphonesLT.phone);
update orgs set n_phonesLT=0;
update orgs set n_phonesLT=(select count(*) from dbo.orgphonesLT where orgphonesLT.oid=orgs.oid);
update orgs set contracts=(select count(*) from contractslt where contractslt.oid=orgs.oid);	
update orgs set summ=(select sum(price) from contractslt where contractslt.oid=orgs.oid);
END

GO
/****** Object:  StoredProcedure [dbo].[cleanupPhonesLTC]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cleanupPhonesLTC] 
	 as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
delete from orgphonesLTC;
update orgphonesEx set usecnt=(select cnt from dbo.DoublePhonesEx where doublephonesEx.phone=orgphonesEx.phone);
insert into orgphonesLTC (oid,phone,usecnt,weight) select oid,phone,usecnt,weight from orgphonesEx where (usecnt>1)and(usecnt<20)and(weight>1);
delete from orgphonesLTC where not exists  (select * from concurents where concurents.oid=OrgphonesLTC.oid);
delete from orgphonesLTC where phone like '%7777777';
delete from orgphonesLTC where phone like '%1234567';
delete from orgphonesLTC where phone like '%5555555';
delete from orgphonesLTC where phone like '%0010101';
delete from orgphonesLTC where phone like '%222222';
delete from orgphonesLTC where phone like '%111111';
delete from orgphonesLTC where phone like '%000000%';
delete from orgphonesLTC where phone like '%999999';
delete from orgphonesLTC where phone like '%000000%';
delete from orgphonesLTC where phone like '%доб%';
delete from orgphonesLTC where phone like '%a%';
delete from orgphonesLTC where phone like '%нет%';
delete from orgphonesLTC where len(ltrim(phone))<8;
delete from orgphonesLTC where (oid in(select oid from orgs where inn=''));
delete from orgphonesLTC where (oid in(select oid from getbanksID(0)));
delete from orgphonesLTC where oid in (18079,18287,19295,19388,17734,17767,23874,31278,19407,17986,93396,238602,59345,29361,94252,80354,42599,17883,24274,68988,18778,20619,61500,162954,240464,84050,528524,51372,225521,103868,70722,19872,19899,22186,42924,19396,69158,17778);
delete from orgphonesLTC where oid in (241269,339992,195596,192347,123789,20205,585785,17999,159518,21229,68990,28271,115216,25709,19869,256884,208682,17728,103053,61503,42663,53400,40231,74030,264541,93395,124519,181066,184736,143686,17755,18724,20224,19304);
update orgphonesLTC set usecnt=(select cnt from dbo.DoublePhonesLTC where doublephonesLTC.phone=orgphonesLTC.phone);
--update orgs set n_phonesLT=0;
--update orgs set n_phonesLT=(select count(*) from dbo.orgphonesLT where orgphonesLT.oid=orgs.oid);
--update orgs set contracts=(select count(*) from contractslt where contractslt.oid=orgs.oid);	
--update orgs set summ=(select sum(price) from contractslt where contractslt.oid=orgs.oid);
END


GO
/****** Object:  StoredProcedure [dbo].[createConcurentsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[createConcurentsLT] 
	-- Add the parameters for the stored procedure here
	
	
	AS
	BEGIN
	SET NOCOUNT ON;
	exec logOperation 1, 'ConcurentsLTupdate',1;
	truncate table ConcurentsLT;
	exec logOperation 1, 'ConcurentsLTupdate',10;
	insert into concurentsLT (purchasenumber,oid,cartelid,sum,appdate,lot)
     select [purchasenumber],[oid],
			(select top 1 gid from orgs where orgs.oid=concurents.oid) as cartelid,
			sum,appdate,lot 
		  from concurents where oid>0;
	exec logOperation 1, 'ConcurentsLTupdate',90;
	exec logOperation 0, 'ConcurentsLTupdate',100;
    END


GO
/****** Object:  StoredProcedure [dbo].[createContractsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[createContractsLT] 
	-- Add the parameters for the stored procedure here
	
	
	AS
	BEGIN
	SET NOCOUNT ON;
	exec logOperation 1, 'contractsLTupdate',1;
	truncate table contractslt;
	dbcc checkident('contractsLT',reseed,0);
	exec logOperation 1, 'contractsLTupdate',10;
	update contracts set contactphone=concat('7',substring(contactphone,4,20))  where (left(contactphone,3)='64-') and (len(contactphone)>10);
	update contracts set contactphone=substring(contactphone,5,20)  where (left(contactphone,4)='643-') and (len(contactphone)>10);
	exec logOperation 1, 'contractsLTupdate',25;
    update contracts set contactphone=substring(contactphone,5,20)  where (left(contactphone,4)='643 ') and (len(contactphone)>10);
	exec logOperation 1, 'contractsLTupdate',35;
	insert into contractslt (oid,contractnumber,contactphone,contactemail,purchasenumber,contractid,price,date,coid,reg,ver,lot)
     select [oid],[contractnumber],ltrim(replace(replace(replace(replace(REPlace(REPLACE([contactphone],'-',''),'+',''),'(',''),')',''),' ',''),'/','')) as contactphone,
	   [contactemail],[purchasenumber],[contractid],[price],[date],[coid],[reg],[ver],[lot] 
		  from contracts as co where (contractnumber=co.contractnumber)and 
				(ver=(SELECT MAX(ver) FROM contracts AS co2 WHERE co.contractnumber = co2.contractnumber));
	--update contractslt set contactphone=concat('7',substring(contactphone,4,20))  where (left(contactphone,3)='64-') and (len(contactphone)>10);
	--update contractslt set contactphone=substring(contactphone,5,20)  where (left(contactphone,4)='643-') and (len(contactphone)>10);
	--update contractslt set contactphone=ltrim(replace(replace(replace(replace(REPlace(REPLACE([contactphone],'-',''),'+',''),'(',''),')',''),' ',''),'/',''));
	exec logOperation 1, 'contractsLTupdate',70;
	update orgs set contracts=(select count(*) from contracts where contracts.oid=orgs.oid);
	exec logOperation 1, 'contractsLTupdate',90;
	update orgs set summ=(select sum(price) from contracts where contracts.oid=orgs.oid);
	exec logOperation 1, 'contractsLTupdate',90;
	update contractslt set contactphone= concat('7',substring(contactphone,2,20)) where (left(contactphone,1)='8');
	exec logOperation 1, 'contractsLTupdate',95;
    update contractsLT set contactphone= concat('7',substring(contactphone,1,20)) where (left(contactphone,1)='9' and len(contactphone)<20);
	exec logOperation 1, 'contractsLTupdate',98;
    update contractsLT set contactphone= concat('7',contactphone)                 where (left(contactphone,1)<>'7') and len(contactphone)=10;
	exec logOperation 1, 'contractsLTupdate',99;
    END


GO
/****** Object:  StoredProcedure [dbo].[createOrgEmailsEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[createOrgEmailsEx] 
	-- Add the parameters for the stored procedure here
	
	
	AS
	BEGIN
	SET NOCOUNT ON;
	delete from orgEmailsEx;dbcc checkident('orgEmailsEx',reseed,0);
	insert into orgEmailsEx (oid,email,weight) (select [oid],contactemail,count(*) as cnt 
	from contractsLT group by contractslt.oid,contractslt.contactemail )
    END


GO
/****** Object:  StoredProcedure [dbo].[createOrgphonesEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- (c) MKC
CREATE PROCEDURE [dbo].[createOrgphonesEx] 
	AS
	BEGIN
	SET NOCOUNT ON;
	update contractslt set contactphone=concat('7',substring(contactphone,4,20))  where (left(contactphone,3)='64-') and (len(contactphone)>10);
	update contractslt set contactphone=ltrim(replace(replace(replace(replace(REPlace(REPLACE([contactphone],'-',''),'+',''),'(',''),')',''),' ',''),'/',''));
	update contractslt set contactphone= concat('7',substring(contactphone,2,19)) where (left(contactphone,1)='8');
    update contractsLT set contactphone= concat('7',substring(contactphone,1,19)) where (left(contactphone,1)='9');
    update contractsLT set contactphone= concat('7',contactphone)                 where (left(contactphone,1)<>'7') and len(contactphone)=10;
	delete from orgphonesEx;dbcc checkident('orgphonesEx',reseed,0);
	insert into orgphonesEx (oid,phone,weight) (select [oid],contactphone,count(*) as cnt 
	from contractsLT group by contractslt.oid,contractslt.contactphone )
    END


GO
/****** Object:  StoredProcedure [dbo].[CreateOrgphonesLT_NonUsed]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateOrgphonesLT_NonUsed] 
	 as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
truncate table  orgphonesLT_NonUsed;
update orgphonesEx set usecnt=(select cnt from dbo.DoublePhonesEx where doublephonesEx.phone=orgphonesEx.phone);
insert into orgphonesLT_NonUsed (oid,phone,usecnt,weight) select oid,phone,usecnt,weight from orgphonesLT where (usecnt is NULL);
delete from orgphonesLT where usecnt is NULL;
update orgphonesLT set usecnt=(select cnt from dbo.DoublePhonesLT where doublephonesLT.phone=orgphonesLT.phone);
update orgs set n_phonesLT=0;
update orgs set n_phonesLT=(select count(*) from dbo.orgphonesLT where orgphonesLT.oid=orgs.oid);	
END

GO
/****** Object:  StoredProcedure [dbo].[createPurchasesLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[createPurchasesLT] 
	-- Add the parameters for the stored procedure here
	
	
	AS
	BEGIN
	SET NOCOUNT ON;
	exec logOperation 1, 'PurchasesLTupdate',1;
	truncate table PurchasesLT;
	exec logOperation 1, 'PurchasesLTupdate',10;
	insert into purchaseslt (purchasenumber,coid,maxprice,date,status,cphone,cemail,lot,okpd,name,type)
     select [purchasenumber],[coid],maxprice,date,status,ltrim(replace(replace(replace(replace(REPlace(REPLACE([cphone],'-',''),'+',''),'(',''),')',''),' ',''),'/','')) as cphone,
	   [cemail],[lot],[okpd],[name],[type] 
		  from purchases as co where (purchasenumber=co.purchasenumber)and 
				(id=(SELECT MAX(id) FROM purchases AS co2 WHERE co.purchasenumber = co2.purchasenumber));
	--update contractslt set contactphone=concat('7',substring(contactphone,4,20))  where (left(contactphone,3)='64-') and (len(contactphone)>10);
	--update contractslt set contactphone=substring(contactphone,5,20)  where (left(contactphone,4)='643-') and (len(contactphone)>10);
	--update contractslt set contactphone=ltrim(replace(replace(replace(replace(REPlace(REPLACE([contactphone],'-',''),'+',''),'(',''),')',''),' ',''),'/',''));
	exec logOperation 1, 'PurchasesLTupdate',60;
	update purchasesLt set oid=(select top 1 oid from contractslt where (PurchasesLt.purchasenumber=Contractslt.purchasenumber and purchasesLT.lot=contractslt.lot));
	exec logOperation 1, 'PurchasesLTupdate',70;
	update purchasesLt set coid=(select top 1 coid from contractslt where (PurchasesLt.purchasenumber=Contractslt.purchasenumber and purchasesLT.lot=contractslt.lot)) where coid=0;
	exec logOperation 1, 'PurchasesLTupdate',80;
	update purchasesLT set discount=(select sum(contractsLT.price) as totalSum from contractsLT where purchasesLT.purchasenumber=contractsLT.purchasenumber and purchasesLT.lot=contractslt.lot group by contractslt.purchasenumber,contractslt.lot);
	exec logOperation 1, 'PurchasesLTupdate',90;
	update purchaseslt set cphone= concat('7',substring(cphone,2,20)) where (left(cphone,1)='8');
	exec logOperation 1, 'PurchasesLTupdate',95;
    update purchasesLT set cphone= concat('7',substring(cphone,1,20)) where (left(cphone,1)='9' and len(cphone)<20);
	exec logOperation 1, 'PurchasesLTupdate',98;
    update purchasesLT set cphone= concat('7',cphone)                 where (left(cphone,1)<>'7') and len(cphone)=10;
	exec logOperation 0, 'PurchasesLTupdate',100;
    END


GO
/****** Object:  StoredProcedure [dbo].[createZakPhonesEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- (c) MKC
CREATE PROCEDURE [dbo].[createZakPhonesEx] 
	AS
	BEGIN
	SET NOCOUNT ON;
	update purchases set cphone=concat('7',substring(cphone,4,20))  where (left(cphone,3)='64-') and (len(cphone)>10);
	update purchases set cphone=ltrim(replace(replace(replace(replace(REPlace(REPLACE([cphone],'-',''),'+',''),'(',''),')',''),' ',''),'/',''));
	update purchases set cphone= concat('7',substring(cphone,2,20)) where (left(cphone,1)='8');
    update purchases set cphone= concat('7',substring(cphone,1,20)) where (left(cphone,1)='9');
    update purchases set cphone= concat('7',cphone)                 where (left(cphone,1)<>'7') and len(cphone)=10;
	truncate table ZakPhonesEx;dbcc checkident('ZakphonesEx',reseed,0);
	insert into ZakPhonesEx (oid,phone,weight) (select [coid],cphone,count(*) as cnt 
	from purchases group by purchases.coid,purchases.cphone )
    END


GO
/****** Object:  StoredProcedure [dbo].[DropDatabase]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DropDatabase]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/****** Object:  Table [dbo].[orgs]    Script Date: 08.03.2020 12:01:35 ******/
Delete from [dbo].[orgs];
delete from [dbo].[orgemails];
delete from [dbo].[orgphones];
delete from [dbo].[contracts];
END

GO
/****** Object:  StoredProcedure [dbo].[findAllCartels]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findAllCartels]
	( @dept int = 2
	
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @t oidlist;declare @z int;declare @ph varchar(20);declare @o int;declare @startz int;declare @n int;
delete from cartels;
dbcc checkident('cartels',reseed,0);
exec logOperation 1, 'findcartels',1;
update orgs set cid=0;
exec logOperation 1, 'findcartels',2;
select ROW_NUMBER() OVER(ORDER BY cartelid ASC) AS Row#,cartelid,count(*) as cnt  into ##tmpcartels from doubleconcurents group by cartelid;
select * into #dblc from doubleconcurents;
delete from #dblc where purchasenumber='';
CREATE NONCLUSTERED INDEX #bycid ON [#dblc] (Cartelid) include (purchasenumber);
exec logOperation 1, 'findcartels',10;
select A.oid,A.cartelid as gid,row# as cid into #tmporgs from (select oid,concurentsLT.cartelid from #dblc join concurentsLT on (concurentsLT.purchasenumber=#dblc.purchasenumber)and(concurentsLT.cartelid=#dblc.cartelid) group by oid,concurentsLT.cartelid) as A
        join ##tmpcartels on a.cartelid=##tmpcartels.cartelid;
exec logOperation 1, 'findcartels',15;
update orgs set cid=(select top 1 cid from #tmporgs where orgs.oid=#tmporgs.oid);
drop table #tmporgs;
--update orgs set cid=(select Row# from ##tmpcartels where gid=cartelid) where oid in 
--		(select A.oid from 
--			(select oid from concurents where purchasenumber in (select purchasenumber from #dblc where cartelid=orgs.gid))as A where oid>0);
exec logOperation 1, 'findcartels',20;
insert into cartels (oid,gid,total) select row#,cartelid,cnt from ##tmpcartels;
exec logOperation 1, 'findcartels',30;
drop table ##tmpcartels;

exec logOperation 1, 'findcartels',60;
update cartels set count=(select count(*) from orgs where orgs.cid=cartels.id);
delete from cartels where count<2;
exec logOperation 1, 'findcartels',70;
update cartels set total=(select count(*) from #dblc where cartelid=cartels.gid);
-- in (select oid from orgs where orgs.cid=cartels.id));
exec logOperation 1, 'findcartels',85;
update cartels set sum=(select sum(price) from contractsLt where purchasenumber in (select purchasenumber from #Dblc where cartelid=cartels.gid));
update cartels set NMCKsum=(select sum(maxPrice) from purchasesLT where purchasenumber in (select purchasenumber from #Dblc where cartelid=cartels.gid))
exec logOperation 1, 'findcartels',90;
truncate table cartelregs;
insert into cartelregs (cid, reg, cnt)
select orgs.cid, contractslt.reg, count(*) as cnt from contractslt join orgs on orgs.oid=contractslt.oid 
  where contractslt.purchasenumber in (select purchasenumber from #dblc group by purchasenumber)
    group by orgs.cid,contractslt.reg order by cid;
	delete from cartelregs where reg is NULL;
	delete from cartelregs where reg =0;
drop table #dblc;
exec logOperation 1, 'findcartels',100;
END

GO
/****** Object:  StoredProcedure [dbo].[findAllCartelsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findAllCartelsLT]
	( @dept int = 2
	
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @t oidlist;declare @z int;declare @ph varchar(20);declare @o int;declare @startz int;declare @n int;
delete from cartels;
dbcc checkident('cartels',reseed,0);
update orgs set cid=0;
 select phone into ##phoneslst from orgphonesLTC group by phone;
 select @z=(select count(*) from ##phoneslst);select @startz=@z;
 while (@z<>0)
 begin
 select @ph=(select top( 1) [phone] from ##phoneslst);
 select @z =(select top 1 oid from orgphonesLTC where phone=@ph);
 insert into @t (id) execute findclusterbyorgLTC @z, @dept;
 --select * from orgs where oid in (select * from @t)
select @z=(select count(*) from @t);
select @o=(select top(1) id from @t);
insert into cartels (oid,count) values (@o, @z);
SELECT @o = @@IDENTITY;
update orgs set [cid]=@o where [oid] in (select id from @t);
delete from ##phoneslst where phone in (select phone from findphonesbyorgsLTC (@t));
select @z=(select count(*) from ##phoneslst);delete from @t;
select @n=90-round((1.0*@z/@startz),2)*90;
exec logOperation 1, 'findcartels',  @n;
end;
drop table ##phoneslst;
exec logOperation 1, 'findcartels',90;
update cartels set count=(select count(*) from orgs where orgs.cid=cartels.id);
delete from cartels where count<2;
exec logOperation 1, 'findcartels',92;
update cartels set total=(select count(*) from contractsLt where oid in (select oid from orgs where orgs.cid=cartels.id));
exec logOperation 1, 'findallcartels',95;
update cartels set sum=(select sum(price) from contractsLt where oid in (select oid from orgs where orgs.cid=cartels.id));
exec logOperation 1, 'findcartels',98;
truncate table cartelregs;
insert into cartelregs (cid, reg, cnt)
select orgs.cid, contractslt.reg, count(*) as cnt from contractslt join orgs on orgs.oid=contractslt.oid 
    group by orgs.cid,contractslt.reg order by cid;
	delete from cartelregs where reg is NULL;
	delete from cartelregs where reg =0;

exec logOperation 1, 'findcartels',100;
END

GO
/****** Object:  StoredProcedure [dbo].[findAllCartelsOld]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findAllCartelsOld]
	( @dept int = 2
	
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @t oidlist;declare @z int;declare @ph varchar(20);declare @o int;declare @startz int;declare @n int;
delete from cartels;
dbcc checkident('cartels',reseed,0);
exec logOperation 1, 'findcartels',1;
update orgs set cid=0;
exec logOperation 1, 'findcartels',2;
select ROW_NUMBER() OVER(ORDER BY cartelid ASC) AS Row#,cartelid  into ##tmpcartels from doubleconcurents group by cartelid;
exec logOperation 1, 'findcartels',10;
update orgs set cid=(select Row# from ##tmpcartels where gid=cartelid) where oid in 
		(select oid from concurents where oid>0 and purchasenumber in (select purchasenumber from doubleconcurents where cartelid=orgs.gid));
exec logOperation 1, 'findcartels',20;
insert into cartels (oid,gid) select row#,cartelid from ##tmpcartels;
exec logOperation 1, 'findcartels',30;
drop table ##tmpcartels;

exec logOperation 1, 'findcartels',90;
update cartels set count=(select count(*) from orgs where orgs.cid=cartels.id);
delete from cartels where count<2;
exec logOperation 1, 'findcartels',92;
update cartels set total=(select count(*) from doubleconcurents where cartelid=cartels.gid);
-- in (select oid from orgs where orgs.cid=cartels.id));
exec logOperation 1, 'findcartels',95;
update cartels set sum=(select sum(price) from contractsLt where 
           purchasenumber in (select purchasenumber from DoubleConcurents where cartelid=cartels.gid and purchasenumber<>''));
exec logOperation 1, 'findcartels',98;
truncate table cartelregs;
insert into cartelregs (cid, reg, cnt)
select orgs.cid, contractslt.reg, count(*) as cnt from contractslt join orgs on orgs.oid=contractslt.oid 
  where contractslt.purchasenumber in (select purchasenumber from doubleconcurents group by purchasenumber)
    group by orgs.cid,contractslt.reg order by cid;
	delete from cartelregs where reg is NULL;
	delete from cartelregs where reg =0;

exec logOperation 1, 'findcartels',100;
END

GO
/****** Object:  StoredProcedure [dbo].[findAllGroupsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findAllGroupsLT]
	( @dept int = 2
	
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @t oidlist;declare @z int;declare @ph varchar(20);declare @o int;declare @n int;declare @startz int;
delete from groups;dbcc checkident('groups',reseed,0);
exec logOperation 1, 'findgroups',  1;
update orgs set gid=0;
 --insert into @p (phone) select phone from orgphonesLT group by phone;
 select phone into ##phoneslst from doublephonesLT group by phone;
 select @z=(select count(*) from ##phoneslst);select @startz=@z;
 while (@z<>0)
 begin
 -- select top 1 * from @p;
 select @ph=(select top( 1) [phone] from ##phoneslst);
 select @z =(select top 1 oid from orgphonesLT where phone=@ph);
 insert into @t (id) execute findclusterbyorgLT @z, @dept;
 --select * from orgs where oid in (select * from @t)
select @z=(select count(*) from @t);
select @o=(select top(1) id from @t);
insert into groups (oid,count) values (@o, @z);
SELECT @o = @@IDENTITY;
update orgs set [gid]=@o where [oid] in (select id from @t);
delete from ##phoneslst where phone in (select phone from findphonesbyorgsLT (@t));
select @z=(select count(*) from ##phoneslst);delete from @t;
select @n=90-round((1.0*@z/@startz),2)*90;
exec logOperation 1, 'findgroups',  @n;
end;
drop table ##phoneslst;
exec logOperation 1, 'findgroups',91;
update groups set count=(select count(*) from orgs where orgs.gid=groups.id);
exec logOperation 1, 'findgroups',93;
update groups set total=(select count(*) from contractsLt where oid in (select oid from orgs where orgs.gid=groups.id));
exec logOperation 1, 'findgroups',95;
update groups set sum=(select sum(price) from contractsLt where oid in (select oid from orgs where orgs.gid=groups.id));
exec logOperation 1, 'findgroups',97;
update concurentsLT set cartelid=(select gid from orgs where orgs.oid=concurentsLT.oid);  --approx 3 minutes (30)
exec logOperation 1, 'findgroups',99;
delete from groupregs;
insert into groupregs (gid, reg, cnt)
select orgs.gid, contractslt.reg, count(*) as cnt from contractslt join orgs on orgs.oid=contractslt.oid 
    group by orgs.gid,contractslt.reg order by gid;
	delete from groupregs where reg is NULL;

exec logOperation 1, 'findgroups',100;
END

GO
/****** Object:  StoredProcedure [dbo].[findCartelData]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
 
CREATE procedure [dbo].[findCartelData]
(	
	-- Add the parameters for the function here
	@z int
	
)
--RETURNS   table
as
BEGIN
select purchases.date,purchases.purchasenumber,purchases.maxprice,concurents.sum,((purchases.maxprice-concurents.sum)/purchases.maxprice*100) as disc,concurents.oid,purchases.coid
 into #tt
from DoubleConcurents inner join purchases on purchases.purchasenumber=DoubleConcurents.purchasenumber inner join concurents on concurents.purchasenumber=Doubleconcurents.purchasenumber 
 where doubleconcurents.cartelid=@z order by purchases.date;
 select #tt.*,contractslt.contractnumber into #tr from #tt  left join contractslt on #tt.oid=contractslt.oid and #tt.purchasenumber=contractslt.purchasenumber
 select * from #tr;
--drop table #tt;
RETURN 
  --select * from #tr
 END



GO
/****** Object:  StoredProcedure [dbo].[findclusterbyorg]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findclusterbyorg]
(	
	-- Add the parameters for the function here
	@z int,
	@recursion int = 999
)
--RETURNS   oidlist
as
BEGIN
declare @t oidlist;
declare @r oidlist;
declare @a int;
declare @b int;
select @a=1;
select @b=2;
insert into @t (id)  select [oid] from orgs where oid=@z;

while (@a<>@b)and(@recursion>0)
begin 
	delete from @r;
	select @recursion=@recursion -1;
	insert into @r (id)  select oid from orgphones  where ([phone] in (select * from zakupki.dbo.findphonesbyorgs(@t)))and([usecnt]<7) group by oid;
	select @b=count(*) from @r;
	delete from @t ;
	insert into @t (id)  select oid from orgphones  where ([phone] in (select * from zakupki.dbo.findphonesbyorgs(@r)))and([usecnt]<7) group by oid; 
	select @a=count(*) from @t;
end;

select * from @t;
RETURN 
 
 END


GO
/****** Object:  StoredProcedure [dbo].[findclusterbyorg_byMail]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[findclusterbyorg_byMail]
(	
	-- Add the parameters for the function here
	@z int
)
--RETURNS   oidlist
as
BEGIN
declare @t oidlist;
declare @r oidlist;
declare @a int;
declare @b int;
select @a=1;
select @b=2;
insert into @t (id)  select [oid] from orgs where oid=@z;

while (@a<>@b)
begin 
	delete from @r;
	insert into @r (id)  select [oid] from orgs where oid in(select oid from orgemails  where [email] in (select * from zakupki.dbo.findmailsbyorgs(@t)) group by oid);
	select @b=count(*) from @r;
	delete from @t ;
	insert into @t (id)  select [oid] from orgs where oid in(select oid from orgemails  where [email] in (select * from zakupki.dbo.findmailsbyorgs(@r)) group by oid); 
	select @a=count(*) from @t;
end;

select * from @t;
RETURN 
 
 END


GO
/****** Object:  StoredProcedure [dbo].[findclusterbyorgLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[findclusterbyorgLT]
(	
	-- Add the parameters for the function here
	@z int,
	@recursion int = 999
)
--RETURNS   oidlist
as
BEGIN
declare @t oidlist;
declare @r oidlist;
declare @a int;
declare @b int;
select @a=1;
select @b=2;
insert into @t (id)  select [oid] from orgs where oid=@z;

while (@a<>@b)and(@recursion>0)
begin 
	delete from @r;
	select @recursion=@recursion -1;
	insert into @r (id)  select oid from orgphonesLT  where ([phone] in (select * from zakupki.dbo.findphonesbyorgsLT(@t))) group by oid;
	select @b=count(*) from @r;
	delete from @t ;
	insert into @t (id)  select oid from orgphonesLT  where ([phone] in (select * from zakupki.dbo.findphonesbyorgsLT(@r))) group by oid; 
	select @a=count(*) from @t;
end;

select * from @t;
RETURN 
 
 END


GO
/****** Object:  StoredProcedure [dbo].[findclusterbyorgLTC]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[findclusterbyorgLTC]
(	
	-- Add the parameters for the function here
	@z int,
	@recursion int = 999
)
--RETURNS   oidlist
as
BEGIN
declare @t oidlist;
declare @r oidlist;
declare @a int;
declare @b int;
select @a=1;
select @b=2;
insert into @t (id)  select [oid] from orgs where oid=@z;

while (@a<>@b)and(@recursion>0)
begin 
	delete from @r;
	select @recursion=@recursion -1;
	insert into @r (id)  select oid from orgphonesLTC  where ([phone] in (select * from zakupki.dbo.findphonesbyorgsLTC(@t))) group by oid;
	select @b=count(*) from @r;
	delete from @t ;
	insert into @t (id)  select oid from orgphonesLTC  where ([phone] in (select * from zakupki.dbo.findphonesbyorgsLTC(@r))) group by oid; 
	select @a=count(*) from @t;
end;

select * from @t;
RETURN 
 
 END


GO
/****** Object:  StoredProcedure [dbo].[getcluster]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getcluster]
(	
	-- Add the parameters for the function here
	@z int,@recursion int=1
)
--RETURNS   oidlist
as
BEGIN
set nocount on;
declare @t oidlist;
 insert into @t (id) execute findclusterbyorg @z,@recursion;
 select * from orgs where orgs.[oid] in (select * from @t)
RETURN 
 
 END


GO
/****** Object:  StoredProcedure [dbo].[getclusterEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[getclusterEx]
(	
	-- Add the parameters for the function here
	@z int,@recursion int=1
)
--RETURNS   oidlist
as
BEGIN
set nocount on;
declare @t oidlist;
 insert into @t (id) execute findclusterbyorgLT @z,@recursion;
 select * from orgs where orgs.[oid] in (select * from @t)
RETURN 
 
 END


GO
/****** Object:  StoredProcedure [dbo].[logOperation]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery36.sql|7|0|C:\Users\ser\AppData\Local\Temp\2\~vsFA81.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[logOperation] 
	-- Add the parameters for the stored procedure here
	@status int,
	@op varchar(50),
	@done int=0	
	AS
	declare @tid int;
	

BEGIN
	SET NOCOUNT ON;
	select @tid=(select  top 1 id FROM [workflow] WHERE ([pendingprocedure]=@op)and([laststatus]>0));

	if (@tid>0)  begin 
					if (@status=0) begin update [workflow] set laststatus=@status, endtime=getdate(),done=100 where (@tid=id); end
					if (@status=1) begin update [workflow] set laststatus=@status, done = @done where (@tid=id); end
					else if (@status=1)and(@done>0) update [workflow] set laststatus=@status, done=@done where (@tid=id);


                 end
     else begin 
	  insert into [workflow] (laststatus,pendingprocedure,starttime,done) values (@status, @op, getdate(),0)
	 ;
	 
	  SELECT @tid = 0;
	 end;
	 return @tid;
    END


GO
/****** Object:  StoredProcedure [dbo].[UpdateconcurentsUSECNT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[UpdateconcurentsUSECNT]
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update concurents set cartelid=(select cid from dbo.orgs where orgs.oid=concurents.oid);
    
END

GO
/****** Object:  StoredProcedure [dbo].[UpdatePhonesUseCNT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePhonesUseCNT]
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update orgphones set usecnt=(select cnt from dbo.DoublePhones where doublephones.phone=orgphones.phone);
    update orgphonesLT set usecnt=(select cnt from dbo.DoublePhonesLT where doublephonesLT.phone=orgphonesLT.phone);
END

GO
/****** Object:  UserDefinedFunction [dbo].[CheckEmail]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CheckEmail] ( @id int, @email varchar(120))
	
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	--SET NOCOUNT ON;
	declare @res int;
	if (NOT EXISTS(select * FROM [orgemails] WHERE [oid]=@id and [email]=@email ))
	 begin 
	  --insert into [orgphones] (oid,phone) values (@id, @phone);
	  select @res=1;
	 end 
	 else
	 	  select @res= 0;
	RETURN @res;
END

GO
/****** Object:  UserDefinedFunction [dbo].[CheckPhone]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CheckPhone] ( @id int, @phone varchar(20))
	
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	--SET NOCOUNT ON;
	declare @res int;
	if (NOT EXISTS(select * FROM [orgphones] WHERE [oid]=@id and [phone]=@phone ))
	 begin 
	  --insert into [orgphones] (oid,phone) values (@id, @phone);
	  select @res=1;
	 end 
	 else
	 	  select @res= 0;
	RETURN @res;
END

GO
/****** Object:  Table [dbo].[cartelregs]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartelregs](
	[cid] [int] NULL,
	[reg] [int] NULL,
	[cnt] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cartels]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cartels](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[count] [int] NULL,
	[name] [varchar](100) NULL,
	[comment] [varchar](2000) NULL,
	[lastupdate] [date] NULL,
	[total] [int] NULL,
	[sum] [float] NULL,
	[gid] [int] NULL,
	[NMCKsum] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[concurents]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[concurents](
	[purchasenumber] [varchar](22) NULL,
	[oid] [int] NULL,
	[cartelid] [int] NULL,
	[sum] [float] NULL,
	[appdate] [datetimeoffset](7) NULL,
	[lot] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[concurentsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[concurentsLT](
	[purchasenumber] [varchar](22) NULL,
	[oid] [int] NULL,
	[cartelid] [int] NULL,
	[sum] [float] NULL,
	[appdate] [datetimeoffset](7) NULL,
	[lot] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contracts]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contracts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[contractnumber] [varchar](22) NULL,
	[contactphone] [varchar](20) NULL,
	[contactemail] [varchar](100) NULL,
	[purchasenumber] [varchar](22) NULL,
	[contractid] [varchar](22) NULL,
	[ver] [int] NULL,
	[price] [float] NULL,
	[date] [date] NULL,
	[coid] [int] NULL,
	[reg] [int] NULL,
	[lot] [int] NULL,
 CONSTRAINT [PK_contracts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contractsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contractsLT](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[contractnumber] [varchar](22) NULL,
	[contactphone] [varchar](20) NULL,
	[contactemail] [varchar](100) NULL,
	[purchasenumber] [varchar](22) NULL,
	[contractid] [varchar](22) NULL,
	[ver] [int] NULL,
	[price] [float] NULL,
	[date] [date] NULL,
	[coid] [int] NULL,
	[reg] [int] NULL,
	[lot] [int] NULL,
 CONSTRAINT [PK_contractsLT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[groupregs]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[groupregs](
	[gid] [int] NULL,
	[reg] [int] NULL,
	[cnt] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[groups]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[groups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[count] [int] NULL,
	[name] [varchar](100) NULL,
	[comment] [varchar](2000) NULL,
	[lastupdate] [date] NULL,
	[total] [int] NULL,
	[sum] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoadedFiles]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoadedFiles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[filename] [varchar](100) NULL,
	[dateload] [datetime] NULL,
	[loaded] [smallint] NULL,
	[datatype] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgemails]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgemails](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[email] [varchar](120) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgemailsEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgemailsEx](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[email] [varchar](120) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgemailsLt]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[orgemailsLt](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[email] [varchar](120) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgphones]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgphones](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[phone] [varchar](20) NULL,
	[usecnt] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgphonesEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgphonesEx](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[phone] [varchar](20) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgphonesLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgphonesLT](
	[oid] [int] NULL,
	[phone] [varchar](20) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgphonesLT_NonUsed]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgphonesLT_NonUsed](
	[oid] [int] NULL,
	[phone] [varchar](20) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgphonesLTC]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[orgphonesLTC](
	[oid] [int] NULL,
	[phone] [varchar](20) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[orgs]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orgs](
	[oid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](200) NULL,
	[inn] [nchar](12) NULL,
	[email] [nchar](100) NULL,
	[phone] [nchar](20) NULL,
	[n_mails] [int] NULL,
	[n_phones] [int] NULL,
	[cid] [int] NULL,
	[n_phonesLT] [int] NULL,
	[contracts] [int] NULL,
	[summ] [float] NULL,
	[gid] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[purchases]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[purchases](
	[id] [int] NULL,
	[purchasenumber] [varchar](22) NULL,
	[coid] [int] NULL,
	[maxprice] [float] NULL,
	[date] [date] NULL,
	[status] [int] NULL,
	[cphone] [varchar](20) NULL,
	[cemail] [varchar](50) NULL,
	[lot] [int] NULL,
	[discount] [float] NULL,
	[okpd] [varchar](20) NULL,
	[type] [varchar](20) NULL,
	[name] [varchar](400) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[purchasesLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[purchasesLT](
	[purchasenumber] [varchar](22) NULL,
	[coid] [int] NULL,
	[maxprice] [float] NULL,
	[date] [date] NULL,
	[status] [int] NULL,
	[cphone] [varchar](20) NULL,
	[cemail] [varchar](50) NULL,
	[lot] [int] NULL,
	[discount] [float] NULL,
	[okpd] [varchar](20) NULL,
	[type] [varchar](20) NULL,
	[oid] [int] NULL,
	[name] [varchar](400) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[workflow]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[workflow](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[laststatus] [int] NULL,
	[pendingprocedure] [varchar](50) NULL,
	[starttime] [datetime] NULL,
	[endtime] [datetime] NULL,
	[done] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[zakPhonesEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[zakPhonesEx](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[oid] [int] NULL,
	[phone] [varchar](20) NULL,
	[usecnt] [int] NULL,
	[weight] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[DoublePhonesLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREate VIEW [dbo].[DoublePhonesLT]
AS
SELECT     phone, COUNT(*) AS cnt
FROM         dbo.orgphonesLT
GROUP BY phone
HAVING      (COUNT(*) > 1)



GO
/****** Object:  UserDefinedFunction [dbo].[finddoublephonesbyorg]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[finddoublephonesbyorg]
(	
	-- Add the parameters for the function here
	@p int
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [phone],[usecnt],[weight] from [zakupki].[dbo].[orgphonesLT] where ([oid] in (@p)) and (exists (select * from DoublePhonesLT where DoublephonesLT.phone=orgphonesLT.phone))
)


GO
/****** Object:  View [dbo].[DoublePhones]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DoublePhones]
AS
SELECT     phone, COUNT(*) AS cnt
FROM         dbo.orgphones
GROUP BY phone
HAVING      (COUNT(*) > 1)

GO
/****** Object:  UserDefinedFunction [dbo].[finddoublephonesbyorgs]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[finddoublephonesbyorgs]
(	
	-- Add the parameters for the function here
	@p oidlist readonly
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [phone] from [zakupki].[dbo].[orgphones] where ([oid] in (select oid from @p)) and (exists (select * from DoublePhones where Doublephones.phone=orgphones.phone))
)



GO
/****** Object:  View [dbo].[DoubleMails]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DoubleMails]
AS
SELECT     email, COUNT(*) AS cnt
FROM         dbo.orgemails
GROUP BY email
HAVING      (COUNT(*) > 1)


GO
/****** Object:  UserDefinedFunction [dbo].[finddoublemailsbyorg]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[finddoublemailsbyorg]
(	
	-- Add the parameters for the function here
	@p int
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [email] from [zakupki].[dbo].[orgemails] where ([oid] in (@p)) and (exists (select * from DoubleMails where DoubleMails.email=orgemails.email))
)



GO
/****** Object:  UserDefinedFunction [dbo].[findmailsbyorg]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findmailsbyorg]
(	
	-- Add the parameters for the function here
	@p int
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [email] from [zakupki].[dbo].[orgemails] where [oid] =@p
)


GO
/****** Object:  UserDefinedFunction [dbo].[findmailsbyorgs]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findmailsbyorgs]
(	
	-- Add the parameters for the function here
	@p oidlist readonly
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [email] from [zakupki].[dbo].[orgemails] where [oid] in (select * from @p)
)



GO
/****** Object:  UserDefinedFunction [dbo].[findorgbyEmail]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[findorgbyEmail]
(	
	-- Add the parameters for the function here
	@p varchar(100)
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT oid from [zakupki].[dbo].[orgemails] where [email]=@p
)


GO
/****** Object:  UserDefinedFunction [dbo].[findorgbyphone]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[findorgbyphone]
(	
	-- Add the parameters for the function here
	@p varchar(20)
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT oid from [zakupki].[dbo].[orgphones] where [phone]=@p
)

GO
/****** Object:  UserDefinedFunction [dbo].[findphonesbyorg]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findphonesbyorg]
(	
	-- Add the parameters for the function here
	@p int
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [phone] from [zakupki].[dbo].[orgphones] where [oid] in (@p)
)

GO
/****** Object:  UserDefinedFunction [dbo].[findphonesbyorgs]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findphonesbyorgs]
(	
	-- Add the parameters for the function here
	@p oidlist readonly
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [phone] from [zakupki].[dbo].[orgphones] where ([oid] in (select * from @p))
)


GO
/****** Object:  UserDefinedFunction [dbo].[findphonesbyorgsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findphonesbyorgsLT]
(	
	-- Add the parameters for the function here
	@p oidlist readonly
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [phone] from [zakupki].[dbo].[orgphonesLT] where ([oid] in (select * from @p))
)



GO
/****** Object:  UserDefinedFunction [dbo].[findphonesbyorgsLTC]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[findphonesbyorgsLTC]
(	
	-- Add the parameters for the function here
	@p oidlist readonly
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [phone] from [zakupki].[dbo].[orgphonesLTC] where ([oid] in (select * from @p))
)



GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPage]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ft_GetPage](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber, * 
        FROM cartels
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageCartels]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =========================================
CREATE FUNCTION [dbo].[ft_GetPageCartels](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
								 
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
    WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY id) AS RowNumber, * 
        FROM cartels 
   )

   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageCartels_cnt]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ft_GetPageCartels_cnt](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
								 
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
    WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY count desc,id desc) AS RowNumber, * 
        FROM cartels 
   )

   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageCartels_sum]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ft_GetPageCartels_sum](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
								 
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
    WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY sum desc,id desc) AS RowNumber, * 
        FROM cartels 
   )

   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageCartels_total]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ft_GetPageCartels_total](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
								 
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
    WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY total desc,id desc) AS RowNumber, * 
        FROM cartels 
   )

   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageCartelsREG]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ft_GetPageCartelsREG](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT,  --Количество записей на странице
								  @region AS INT=0 
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber, * 
        FROM cartels where 
				(@region=0)or(cartels.id in (select cid from cartelregs where reg=@region))
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageGroups]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ft_GetPageGroups](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber, * 
        FROM groups where id>0
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageGroups_cnt]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[ft_GetPageGroups_cnt](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY count desc, Id desc) AS RowNumber, * 
        FROM groups where id>0
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageGroups_sum]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[ft_GetPageGroups_sum](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY sum desc, Id desc) AS RowNumber, * 
        FROM groups where id>0
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageGroups_total]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[ft_GetPageGroups_total](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT  --Количество записей на странице
								
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY total desc, Id desc) AS RowNumber, * 
        FROM groups where id>0
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[ft_GetPageGroupsREG]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[ft_GetPageGroupsREG](@Page INT, --Номер страницы
                                  @CntRowOnPage AS INT,  --Количество записей на странице
								  @region as INT=0 
                                  ) 
   RETURNS TABLE
   RETURN(
   --Объявляем CTE
   WITH SOURCE AS (
        SELECT ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber, * 
        FROM groups where 
				(@region=0)or(groups.id in (select gid from groupregs where reg=@region))
   )
   SELECT * FROM SOURCE
   WHERE RowNumber > (@Page * @CntRowOnPage) - @CntRowOnPage 
     AND RowNumber <= @Page * @CntRowOnPage
  )

GO
/****** Object:  UserDefinedFunction [dbo].[getbanksID]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[getbanksID]
(	
	-- Add the parameters for the function here
	@p int
)
RETURNS TABLE 
AS 
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select oid from orgs where inn in (
'2126003130',
'1835047032',
'1700000350',
'1650072068',
'1653017097',
'1653016914',
'1653003601',
'1627000724',
'0901000990',
'1101300820',
'0709002625',
'0541019312',
'0541015808',
'0548002149',
'0541011169',
'0541002407',
'0268028881',
'7414006722',
'6608000943',
'4214005204',
'7303024532',
'8913002468',
'8602190258',
'7202072360',
'7202021856',
'6829000028',
'9203001743',
'6725008696',
'6612010782',
'6608001383',
'6608003052',
'6454005120',
'5902300072',
'5902300033',
'5836900162',
'5610032958',
'5032998599',
'5503044518',
'5404154492',
'7736008918',
'7703211512',
'7710033170',
'7744002282',
'7703025925',
'7744000197',
'6027006032',
'7703033450',
'7744000937',
'7709053245',
'7750005789',
'7702281122',
'7719025494',
'6449011425',
'7708000628',
'7712002554',
'5401122100',
'6165029771',
'7702018971',
'7729003482',
'7718120593',
'7750005926',
'7734202860',
'7744002821',
'7710093348',
'6311026820',
'7725039953',
'7701028536',
'7744001514',
'1103017551',
'7750004009',
'7713073082',
'7744000736',
'7721011717',
'7744001828',
'7722076611',
'7744002726',
'7730040030',
'3123011520',
'6017000271',
'7717011200',
'7750005524',
'7750004030',
'7730059592',
'5610000466',
'7744001634',
'7744002959',
'7727067410',
'7744002797',
'7744000327',
'7708013592',
'5008004581',
'7708009162',
'7750005845',
'7710008416',
'2353002454',
'7703247043',
'7730063084',
'6901001949',
'7725065199',
'7706006720',
'7744002363',
'7703009320',
'0901001024',
'7750004231',
'7713097982',
'7709094876',
'5031032717',
'7704132246',
'7725114488',
'7750005806',
'4825005381',
'0541002492',
'7831000147',
'5321038693',
'6323066377',
'5602001924',
'5260059340',
'4346001485',
'4216002921',
'4216003682',
'6910003357',
'3807000886',
'3702558680',
'5261002749',
'5245004890',
'5260003429',
'5260152389',
'3525030674',
'3525269550',
'3015011755',
'2801023444',
'2634028786',
'2536020789',
'2703006553',
'7105000307',
'2450004016',
'2320015183',
'0106000547',
'0541016015',
'2310019990',
'2338002040',
'2308016938',
'2312016641',
'2225019491',
'2277004739',
'2209004508',
'1831002591',
'1653005038',
'7714015358',
'1326021671',
'0527000260',
'0323045986',
'7601000294',
'7449014065',
'7302000916',
'7303008900',
'7303003148',
'7202026861',
'7104024168',
'6608007402',
'6608007473',
'6231027963',
'6227003906',
'6166016158',
'6164102186',
'6164100968',
'6164102933',
'2332006024',
'6155017417',
'6025001487',
'5460000016',
'7744002275',
'7744000398',
'7744001070',
'7750004263',
'2112001380',
'7750004104',
'7750003982',
'6829000412',
'7725068827',
'7750005852',
'7736188731',
'6312023300',
'7750004143',
'8905007462',
'7714044415',
'7831001567',
'7706195570',
'7709315684',
'7744002839',
'7728168971',
'7713001271',
'7711063650',
'7744002860',
'7708072196',
'7710030411',
'0541009561',
'5433107271',
'0411003255',
'7744001105',
'7744002660',
'7744000729',
'7704046967',
'7744001761',
'7711068778',
'0725991479',
'5001068138',
'7709007312',
'7709129705',
'7729109369',
'7706082657',
'5036037772',
'7705260427',
'7703004072',
'7704113772',
'7730030466',
'7731202936',
'7701138419',
'7744002691',
'7734205131',
'7703074601',
'7729405872',
'7717002773',
'7744003127',
'7701014396',
'7744003014',
'7744000888',
'7705055869',
'7744003159',
'7831000034',
'7744002405',
'7734052372',
'7705041249',
'5503067018',
'7705034523',
'7750003870',
'7705256396',
'7705205000',
'7727038017',
'7722004494',
'7750056670',
'7831000806',
'6436003219',
'7831000940',
'2901081545',
'7835905108',
'7831000612',
'7831000098',
'7831000965',
'7835903703',
'7831001239',
'4510000735',
'0409000930',
'6316028910',
'6316049606',
'4216004076',
'4218004258',
'4026006420',
'7100001459',
'5253004326',
'5246000120',
'5200000222',
'3128000088',
'3123004233',
'2447002227',
'2320184390',
'2312262492',
'2126003557',
'1834100678',
'1840056378',
'1644004905',
'1653018661',
'1658088006',
'1653003834',
'1653019873',
'1504031480',
'1300034972',
'1215192632',
'1001011328',
'0711003263',
'0523000943',
'0541002573',
'0100000036',
'0100000050',
'7450002096',
'6654001613',
'6500001204',
'6453031840',
'6227001779',
'5607002142',
'5503135638',
'5404110583',
'5190900165',
'7729086087',
'7725061155',
'6320013240',
'7703016208',
'6905011218',
'7707288837',
'7727051787',
'7750005500',
'7703008207',
'7709024276',
'7744002500',
'5047093433',
'7744000334',
'1653017403',
'5006008573',
'6163025806',
'6931000220',
'7744003511',
'7744001994',
'5026014060',
'7750005732',
'7708019724',
'7702062635',
'7729003299',
'7718103767',
'7707040963',
'7704045650',
'7750004094',
'7750004256',
'0411005333',
'7731044736',
'7708005552',
'7750004217',
'0304001711',
'2312012510',
'7744002652',
'7744003342',
'7703010220',
'2632052342',
'7744002211',
'7709056550',
'7729065633',
'7705038550',
'7750005725',
'7750005436',
'7744001144',
'7713073043',
'7724096412',
'7735041415',
'7744001440',
'7707115538',
'7750004111',
'2465029704',
'0711007370',
'7750003929',
'7701000940',
'7744001930',
'7705031219',
'7702045051',
'7707083893',
'7705011011',
'7712014310',
'7710014949',
'7734028813',
'7703122164',
'7702021163',
'7704001959',
'7702070139',
'7709233110',
'7707283980',
'7712044762',
'7709311351',
'7750005690',
'7712034098',
'7703213534',
'7710295979',
'7702216772',
'7744002187',
'7609016017',
'7750004270',
'7702000406',
'4704470120',
'6229005810',
'7831001246',
'7831001158',
'7831001060',
'7831000027',
'4501010247',
'6452012933',
'5012003647',
'7303007640',
'7701105460',
'6454027396',
'4401116480',
'4101019774',
'2901009852',
'3006000387',
'2540015598',
'2304032625',
'2309023960',
'2224009042',
'1901036580',
'1650002455',
'1500000240',
'1504029723',
'1326024785',
'1215059221',
'0703000942',
'0546016675',
'0274061157',
'0274061206',
'7423004062',
'7453011395',
'8603010518',
'2125002247',
'7000000719',
'6450013459',
'6227005702',
'6168065792',
'6166003409',
'6163011391',
'6164026390',
'6025001470',
'5753009570',
'5603009098',
'2225031594',
'5410495331',
'5321029402',
'7710140679',
'7744001793',
'7744001835',
'3900000834',
'6615001384',
'7723008300',
'6506000327',
'1102011300',
'7701013346',
'7705004247',
'7709167933',
'7722061076',
'7729399756',
'6167007639',
'1102008681',
'3900001002',
'7709035670',
'7710409880',
'7730067441',
'7736017052',
'7750005718',
'7744000302',
'7706009657',
'7725061268',
'7719038888',
'7750056695',
'7744000038',
'7744000990',
'7710036614',
'7722022528',
'7718137822',
'7707077586',
'7750005563',
'7750005637',
'7707025725',
'7750056688',
'7705003797',
'7710033910',
'7750004305',
'7744000920',
'7729078921',
'7744002814',
'7716079036',
'7703074584',
'7710046757',
'7710001820',
'7744001521',
'7703030636',
'7705420744',
'7744000550',
'7726000596',
'6454002730',
'7704099052',
'7725038124',
'7701041336',
'7730060164',
'7744000609',
'7750004320',
'7732012737',
'7727095209',
'7718116607',
'7704111969',
'7710401987',
'0814042850',
'6829000290',
'7750004190',
'7705014728',
'7744003039',
'7712108021',
'7744000824',
'7707377237',
'4704000029',
'6027005825',
'0900000042',
'4706006731',
'7831001415',
'7831001422',
'7831001704',
'7835905228',
'7831001729',
'7715024193',
'6318109040',
'6311013853',
'6317009589',
'9102019769',
'4346013603',
'4101025538',
'3807002717',
'3808000590',
'3702951429',
'3702030072',
'5261005926',
'5243006236',
'3528006214',
'3525023780',
'3327100351',
'3015010952',
'2804004055',
'0541016390',
'4101011782',
'2129007126',
'2119000435',
'1831027349',
'1650000419',
'1650025163',
'1653001805',
'1626000087',
'1653011835',
'0901001063',
'0901001151',
'1501012538',
'0814037200',
'0411006129',
'0541014280',
'0541013624',
'0504004830',
'0276005447',
'0274045684',
'0274051857',
'0541012405',
'1653017160',
'7453002182',
'8622002375',
'7100002710',
'6608005109',
'6629001024',
'6501024719',
'6452999822',
'6455000037',
'6154035357',
'6147006926',
'5904002762',
'5902300019',
'5612031491',
'5503008333',
'5502051657',
'5405114781',
'7730123311',
'7705012216',
'2627016420',
'7730045575',
'7710142732',
'7744001497',
'0274062111',
'7714008520',
'7744001320',
'7706193043',
'7750004129',
'7536002161',
'7733043350',
'7750004168',
'7706096522',
'7713029647',
'7736009502',
'7750004023',
'7750005605',
'7203063256',
'7100002678',
'7744003173',
'7744001810',
'7702165310',
'7750005482',
'7744003007',
'6312013912',
'7716081564',
'7710070848',
'7744001673',
'7750005651',
'7750005387',
'7750004288',
'7731063707',
'7750005764',
'7750004337',
'7750005700',
'7730062041',
'5038013431',
'7709046777',
'7750004175',
'7728185046',
'7703122887',
'3232005484',
'7703242969',
'7703115760',
'7726016846',
'5000001042',
'7744000239',
'7706196340',
'7750003943',
'7704010544',
'7736193347',
'7707056547',
'7744000126',
'7707033412',
'5503016736',
'7750005771',
'7404005261',
'7708050033',
'7721018102',
'7705285534',
'7723168657',
'7734096330',
'2202000656',
'7744002042',
'7729496647',
'4825004973',
'7831000108',
'7831000122',
'7831001013',
'7831000066',
'7831001623',
'4629019959',
'6320006108',
'4401008886',
'4205001450',
'4207013490',
'4205001732',
'4101020152',
'4026005138',
'4000000103',
'3819001330',
'3818021045',
'3801002781',
'3728018834',
'3702062934',
'5249013007',
'5254004350',
'3525030681',
'3329000313',
'2801015394',
'2503001251',
'2309074812',
'1435138944',
'1901017690',
'1827002623',
'1657190840',
'1653017026',
'1653016689',
'1653016664',
'7715000114',
'0541011313',
'0541002693',
'0102000578',
'7750005531',
'7601000618',
'7421000200',
'7451036789',
'8603001714',
'7202010558',
'7100001642',
'7000000130',
'7604014087',
'6608008004',
'6608001425',
'6625000100',
'6509006951',
'6501021443',
'6455014287',
'6439044245',
'6453033870',
'6132001298',
'5904004343',
'5751016814',
'5610032972',
'5321068480',
'5190103184',
'7744000630',
'7744002740',
'7706092528',
'7709345294',
'7736046991',
'7750005612',
'7750003904',
'7708022300',
'7750004351',
'7736153344',
'7736176542',
'7701051006',
'7734052439',
'7717004724',
'7710301140',
'2329003217',
'6452010742',
'7750005901',
'7704019762',
'7703002999',
'7705148464',
'5047998520',
'7710106861',
'8603001619',
'3900000866',
'7706074938',
'7744002684',
'7714038860',
'7750003950',
'7704064645',
'7744002412',
'7706005050',
'5011002908',
'7718011918',
'7750004136',
'7744002204',
'7727039934',
'7744000912',
'7744001218',
'7750005588',
'7705011188',
'7727065444',
'7725038220',
'7725053490',
'7750005450',
'7707093813',
'7719020344',
'7705039183',
'0505005057',
'2315126160',
'7744001095',
'7720069320',
'0278081806',
'4908001687',
'7723017672',
'7709049263',
'5009018805',
'7701020946',
'7708001614',
'5617000264',
'7750005796',
'7704018984',
'7750004295',
'0510000015',
'7710050376',
'7735057951',
'7724187003',
'7718104217',
'7706027060',
'7710066672',
'7708018456',
'7709138570',
'7718105676',
'7744000165',
'7744001024',
'7714056040',
'7704112176',
'7706028882',
'7724192564',
'2536073533',
'7714060199',
'7736017341',
'7453013650',
'7750005860',
'7834000138',
'3803202000',
'7834002576',
'7831000210',
'2465037737',
'7831000080',
'6320007246',
'6310000192',
'6325065114',
'7750005820',
'2204000595',
'4346021555',
'4207004665',
'6915001057',
'3906098008',
'3803202031',
'3731001982',
'3525018003',
'3442028061',
'3015012501',
'2901047470',
'2618000776',
'2539013067',
'2540016961',
'2466002046',
'2466155733',
'0103001895',
'2202000381'

)

)


GO
/****** Object:  View [dbo].[changedcontracts]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[changedcontracts]
AS
select count(*)as cnt,contractnumber,contactphone from contracts group by contractnumber,contactphone 


GO
/****** Object:  View [dbo].[changedcontractsoids]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create VIEW [dbo].[changedcontractsoids]
AS
select count(*)as cnt,contractnumber,oid from contracts group by contractnumber,oid 



GO
/****** Object:  View [dbo].[changedcontractsPhOi]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create VIEW [dbo].[changedcontractsPhOi]
AS
select count(*)as cnt,contractnumber,oid,contactphone from contracts group by contractnumber,oid,contactphone 



GO
/****** Object:  View [dbo].[DoubleConcurents]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[DoubleConcurents]
AS
select count(*) as cnt,purchasenumber,cartelid from concurentsLT where (cartelid>0) group by purchasenumber,cartelid HAVING      (COUNT(*) > 1) 



GO
/****** Object:  View [dbo].[DoubleMailsEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[DoubleMailsEx]
AS
SELECT     email, COUNT(*) AS cnt
FROM         dbo.orgemailsEx
GROUP BY email
HAVING      (COUNT(*) > 1)



GO
/****** Object:  View [dbo].[DoubleMailsLT]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREate VIEW [dbo].[DoubleMailsLT]
AS
SELECT     email, COUNT(*) AS cnt
FROM         dbo.orgEmailsLT
GROUP BY email
HAVING      (COUNT(*) > 1)




GO
/****** Object:  View [dbo].[DoublePhonesEx]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[DoublePhonesEx]
AS
SELECT     phone, COUNT(*) AS cnt
FROM         dbo.orgphonesEx
GROUP BY phone
HAVING      (COUNT(*) > 1)


GO
/****** Object:  View [dbo].[DoublePhonesLTC]    Script Date: 16.07.2021 17:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREate VIEW [dbo].[DoublePhonesLTC]
AS
SELECT     phone, COUNT(*) AS cnt
FROM         dbo.orgphonesLTC
GROUP BY phone
HAVING      (COUNT(*) > 1)




GO
/****** Object:  Index [cartelregs_cid]    Script Date: 16.07.2021 17:57:43 ******/
CREATE CLUSTERED INDEX [cartelregs_cid] ON [dbo].[cartelregs]
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [groupregs_gid]    Script Date: 16.07.2021 17:57:43 ******/
CREATE CLUSTERED INDEX [groupregs_gid] ON [dbo].[groupregs]
(
	[gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [name]    Script Date: 16.07.2021 17:57:43 ******/
CREATE CLUSTERED INDEX [name] ON [dbo].[LoadedFiles]
(
	[filename] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [concurents.by_purchase]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [concurents.by_purchase] ON [dbo].[concurents]
(
	[purchasenumber] ASC
)
INCLUDE ( 	[oid],
	[lot]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [concurents_byCartelId]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [concurents_byCartelId] ON [dbo].[concurentsLT]
(
	[cartelid] ASC
)
INCLUDE ( 	[purchasenumber]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [concurents_oids]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [concurents_oids] ON [dbo].[concurentsLT]
(
	[oid] ASC
)
INCLUDE ( 	[purchasenumber]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Concurents_purchases]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [Concurents_purchases] ON [dbo].[concurentsLT]
(
	[purchasenumber] ASC
)
INCLUDE ( 	[oid],
	[lot]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [contracts.ByNumber]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [contracts.ByNumber] ON [dbo].[contracts]
(
	[contractnumber] ASC
)
INCLUDE ( 	[ver]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [contracts.contractid]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [contracts.contractid] ON [dbo].[contracts]
(
	[contractid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Contracts_contractnumber]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [Contracts_contractnumber] ON [dbo].[contractsLT]
(
	[contractnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ContractsLT.byPurchases]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [ContractsLT.byPurchases] ON [dbo].[contractsLT]
(
	[purchasenumber] ASC
)
INCLUDE ( 	[price],
	[oid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ContractsLT_oid]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [ContractsLT_oid] ON [dbo].[contractsLT]
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [emails.phones]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [emails.phones] ON [dbo].[orgemails]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [orgphones.oids]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [orgphones.oids] ON [dbo].[orgphones]
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [orgphones.phones]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [orgphones.phones] ON [dbo].[orgphones]
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [orgphonesLT.oids]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [orgphonesLT.oids] ON [dbo].[orgphonesLT]
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [orgphonesLT.phones]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [orgphonesLT.phones] ON [dbo].[orgphonesLT]
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrgphonesLTC_oids]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [OrgphonesLTC_oids] ON [dbo].[orgphonesLTC]
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [OrgphonesLTC_phones]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [OrgphonesLTC_phones] ON [dbo].[orgphonesLTC]
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [orgs.gid]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [orgs.gid] ON [dbo].[orgs]
(
	[gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [orgs.inn]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [orgs.inn] ON [dbo].[orgs]
(
	[inn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [orgs.oids]    Script Date: 16.07.2021 17:57:43 ******/
CREATE UNIQUE NONCLUSTERED INDEX [orgs.oids] ON [dbo].[orgs]
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [Purchases_byNumber]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [Purchases_byNumber] ON [dbo].[purchases]
(
	[purchasenumber] ASC
)
INCLUDE ( 	[maxprice]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Purchases_id]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [Purchases_id] ON [dbo].[purchases]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Purchases.bydate]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [Purchases.bydate] ON [dbo].[purchasesLT]
(
	[date] ASC
)
INCLUDE ( 	[maxprice]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PurchasesLT.byPurchase]    Script Date: 16.07.2021 17:57:43 ******/
CREATE NONCLUSTERED INDEX [PurchasesLT.byPurchase] ON [dbo].[purchasesLT]
(
	[purchasenumber] ASC
)
INCLUDE ( 	[maxprice]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "orgphones"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DoublePhones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'DoublePhones'
GO
USE [master]
GO
ALTER DATABASE [zakupki] SET  READ_WRITE 
GO
