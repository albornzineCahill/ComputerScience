/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

if exists (select name from sysobjects where name = 'uspGetRooms')
   drop procedure uspGetRooms
if exists (select name from sysobjects where name = 'uspUpdRooms')
   drop procedure uspUpdRooms
go
create procedure uspGetRooms
with encryption as
begin
  set nocount on

  select t.KeyField,t.[Description],t.MaxStudents,
    convert(bit,case when exists (select KeyField from tblRoomAssignment 
      where RoomFK = t.KeyField) then 0 else 1 end) as OKToDelete from tblRooms as t
end
go
create procedure uspUpdRooms
  @Rooms udttRooms readonly,
  @ErrMsg	varchar(512)=null output
with encryption as
begin

  set nocount on

  begin transaction
  begin try

    -- Update tblRooms for Delete, Updates, and Inserts

    delete from tblRooms where KeyField in
      (select KeyField from @Rooms where DeleteYN = 1)

    update t set t.Description = t1.Description,
      t.MaxStudents = t1.MaxStudents
    from tblRooms as t
      inner join @Rooms as t1 on (t.KeyField = t1.KeyField)

    insert into tblRooms (Description,MaxStudents)
      select Description,MaxStudents
      from @Rooms where KeyField < 0    

    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch
end
go