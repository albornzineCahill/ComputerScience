/********************************************************

      Written by Computer Science Class
      Last Updated: 11/10/2014

********************************************************/

-- First drop dependent stored procedure - Remember to go back to tblColors.sql and re-execute after doing this.

--if exists (select name from sysobjects where name = 'uspUpdColors')
--   drop procedure uspUpdColors
if type_id('udttMedHist') is not null 
  drop type udttMedHist
go
create type udttMedHist as table(
  PersonFK						smallint,
  HealthCondition				tinyint			null,
  ConditionExplanation			varchar(100)	null,
  HealthTreatment				varchar(100)	null,
  HasAsthma						bit				null,
  HasSinusitis					bit				null,
  HasBronchitis					bit				null,
  HasKidneyTrouble				bit				null,
  HasHeartTrouble				bit				null,
  HasDiabetes					bit				null,
  HasDizziness					bit				null,
  HasStomachUpset				bit				null,
  HasHayFever					bit				null,
  Explanation					varchar(200)	null,
  PastOperationsOrIllnesses		varchar(200)	null,
  CurrentMeds					varchar(100)	null,
  SpecialDietOrNeeds			varchar(100)	null,
  HadChickenPox					bit				null,
  HadMeasles					bit				null,
  HadMumps						bit				null,
  HadWhoopingCough				bit				null,
  OtherChildhoodDiseases		varchar(100)	null,
  DateOfTetanusShot				date			null,
  FamilyDoctor					varchar(50)		null,
  FamilyDoctorPhone				varchar(20)		null)  
go
  