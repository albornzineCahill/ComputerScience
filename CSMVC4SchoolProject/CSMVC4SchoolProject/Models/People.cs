using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CSMVC4SchoolProject.Models
{
    public class People
    {
        public short keyfield { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public byte age { get; set; }
        public DateTime? DOB { get; set; } 
        public string Gender { get; set; }
        public short Grade { get; set; }
        public bool WillGraduate { get; set; }
        public short EnrollmentTypeFK { get; set; }
        public short AddressFK { get; set; }
        public string PrimaryPhone { get; set; }
        public string SecondaryPhone { get; set; }
        public short PersonFK { get; set; }
        public string EmergencyNotify { get; set; }
        public string SSN { get; set; }
        public bool IsPrimaryAddress { get; set; }
        public bool PrimaryInsurance { get; set; }
        public bool HasPhysicalDisabilities { get; set; }
        public bool HasLearningDisabilities { get; set; }
        public string DisabilitiesExplanation { get; set; }
        public string Email { get; set; }
        public string Church { get; set; }
        public string Denomination { get; set; }
        public string LastYrSchool { get; set; }
        public string SupportGroupOrCoop { get; set; }
        public string Employer { get; set; }
        public string EmployerPhone { get; set; }
        public Byte EducationFK { get; set; }
        public string EducationMajor { get; set; }
        public bool inMTHEA { get; set; }
        public bool InHSLDA { get; set; }
        public short FamilyKeAddressy { get; set; }
        public string ErrMsg { get; set; }

        public List<Addresses> Addresses { get; set; }
        public List<Allergies> Allergies { get; set; }
        public List<Insurances> Insurances { get; set; }
        public List<MedHist> MedHist { get; set; }
        public List<StudentClasses> StudentClasses { get; set; }

        public People()
        {
             Addresses = new List<Addresses>();
             Allergies = new List<Allergies>();
             Insurances = new List<Insurances>();
             MedHist = new List<MedHist>();
             StudentClasses = new List<StudentClasses>();
        }
    }
}