/********************************************************

      Written by Computer Science Class
      Last Updated: 5/18/2015

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

if exists (select name from sysobjects where name = 'uspUpdRooms')
   drop procedure uspUpdRooms
if type_id('udttRooms') is not null 
  drop type udttRooms
go
create type udttRooms as table(
  KeyField		smallint,
  Description	varchar(30)	null,
  MaxStudents	int			null,
  DeleteYN		bit			null,
  UpdateYN		bit			null,
  OKToDelete	bit			null)  
go
  