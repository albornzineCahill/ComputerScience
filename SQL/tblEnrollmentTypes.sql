/********************************************************

      Written by Computer Science Class
      Last Updated: 10/20/2014

********************************************************/

if exists (select name from sysobjects where name = 'uspGetEnrollmentTypes')
   drop procedure uspGetEnrollmentTypes
if exists (select name from sysobjects where name = 'uspUpdEnrollmentTypes')
   drop procedure uspUpdEnrollmentTypes
go
create procedure uspGetEnrollmentTypes
with encryption as
begin
  set nocount on

  select t.KeyField,t.[Description],t.DisplayOrder,
    convert(bit,case when exists (select KeyField from tblPeople 
      where EnrollmentTypeFK = t.KeyField) then 0 else 1 end) as OKToDelete, convert(bit,0) as UpdateYN, convert(bit,0) as DeleteYN from tblEnrollmentTypes as t order by DisplayOrder
end
go
create procedure uspUpdEnrollmentTypes
  @EnrollmentTypes udttEnrollmentType readonly,
  @ErrMsg	varchar(512)=null output
with encryption as
begin

  set nocount on

  begin transaction
  begin try

    -- Update tblEnrollmentTypes for Delete, Updates, and Inserts

    delete from tblEnrollmentTypes where KeyField in
      (select KeyField from @EnrollmentTypes where DeleteYN = 1)

    update t set t.Description = t1.Description,
      t.DisplayOrder = t1.DisplayOrder
    from tblEnrollmentTypes as t
      inner join @EnrollmentTypes as t1 on (t.KeyField = t1.KeyField)

    insert into tblEnrollmentTypes (Description,DisplayOrder)
      select Description,DisplayOrder
      from @EnrollmentTypes where KeyField < 0    

    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch
end
go 