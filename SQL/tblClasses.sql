/********************************************************

      Written by CT Software Systems, LLC
      Last Updated: 11/10/2014

********************************************************/


if exists (select name from sysobjects where name = 'uspDelClass')
   drop procedure uspDelClass
if exists (select name from sysobjects where name = 'uspGetClass')
   drop procedure uspGetClass
/* if exists (select name from sysobjects where name = 'uspGetClassesLookupTbls')
   drop procedure uspGetClassesLookupTbls */
if exists (select name from sysobjects where name = 'uspUpdClass')
   drop procedure uspUpdClass
if exists (select name from sysobjects where name = 'uspGetClassMaterials')
   drop procedure uspGetClassMaterials
go

create procedure uspDelClass
  @KeyField	smallint,
  @ErrMsg	varchar(512)=null
with encryption as
begin
  set nocount on
  begin transaction
  begin try
    delete from tblClassMaterials where ClassFK = @KeyField
    delete from tblClassPrerequisites where ClassFK = @KeyField
    delete from tblClasses where KeyField = @KeyField
    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch 
end
go
create procedure uspGetClass
  @KeyField	smallint	
with encryption as
begin
  set nocount on

  select KeyField, Name, [Description], Active,
      convert(bit,case when exists (select KeyField from tblStudentClasses where ClassFK = @KeyField) then 0 else 1 end) as OKToDelete 
    from tblClasses where KeyField = @KeyField

  select KeyField, Description, EstimatedCost, BuyYourself,
    convert(bit,1) as OKToDelete from tblClassMaterials
  where ClassFK = @KeyField
  
  select t2.*, t3.Name
	from tblClasses as t1
	inner join tblClassPrerequisites as t2 on (t1.KeyField = t2.ClassFK)
	inner join tblClasses as t3 on (t2.PrerequisiteFK = t3.KeyField)
  where t2.ClassFK = 1
  
  /* select t1.KeyField, t1.PrerequisiteFK, 
    convert(bit,1) as OKToDelete, t2.Name 
  from tblClassPrerequisites as t1 
    inner join tblClasses as t2 on (t1.PrerequisiteFK = t2.Keyfield)
	where t1.ClassFK = @KeyField */

end
go
create procedure uspGetClassesLookupTbls
with encryption as
begin
  select KeyField,Product from tblProducts order by Product
  select KeyField,Description,ThirdPartyYN from tblShipVia order by DisplayOrder
  select KeyField,Description from tblReferenceDesc order by DisplayOrder
  select t1.KeyField,
    isNull(t2.Description + ' ','') + isNull(t1.Description,'') as Description 
  from tblRepackagingContainers as t1 
    left outer join tblContainers as t2 on (t1.ContainerFK = t2.KeyField)
  order by t2.Description, t1.Description
  select KeyField,Name from tblClassess order by Name
end
go
create procedure uspUpdClasses
  @KeyField				smallint output,
  @Name					varchar(30)=null,
  @Description			varchar(256)=null,
  @Active				bit=null,
  @ClassMaterials		udttClassMaterials readonly,
  @ClassPrerequisites	udttClassPrerequisites readonly,
  @ErrMsg		varchar(512)=null output
