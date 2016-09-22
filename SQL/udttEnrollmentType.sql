/********************************************************

      Written by Computer Science Class
      Last Updated: 10/20/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttEnrollmentType') is not null 
  drop type udttEnrollmentType
go
create type udttEnrollmentType as table(
  KeyField	smallint,
  Description	varchar(20) null,
  DisplayOrder	smallint null,
  OKToDeleteYN	bit null,
  UpdateYN bit null,
  DeleteYN	bit null)  
go
  