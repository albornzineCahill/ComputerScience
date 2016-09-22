/********************************************************

      Written by CT Software Systems, LLC
      Last Updated: 2/2/2015
	  
********************************************************/


if exists (select name from sysobjects where name = 'uspGetPeople')
   drop procedure uspGetPeople
/* if exists (select name from sysobjects where name = 'uspGetClassesLookupTbls')
   drop procedure uspGetClassesLookupTbls */
if exists (select name from sysobjects where name = 'uspUpdClass')
   drop procedure uspUpdClass
if exists (select name from sysobjects where name = 'uspGetClassMaterials')
   drop procedure uspGetClassMaterials
if exists (select name from sysobjects where name = 'uspGetPerson')
   drop procedure uspGetPerson
if exists (select name from sysobjects where name = 'uspUpdPeople')
   drop procedure uspUpdPeople
if exists (select name from sysobjects where name = 'uspGetPersonSchool')
   drop procedure uspGetPersonSchool
if exists (select name from sysobjects where name = 'uspGetPersonGeneral')
   drop procedure uspGetPersonGeneral
if exists (select name from sysobjects where name = 'uspGetPersonHealth')
   drop procedure uspGetPersonHealth
if exists (select name from sysobjects where name = 'uspGetPersonChurch')
   drop procedure uspGetPersonChurch
if exists (select name from sysobjects where name = 'uspGetpersonParentInfo')
   drop procedure uspGetpersonParentInfo

if exists (select name from sysobjects where name = 'uspUpdPersonSchool')
   drop procedure uspUpdPersonSchool
if exists (select name from sysobjects where name = 'uspUpdPersonGeneral')
   drop procedure uspUpdPersonGeneral
if exists (select name from sysobjects where name = 'uspUpdPersonHealth')
   drop procedure uspUpdPersonHealth
if exists (select name from sysobjects where name = 'uspUpdPersonChurch')
   drop procedure uspUpdPersonChurch
   
go
create procedure uspGetPeople
  @PersonTypeFK smallint = null
with encryption as
begin
  set nocount on

  if (@PersonTypeFK is null or @PersonTypeFK = 0) begin
	select KeyField, LastName+', '+ FirstName as name from tblPeople order by LastName, FirstName
  end else begin
	select KeyField, LastName+', '+ FirstName as name from tblPeople where PersonTypeFK = @PersonTypeFK order by LastName, FirstName
  end
	
end
go

create procedure uspGetPerson
	@keyfield		smallint = null
with encryption as
begin
set nocount on
select KeyField, FirstName, LastName, Age, DOB, Gender, Grade,
	WillGraduate, EnrollmentTypeFK, PrimaryAddressFK, PrimaryPhone, SecondaryPhone,
	PersonTypeFK, EmergencyNotify, SSN, PrimaryInsurance,
	HasPhysicalDisabilities, HasLearningDisabilities, DisabilitiesExplanation,
	Email, Church, Denomination, LastYrSchool, SupportGroupOrCoop, Employer,
	EmployerPhone, EducationFK, EducationMajor, InMTHEA, InHSLDA, FamilyKey
 from tblPeople 
 where [KeyField] = @keyfield

 select KeyField, FamilyKey, Adr1, Adr2, City, St, ZIP
 from tblAddresses 
 where FamilyKey = @keyfield


end
go

Create procedure uspGetPersonGeneral
	@keyfield		smallint = null
with encryption as
begin
set nocount on
declare @FamilyKey smallInt

select @FamilyKey = FamilyKey
from tblPeople
where KeyField = @keyfield

select keyField, FirstName, LastName, Age, DOB, Gender, SSN, PrimaryPhone, SecondaryPhone, [PrimaryAddressFK]
from tblPeople
where KeyField = @keyfield

select KeyField, Adr1, Adr2, City, St, ZIP, FamilyKey
from tblAddresses
where FamilyKey = @FamilyKey
end
go

Create procedure uspGetPersonSchool
	@keyfield		smallint = null
with encryption as
begin
set nocount on