with encryption as
begin
  set nocount on

  begin transaction
  begin try

    if exists (select KeyField from tblClasses where KeyField = @KeyField) 
     
      update tblClasses set Name = @Name, 
	Description = @Description,
	Active = @Active
      where KeyField = @KeyField

    else begin 
      insert into tblClassess (Name, Description, Active) 
        values (@Name, @Description, @Active)
      set @KeyField = scope_identity()
    end

    -- Update tblClassMaterials for Delete, Updates, and Inserts

    delete from tblClassMaterials where KeyField in
      (select KeyField from tblClassMaterials where DeleteYN = 1)

    update t set t.Description = t1.Description,
      t.EstimatedCost = t1.EstimatedCost,
      t.BuyYourself = t1.BuyYourself
    from tblClassMaterials as t
      inner join @ClassMaterials as t1 on (t.KeyField = t1.KeyField)

    insert into tblClassMaterials (ClassFK,Description,EstimatedCost,BuyYourself)
      select @KeyField,Description,EstimatedCost,BuyYourself
      from @ClassMaterials where KeyField < 0    
	  
	-- Update tblClassPrerequisites for Delete, Updates, and Inserts
	
	delete from tblClassPrerequisites where KeyField in
	  (select KeyField from tblClassPrerequisites where DeleteYN = 1)
	  
	update t set t.PrerequisiteFK
	from tblClassPrerequisites as t
	  inner join @ClassPrerequisites as t1 on (t.KeyField = t1.KeyField)
	  
	  insert into tblClassMaterials (ClassFK,PrerequisiteFK)
	    select @KeyField,PrerequisiteFK
		from @ClassPrerequisites where KeyField < 0

    -- Update tblClassesLabels for Delete, Update, and Inserts

    delete from tblClassesLabels where KeyField in
      (select KeyField from @Labels where DeleteYN = 1)

    update t set t.WarningLabel = t1.WarningLabel,
      t.WarningLabelPartB = t1.WarningLabelPartB,
      t.UseWarningLabelPartBYN = t1.UseWarningLabelPartBYN,
      t.LabelFontSize = t1.LabelFontSize,
      t.TopCertLabelFontSize = t1.TopCertLabelFontSize,
      t.BottomCertLabelFontSize = t1.BottomCertLabelFontSize,
      t.UseWPartA = t1.UseWPartA,
      t.UseWPartB = t1.UseWPartB,
      t.MixRatio = t1.MixRatio
    from tblClassesLabels as t
      inner join @Labels as t1 on (t.KeyField = t1.KeyField)

    insert into tblClassesLabels (ClassesFK,ProductFK,WarningLabel,WarningLabelPartB,
        UseWarningLabelPartBYN,LabelFontSize,TopCertLabelFontSize,
        BottomCertLabelFontSize,UseWPartA,UseWPartB,MixRatio)
      select @KeyField,ProductFK,WarningLabel,WarningLabelPartB,
        UseWarningLabelPartBYN,LabelFontSize,TopCertLabelFontSize,
        BottomCertLabelFontSize,UseWPartA,UseWPartB,MixRatio
      from @Labels where KeyField < 0    

    -- Update tblClassesPricing for Delete, Update, and Inserts

    delete from tblClassesPricing where KeyField in
      (select KeyField from @Pricing where DeleteYN = 1)

    update t set t.ProductFK = t1.ProductFK,
      t.ClassesPartNo = t1.ClassesPartNo,
      t.ReferenceDescFK = t1.ReferenceDescFK,
      t.ReferenceNo = t1.ReferenceNo,
      t.RepackagingContainerFK = t1.RepackagingContainerFK,
      t.Price = t1.Price
    from tblClassesPricing as t
      inner join @Pricing as t1 on (t.KeyField = t1.KeyField)

    insert into tblClassesPricing (ClassesFK,ProductFK,ClassesPartNo,
        ReferenceDescFK,RepackagingContainerFK,Price)
      select @KeyField,ProductFK,ClassesPartNo,
        ReferenceDescFK,RepackagingContainerFK,Price
      from @Pricing where KeyField < 0    

    -- Update tblClassesShipVia for Delete, Update, and Inserts

    delete from tblClassesShipVia where KeyField in
      (select KeyField from @ShipVia where DeleteYN = 1)

    update t set t.ShipViaFK = t1.ShipViaFK,
                 t.ShippingAccountNo = t1.ShippingAccountNo
    from tblClassesShipVia as t
      inner join @ShipVia as t1 on (t.KeyField = t1.KeyField)

    insert into tblClassesShipVia (ClassesFK,ShipViaFK,ShippingAccountNo)
      select @KeyField,ShipViaFK,ShippingAccountNo
      from @ShipVia where KeyField < 0    

    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch
end
go
create procedure uspGetClassMaterials
with encryption as
begin
select * from tblClassMaterials
end
go