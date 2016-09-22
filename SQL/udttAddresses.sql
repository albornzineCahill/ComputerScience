/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttAddresses') is not null 
  drop type udttAddresses
go
create type udttAddresses as table(
  KeyField	smallint,
  Adr1		varchar(50) null,
  Adr2		varchar(50) null,
  City		varchar(20) null,
  St		varchar(2)	null,
  ZIP		varchar(10)	null)  
go
  