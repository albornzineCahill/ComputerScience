/********************************************************

      Written by Computer Science Class
      Last Updated: 4/27/2015

********************************************************/

if exists (select name from sysobjects where name = 'uspLogIn')
   drop procedure uspLogIn
go
create procedure uspLogIn

  @Username varchar(50),
  @Password varbinary(64),
  @IsValid bit = null output

with encryption as
begin
set nocount on

  if exists (select KeyField from tblRoomTimes where Username = @Username and Password = @Password)
    set @IsValid = 1
  else
    set @IsValid = 0

end