select grade, WillGraduate, EnrollmentTypeFK, PersonTypeFK, LastYrSchool, SupportGroupOrCoop, InMTHEA, InHSLDA
from tblPeople 
where keyfield = @keyfield

select keyfield, [Description] from tblEnrollmentTypes order by DisplayOrder

select keyfield, [Description] from tblPersonType
end
go

Create procedure uspGetPersonChurch
	@keyfield		smallint = null
with encryption as
begin
set nocount on

select Church, Denomination, keyfield
from tblPeople
where KeyField = @keyfield

end
go

Create procedure uspGetPersonHealth
	@keyfield		smallint = null
with encryption as
begin
set nocount on

select keyfield, [Description]
from tblAllergies
where PersonFK = @keyfield

select keyfield, InsuranceCo, PolicyNum, SubscriberName, SubscriberNum, SubscriberEmployer, SubscriberJob, SubscriberWorkPhone
from tblInsurances
where PersonFK = @keyfield

select keyfield, HealthCondition, ConditionExplanation, HealthTreatment, HasAsthma, HasSinusitis, HasBronchitis, HasKidneyTrouble, HasHeartTrouble, 
HasDiabetes, HasDizziness, HasStomachUpset, HasHayFever, Explanation, PastOperationsOrIllnesses, CurrentMeds, SpecialDietOrNeeds, 
HadChickenPox, HadMeasles, HadMumps, HadWhoopingCough, OtherChildhoodDiseases, DateOfTetanusShot, FamilyDoctor, FamilyDoctorPhone
from tblMedHist
where PersonFK = @keyfield

end
go


Create procedure uspGetpersonParentInfo
	@keyfield		smallint = null
with encryption as
begin
set nocount on
declare @familyKey			smallint
declare @momKeyfield		smallint
declare @momFirstname		varchar(30)
declare @momLirstName		varchar(30)
declare @momPhone			varchar(20)
declare @momEmail			varchar(30)
declare @dadKeyfield		smallint
declare @dadFirstname		varchar(30)
declare @dadLirstName		varchar(30)
declare @dadEmail			varchar(30)
declare @dadPhone			varchar(20)

select @familyKey = @familyKey from tblPeople where KeyField = @keyfield

select @momKeyfield = KeyField,
 @momFirstname = FirstName,
 @momLirstName =LastName,
 @momEmail =Email, 
 @momPhone =PrimaryPhone
from tblPeople 
where FamilyKey = @keyfield and Gender = 'F' and PersonTypeFK= 2

select @dadKeyfield = KeyField,
 @dadFirstname = FirstName,
 @dadLirstName =LastName,
 @dadEmail =Email, 
 @dadPhone =PrimaryPhone
from tblPeople 
where FamilyKey = @keyfield and Gender = 'M' and PersonTypeFK= 2

select @familyKey as FamilyKey
 @momKeyfield as momKeyField,
 @momFirstname as momFirstName,
 @momLirstName as momLastName,
 @momEmail as momEmail, 
 @momPhone as momPrimaryPhone,
 @dadKeyfield as dadKeyField,
 @dadFirstname as dadFirstName,
 @dadLirstName as dadLastName,
 @dadEmail as dadEmail, 
 @dadPhone as dadPrimaryPhone
end
go

Create procedure uspUpdPersonGeneral
	@FirstName 					varchar(30) =	null,
	@LastName 					varchar(30) =	null,
	@Age 						tinyint 	=	null,
	@DOB 						date 		=	null,
	@Gender 					varchar(1) 	=	null, 
	@SSN 						varchar(11) =	null,
	@IsPrimaryAddress 			bit 		=	null, 
	@PrimaryPhone				varchar(20) =	null,
	@SecondaryPhone				varchar(20) =	null,
	@Adr1						varchar(50) =	null, 
	@Adr2						varchar(50) =	null,
	@City						varchar(20) =	null,
	@St							varchar(2)	=	null, 
	@ZIP						varchar(10) =	null
with encryption as
begin
set nocount on

