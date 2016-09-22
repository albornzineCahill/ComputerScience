/********************************************************

      Written by CT Software Systems, LLC
      Last Updated: 07/25/2013

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

if exists (select name from sysobjects where name = 'uspUpdColors')
   drop procedure uspUpdColors
if type_id('udttColor') is not null 
  drop type udttColor
go
create type udttColor as table(
  KeyField	smallint,
  Description	varchar(20) null,
  DisplayOrder	smallint null,
  OKToDeleteYN	bit null,
  DeleteYN	bit null)  
go
  