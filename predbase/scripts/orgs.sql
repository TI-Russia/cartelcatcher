/*
   22 февраля 2020 г.18:14:13
   Пользователь: 
   Сервер: WEB
   База данных: zakupki
   Приложение: 
*/

/* Чтобы предотвратить возможность потери данных, необходимо внимательно просмотреть этот скрипт, прежде чем запускать его вне контекста конструктора баз данных.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.orgs ADD
	n_mails int NULL,
	n_phones int NULL
GO
CREATE NONCLUSTERED INDEX IX_orgs ON dbo.orgs
	(
	inn
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.orgs SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