update tblPeople SET FirstName = @FirstName, LastName = @LastName,
Age = @Age, DOB = @DOB, Gender = @Gender, SSN = @SSN,
PrimaryPhone = @PrimaryPhone, SecondaryPhone = @SecondaryPhone

update tblAddresses SET Adr1 = @Adr1, Adr2 = @Adr2, City = @City, St = @St, ZIP = @ZIP 

end
go


Create procedure uspUpdPersonSchool
	@grade				tinyint= null, 
	@WillGraduate		bit = null,
	@EnrollmentTypeFK	smallint = null, 
	@PersonTypeFK		smallint = null, 
	@LastYrSchool		varchar(50) = null,
	@SupportGroupOrCoop	Varchar(50) = null, 
	@InMTHEA			bit = null, 
	@InHSLDA			bit = null
with encryption as
begin
set nocount on

update tblPeople set grade = @grade , WillGraduate = @WillGraduate , EnrollmentTypeFK = @EnrollmentTypeFK ,
					 PersonTypeFK = @PersonTypeFK , LastYrSchool = @LastYrSchool , SupportGroupOrCoop = @SupportGroupOrCoop ,
					 InMTHEA = @InMTHEA , InHSLDA = @InHSLDA 

end
go

Create procedure uspUpdPersonChurch
	@KeyField		smallint = null,
	@Church			varchar(50) = null,
	@Denomination	varchar(50) = null
with encryption as
begin
set nocount on

update tblPeople SET Church = @Church, Denomination = @Denomination WHERE KeyField = @KeyField

end
go

Create procedure uspUpdPersonHealth
	@keyfield					smallint = null,
	@Description				varchar(100) = null,
	@InsuranceCo				varchar(50) = null,	
	@PolicyNum					varchar(50) = null, 
	@SubscriberName				varchar(50) = null, 
	@SubscriberNum				varchar(25) = null, 
	@SubscriberEmployer			varchar(50) = null, 
	@SubscriberJob				varchar(50) = null, 
	@SubscriberWorkPhone		varchar(50) = null,
	@HealthCondition			tinyint = null, 
	@ConditionExplanation		varchar(100) = null, 
	@HealthTreatment			varchar(100) = null, 
	@HasAsthma					bit = null, 
	@HasSinusitis				bit = null, 
	@HasBronchitis				bit = null, 
	@HasKidneyTrouble			bit = null, 
	@HasHeartTrouble			bit = null, 
	@HasDiabetes				bit = null, 
	@HasDizziness				bit = null, 
	@HasStomachUpset			bit = null, 
	@HasHayFever				bit = null, 
	@Explanation				varchar(200) = null, 
	@PastOperationsOrIllnesses	varchar(200) = null, 
	@CurrentMeds				varchar(100) = null, 
	@SpecialDietOrNeeds			varchar(100) = null, 
	@HadChickenPox				bit = null, 
	@HadMeasles					bit = null, 
	@HadMumps					bit = null, 
	@HadWhoopingCough			bit = null, 
	@OtherChildhoodDiseases		varchar(100) = null, 
	@DateOfTetanusShot			Date = null, 
	@FamilyDoctor				varchar(50) = null, 
	@FamilyDoctorPhone			varchar(20) = null
	
with encryption as
begin
set nocount on

end
go

