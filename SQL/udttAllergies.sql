/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttAllergies') is not null 
  drop type udttAllergies
go
create type udttAllergies as table(
  KeyField		int,
  Description	varchar(100) null)  
go
  