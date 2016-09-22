/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttStudentClasses') is not null 
  drop type udttStudentClasses
go
create type udttStudentClasses as table(
  KeyField		int,
  PersonFK		smallint	null,
  ClassFK		smallint	null,
  Grade			smallmoney	null,
  Year			date		null)  
go
  