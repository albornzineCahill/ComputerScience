/********************************************************

      Written by CT Software Systems, LLC
      Last Updated: 12/20/2013

********************************************************/


if exists (select name from sysobjects where name = 'uspDelCustomer')
   drop procedure uspDelCustomer
if exists (select name from sysobjects where name = 'uspGetCustomer')
   drop procedure uspGetCustomer
if exists (select name from sysobjects where name = 'uspGetProductDefaultWarningLabel')
   drop procedure uspGetProductDefaultWarningLabel
if exists (select name from sysobjects where name = 'uspGetCustomerLookupTbls')
   drop procedure uspGetCustomerLookupTbls
if exists (select name from sysobjects where name = 'uspUpdCustomer')
   drop procedure uspUpdCustomer
go

create procedure uspDelCustomer
  @KeyField	smallint,
  @ErrMsg	varchar(512)=null output
with encryption as
begin
  set nocount on
  begin transaction
  begin try
    delete from tblCustomerBuyers where CustomerFK = @KeyField
    delete from tblCustomerLabels where CustomerFK = @KeyField
    delete from tblCustomerPricing where CustomerFK = @KeyField
    delete from tblCustomerShipVia where CustomerFK = @KeyField
    delete from tblCustomers where KeyField = @KeyField
    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch 
end
go
create procedure uspGetCustomer
  @KeyField	smallint	
with encryption as
begin
  set nocount on

  select KeyField, Name, Adr1, Adr2, Adr3, Adr4,
      FinalDestAdr1, FinalDestAdr2, FinalDestAdr3, FinalDestAdr4, PWA_End_UseYN,
      convert(bit,case when exists (select KeyField from tblOrders where CustomerFK = @KeyField) then 0 else 1 end) as OKToDelete 
    from tblCustomers where KeyField = @KeyField

  declare @idx table (tblNm varchar(50))
  insert into @idx (tblNm) values ('Buyers')
  insert into @idx (tblNm) values ('Pricing')
  insert into @idx (tblNm) values ('ShipVia')
  insert into @idx (tblNm) values ('Labels')

  select tblNm from @idx

  select t1.KeyField,t1.Name,t1.Code,t1.Phone,t1.Attn,t1.Facility,
    case when exists 
      (select KeyField from tblOrders where BuyerFK = t1.KeyField) 
      then convert(bit,0) else convert(bit,1) end as OKToDelete,
    convert(bit,0) as DeleteYN   
  from tblCustomerBuyers as t1
  where t1.CustomerFK = @KeyField
  
  select t1.KeyField,t1.ProductFK,t2.Product,t1.CustomerPartNo,
    t1.ReferenceDescFK,t3.Description as ReferenceDesc,t1.ReferenceNo,
    t1.RepackagingContainerFK,
    isNull(t5.Description + ' ','') + isNull(t4.Description,'') as RepackagingContainer,
    t1.Price,
    case when exists 
      (select t4.KeyField from tblOrders as t3 
         inner join tblOrderDtl as t4 on (t3.KeyField = t4.OrderFK)
         where t3.CustomerFK = t1.CustomerFK)
      then convert(bit,0) else convert(bit,1) end as OKToDelete,
    convert(bit,0) as DeleteYN  
    from tblCustomerPricing as t1
      left outer join tblProducts as t2 on (t1.ProductFK = t2.KeyField) 
      left outer join tblReferenceDesc as t3 on (t1.ReferenceDescFK = t3.KeyField)
      left outer join tblRepackagingContainers as t4 on (t1.RepackagingContainerFK = t4.KeyField)
      left outer join tblContainers as t5 on (t4.ContainerFK = t5.KeyField)
  where CustomerFK = @KeyField    

  select t1.KeyField,t1.ShipViaFK,t2.Description as ShipVia,t1.ShippingAccountNo,
    case when exists 
      (select KeyField from tblOrderDtl where ShipViaFK = t1.ShipViaFK)
      then convert(bit,0) else convert(bit,1) end as OKToDelete,
    convert(bit,0) as DeleteYN     
  from tblCustomerShipVia as t1
    left outer join tblShipVia as t2 on (t1.ShipViaFK = t2.KeyField)
  where CustomerFK = @KeyField    

  select t1.KeyField,t1.ProductFK,t2.Product,t1.WarningLabel,t1.WarningLabelPartB,
    t1.UseWarningLabelPartBYN,t1.LabelFontSize,t1.TopCertLabelFontSize,
    t1.BottomCertLabelFontSize,t1.UseWPartA,t2.UseWPartB,t1.MixRatio,
    case when exists 
          (select t5.KeyField from tblOrders as t5 
             inner join tblOrderDtl as t6 on (t5.KeyField = t6.OrderFK)
           where t5.CustomerFK = t1.CustomerFK and t6.ProductFK = t1.ProductFK)
         then convert(bit,0) else convert(bit,1) end as OKToDelete,
    convert(bit,0) as DeleteYN     
  from tblCustomerLabels as t1
    inner join tblProducts as t2 on (t1.ProductFK = t2.KeyField)
  where t1.CustomerFK = @KeyField order by t2.Product  
end
go
create procedure uspGetProductDefaultWarningLabel
  @ProductFK 			smallint,
  @WarningLabel			varchar(max)=null output,
  @WarningLabelPartB		varchar(max)=null output,
  @UseWarningLabelPartBYN	bit=null output,
  @LabelFontSize		tinyint=null output,
  @TopCertLabelFontSize		tinyint=null output,
  @BottomCertLabelFontSize	tinyint=null output,
  @UseWPartA			varchar(75)=null output,
  @UseWPartB			varchar(75)=null output,
  @MixRatio			varchar(75)=null output
