using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CSMVC4SchoolProject.Models
{
    public class MedHist
    {
        public short keyfield { get; set; }
        public byte HealthCondition { get; set; }
        public string ConditionExplanation { get; set; }
        public string HealthTreatment { get; set; }
        public bool HasAsthma { get; set; }
        public bool HasSinusitis { get; set; }
        public bool HasBronchitis { get; set; }
        public bool HasKidneyTrouble { get; set; }
        public bool HasHeartTrouble { get; set; }
        public bool HasDiabetes { get; set; }
        public bool HasDizziness { get; set; }
        public bool HasStomachUpset { get; set; }
        public bool HasHayFever { get; set; }
        public string Explanation { get; set; }
        public string PastOperationsOrIllnesses { get; set; }
        public string CurrentMeds { get; set; }
        public string SpecialDietOrNeeds { get; set; }
        public bool HadChickenPox { get; set; }
        public bool HadMeasles { get; set; }
        public bool HadMumps { get; set; }
        public bool HadWhoopingCough { get; set; }
        public string OtherChildhoodDiseases { get; set; }
        public DateTime DateOfTetanusShot { get; set; }
        public string FamilyDoctor { get; set; }
        public string FamilyDoctorPhone { get; set; }
    }
}