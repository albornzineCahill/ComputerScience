/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttInsurances') is not null 
  drop type udttInsurances
go
create type udttInsurances as table(
  KeyField				smallint,
  InsuranceCo			varchar(50)	null,
  PolicyNum				varchar(50)	null,
  SubscriberName		varchar(50)	null,
  SubscriberNum			varchar(25)	null,
  SubscriberEmployer	varchar(50)	null,
  SubscriberJob			varchar(50)	null,
  SubscriberWorkPhone	varchar(20)	null)  
go
  