with encryption as
begin
  set nocount on
  select @WarningLabel = WarningLabel,
    @WarningLabelPartB = WarningLabelPartB,
    @UseWarningLabelPartBYN = UseWarningLabelPartBYN,
    @LabelFontSize = LabelFontSize,
    @TopCertLabelFontSize = TopCertLabelFontSize,
    @BottomCertLabelFontSize = BottomCertLabelFontSize,
    @UseWPartA = UseWPartA,
    @UseWPartB = UseWPartB,
    @MixRatio = MixRatio from tblProducts where KeyField = @ProductFK
end
go
create procedure uspGetCustomerLookupTbls
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
  select KeyField,Name from tblCustomers order by Name
end
go
create procedure uspUpdCustomer
  @KeyField		smallint output,
  @Name			varchar(50)=null,
  @Adr1			varchar(50)=null,
  @Adr2			varchar(50)=null,
  @Adr3			varchar(50)=null,
  @Adr4			varchar(50)=null,
  @FinalDestAdr1	varchar(50)=null,
  @FinalDestAdr2	varchar(50)=null,
  @FinalDestAdr3	varchar(50)=null,
  @FinalDestAdr4	varchar(50)=null,
  @PWA_End_UseYN	bit=null,
  @Buyers		udttCustomerBuyer readonly,
  @Labels		udttCustomerLabel readonly,
  @Pricing		udttCustomerPricing readonly,
  @ShipVia		udttCustomerShipVia readonly,
  @ErrMsg		varchar(512)=null output
with encryption as
begin
  set nocount on

  begin transaction
  begin try

    if exists (select KeyField from tblCustomers where KeyField = @KeyField) 
     
      update tblCustomers set Name = @Name, 
	Adr1 = @Adr1,
	Adr2 = @Adr2,
	Adr3 = @Adr3,
	Adr4 = @Adr4,
	FinalDestAdr1 = @FinalDestAdr1,
	FinalDestAdr2 = @FinalDestAdr2,
	FinalDestAdr3 = @FinalDestAdr3,
	FinalDestAdr4 = @FinalDestAdr4,
	PWA_End_UseYN = @PWA_End_UseYN 
      where KeyField = @KeyField

    else begin 
      insert into tblCustomers (Name,Adr1,Adr2,Adr3,Adr4,
        FinalDestAdr1,FinalDestAdr2,FinalDestAdr3,FinalDestAdr4,PWA_End_UseYN) 
        values (@Name,@Adr1,@Adr2,@Adr3,@Adr4,
          @FinalDestAdr1,@FinalDestAdr2,@FinalDestAdr3,@FinalDestAdr4,@PWA_End_UseYN)
      set @KeyField = scope_identity()
    end

    -- Update tblCustomerBuyers for Delete, Updates, and Inserts

    delete from tblCustomerBuyers where KeyField in
      (select KeyField from @Buyers where DeleteYN = 1)

    update t set t.Name = t1.Name,
      t.Code = t1.Code,
      t.Phone = t1.Phone,
      t.Attn = t1.Attn,
      t.Facility = t1.Facility
    from tblCustomerBuyers as t
      inner join @Buyers as t1 on (t.KeyField = t1.KeyField)

    insert into tblCustomerBuyers (CustomerFK,Name,Code,Phone,Attn,Facility)
      select @KeyField,Name,Code,Phone,Attn,Facility
      from @Buyers where KeyField < 0    

    -- Update tblCustomerLabels for Delete, Update, and Inserts

    delete from tblCustomerLabels where KeyField in
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
    from tblCustomerLabels as t
      inner join @Labels as t1 on (t.KeyField = t1.KeyField)

    insert into tblCustomerLabels (CustomerFK,ProductFK,WarningLabel,WarningLabelPartB,
        UseWarningLabelPartBYN,LabelFontSize,TopCertLabelFontSize,
        BottomCertLabelFontSize,UseWPartA,UseWPartB,MixRatio)
      select @KeyField,ProductFK,WarningLabel,WarningLabelPartB,
        UseWarningLabelPartBYN,LabelFontSize,TopCertLabelFontSize,
        BottomCertLabelFontSize,UseWPartA,UseWPartB,MixRatio
      from @Labels where KeyField < 0    

    -- Update tblCustomerPricing for Delete, Update, and Inserts

    delete from tblCustomerPricing where KeyField in
      (select KeyField from @Pricing where DeleteYN = 1)

    update t set t.ProductFK = t1.ProductFK,
      t.CustomerPartNo = t1.CustomerPartNo,
      t.ReferenceDescFK = t1.ReferenceDescFK,
      t.ReferenceNo = t1.ReferenceNo,
      t.RepackagingContainerFK = t1.RepackagingContainerFK,
      t.Price = t1.Price
    from tblCustomerPricing as t
      inner join @Pricing as t1 on (t.KeyField = t1.KeyField)

    insert into tblCustomerPricing (CustomerFK,ProductFK,CustomerPartNo,
        ReferenceDescFK,RepackagingContainerFK,Price)
      select @KeyField,ProductFK,CustomerPartNo,
        ReferenceDescFK,RepackagingContainerFK,Price
      from @Pricing where KeyField < 0    

    -- Update tblCustomerShipVia for Delete, Update, and Inserts

    delete from tblCustomerShipVia where KeyField in
      (select KeyField from @ShipVia where DeleteYN = 1)

    update t set t.ShipViaFK = t1.ShipViaFK,
                 t.ShippingAccountNo = t1.ShippingAccountNo
    from tblCustomerShipVia as t
      inner join @ShipVia as t1 on (t.KeyField = t1.KeyField)

    insert into tblCustomerShipVia (CustomerFK,ShipViaFK,ShippingAccountNo)
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