/*
create procedure uspUpdPeople

@KeyField 					smallint 		output,
@FirstName 					varchar(30) =	null,
@LastName 					varchar(30) =	null,
@Age 						tinyint 	=	null,
@DOB 						date 		=	null,
@Gender 					varchar(1) 	=	null,
@Grade 						tinyint 	=	null,
@WillGraduate 				bit 		=	null,
@EnrollmentTypeFK 			smallint 	=	null,
@AddressFK 					smallint	=	null,
@PrimaryPhone				varchar(20) =	null,
@SecondaryPhone				varchar(20) =	null,
@PersonTypeFK 				smallint 	=	null,
@EmergencyNotify 			varchar(50) =	null,
@SSN 						varchar(11) =	null,
@IsPrimaryAddress 			bit 		=	null,
@PrimaryInsurance			bit 		=	null,
@HasPhysicalDisabilities 	bit 		=	null,
@HasLearningDisabilities 	bit	 		=	null,
@DisabilitiesExplanation 	varchar(100) =	null,
@Email 						varchar(30) =	null,
@Church 					varchar(50) =	null,
@Denomination 				varchar(50) =	null,
@LastYrSchool 				varchar(50) =	null,
@SupportGroupOrCoop 		varchar(50) =	null,
@Employer 					varchar(50) =	null,
@EmployerPhone 				varchar(20) =	null,
@EducationFK 				tinyint 	=	null,
@EducationMajor 			varchar(30) =	null,
@InMTHEA 					bit 		=	null,
@InHSLDA 					bit 		=	null,
@FamilyKey 					smallint 	=	null,
  @ErrMsg		varchar(512)=null output
with encryption as
begin
  set nocount on
  begin transaction
  begin try

    if exists (select KeyField from tblPeople where KeyField = @KeyField)
	  update tblPeople set
		FirstName = @FirstName, 
		LastName = @LastName, 
		Age = @Age, 
		DOB = @DOB, 
	    Gender = @Gender,
		Grade = @Grade,
		WillGraduate = @WillGraduate,
		EnrollmentTypeFK = @EnrollmentTypeFK,
		AddressFK = @AddressFK,
		PrimaryPhone = @PrimaryPhone, 
		SecondaryPhone = @SecondaryPhone,
		PersonTypeFK = @PersonTypeFK,
		EmergencyNotify = @EmergencyNotify,
		SSN = @SSN,
		IsPrimaryAddress = @IsPrimaryAddress, 
		PrimaryInsurance = @PrimaryInsurance,
		HasPhysicalDisabilities = @HasPhysicalDisabilities,
		HasLearningDisabilities = @HasLearningDisabilities, 
		DisabilitiesExplanation = @DisabilitiesExplanation,
		Email = @Email,
		Church = @Church,
		Denomination = @Denomination,
		LastYrSchool = @LastYrSchool, 
		SupportGroupOrCoop = @SupportGrouporCoop,
		Employer = @Employer,
		EmployerPhone = @EmployerPhone,
		EducationFK = @EducationFK,
		EducationMajor = @EducationMajor, 
		InMTHEA = @InMTHEA,
		InHSLDA = @InHSLDA,
		FamilyKey = @FamilyKey

	  
	else 
	
	  insert into tblPeople (FirstName, LastName, Age, DOB, 
	    Gender, Grade, WillGraduate, EnrollmentTypeFK, AddressFK, PrimaryPhone, 
		SecondaryPhone, PersonTypeFK, EmergencyNotify, SSN, IsPrimaryAddress, 
		PrimaryInsurance, HasPhysicalDisabilities, HasLearningDisabilities, 
		DisabilitiesExplanation, Email, Church, Denomination, LastYrSchool, 
		SupportGroupOrCoop, Employer, EmployerPhone, EducationFK, EducationMajor, 
		InMTHEA, InHSLDA, FamilyKey)
		values (@FirstName, @LastName, @Age, @DOB, 
	    @Gender, @Grade, @WillGraduate, @EnrollmentTypeFK, @AddressFK, @PrimaryPhone, 
		@SecondaryPhone, @PersonTypeFK, @EmergencyNotify, @SSN, @IsPrimaryAddress, 
		@PrimaryInsurance, @HasPhysicalDisabilities, @HasLearningDisabilities, 
		@DisabilitiesExplanation, @Email, @Church, @Denomination, @LastYrSchool, 
		@SupportGroupOrCoop, @Employer, @EmployerPhone, @EducationFK, @EducationMajor, 
		@InMTHEA, @InHSLDA, @FamilyKey)
     

    commit transaction
  end try
  begin catch
    set @ErrMsg = 'Error ' + Convert(varchar(10),ERROR_NUMBER()) + ' : ' + ERROR_MESSAGE();		
    rollback transaction
  end catch

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
      insert into tblClasses (Name, Description, Active) 
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
*/