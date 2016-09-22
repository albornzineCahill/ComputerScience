/********************************************************

      Written by CT Software Systems, LLC
      Last Updated: 05/11/2013

********************************************************/

if exists (select name from sysobjects where name = 'uspGetColors')
   drop procedure uspGetColors
if exists (select name from sysobjects where name = 'uspUpdColors')
   drop procedure uspUpdColors
go
create procedure uspGetColors
with encryption as
begin
  set nocount on

  select t.KeyField,t.[Description],t.DisplayOrder,
    convert(bit,case when exists (select KeyField from tblProductLots 
      where ColorFKPartA = t.KeyField or ColorFKPartB = t.KeyField) then 0 else 1 end) as OKToDelete,
    convert(bit,0) as DeleteYN from tblColors as t order by t.Description
end
go
create procedure uspUpdColors
  @Colors	udttColor readonly,
  @ErrMsg	varchar(512)=null output
with encryption as
begin

  set nocount on

  begin transaction
  begin try

    -- Update tblColors for Delete, Updates, and Inserts

    delete from tblColors where KeyField in
      (select KeyField from @Colors where DeleteYN = 1)

    update t set t.Description = t1.Description,
      t.DisplayOrder = t1.DisplayOrder
    from tblColors as t
      inner join @Colors as t1 on (t.KeyField = t1.KeyField)

    insert into tblColors (Description,DisplayOrder)
      select Description,DisplayOrder
      from @Colors where KeyField < 0    

    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch
end
go 