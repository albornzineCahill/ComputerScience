/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttClassMaterials') is not null 
  drop type udttClassMaterials
go
create type udttClassMaterials as table(
  KeyField		smallint,
  Description	varchar(30) null,
  ClassFK		smallint 	null,
  EstimatedCost	smallmoney	null,
  BuyYourself	bit			null)  
go
  