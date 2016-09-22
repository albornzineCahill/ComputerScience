using CSMVC4SchoolProject.Models;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace CSMVC4SchoolProject.DataRepository
{
    public class PeopleRepository
    {
        public People getPersonGeneral(short keyfield)
        {
            People p = new People();
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspGetPersonGeneral";
                    cmd.Parameters.Add("@keyfield", SqlDbType.SmallInt).Value = keyfield;
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        //tblAddresses.Adr1, tblAddresses.Adr2, tblAddresses.City, tblAddresses.St, tblAddresses.ZIP

                        p.keyfield = DbUtilities.GetShort(rdr, "KeyField");
                        p.FirstName = rdr["FirstName"].ToString();
                        p.LastName = rdr["LastName"].ToString();
                        p.age = DbUtilities.GetByte(rdr, "age");
                        p.DOB = DbUtilities.GetNullableDateTime(rdr, "DOB");
                        p.Gender = rdr["Gender"].ToString();
                        p.SSN = rdr["SSN"].ToString();
                        p.PrimaryPhone = rdr["PrimaryPhone"].ToString();
                        p.SecondaryPhone = rdr["SecondaryPhone"].ToString();

                    }
                    rdr.NextResult();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            Addresses a = new Addresses();
                            a.Adr1 = rdr["adr1"].ToString();
                            a.Adr2 = rdr["adr2"].ToString();
                            a.City = rdr["City"].ToString();
                            a.St = rdr["St"].ToString();
                            a.ZIP = rdr["ZIP"].ToString();
                            p.Addresses.Add(a);

                            // professional way

                            //p.Addresses.Add(new Addresses()
                            //{
                            //    Adr1 = rdr["adr1"].ToString(),
                            //    Adr2 = rdr["adr2"].ToString(),
                            //    City = rdr["city"].ToString(),
                            //    St = rdr["St"].ToString(),
                            //    ZIP = rdr["ZIP"].ToString()
                            //});

                        }
                    }
                }
                return p;
            }
        }

        public People getPersonChurch(short keyfield)
        {
            People p = new People();
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspGetPersonChurch";
                    cmd.Parameters.Add("@keyfield", SqlDbType.SmallInt).Value = keyfield;
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        //tblAddresses.Adr1, tblAddresses.Adr2, tblAddresses.City, tblAddresses.St, tblAddresses.ZIP

                        p.keyfield = DbUtilities.GetShort(rdr, "KeyField");
                        p.Church = rdr["Church"].ToString();
                        p.Denomination = rdr["Denomination"].ToString();

                    }
                }
              
                return p;
            }
        }

        public People getPersonHealth(short keyfield)
        {
            People p = new People();
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspGetPersonHealth";
                    cmd.Parameters.Add("@keyfield", SqlDbType.SmallInt).Value = keyfield;
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Allergies a = new Allergies();
                        a.Keyfield = DbUtilities.GetShort(rdr, "KeyField");
                        a.allergyDescription = rdr["Description"].ToString();
                        p.Allergies.Add(a);
                    }
                    rdr.NextResult();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            Insurances i = new Insurances();
                            i.keyfield = DbUtilities.GetShort(rdr, "keyfield");
                            i.InsuranceCo = rdr["InsuranceCo"].ToString();
                            i.PolicyNum = rdr["PolicyNum"].ToString();
                            i.SubscriberName = rdr["SubscriberName"].ToString();
                            i.SubscriberNum = rdr["SubscriberNum"].ToString();
                            i.SubscriberEmployer = rdr["SubscriberEmployer"].ToString();
                            i.SubscriberJob = rdr["SubscriberJob"].ToString();
                            i.SubscriberWorkPhone = rdr["SubscriberWorkPhone"].ToString();
                            p.Insurances.Add(i);
                        }
                    }
                    rdr.NextResult();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            MedHist mh = new MedHist();
                            mh.keyfield = DbUtilities.GetShort(rdr, "KeyField");
                            mh.HealthCondition = DbUtilities.GetByte(rdr, "HealthCondition");
                            mh.ConditionExplanation = rdr["ConditionExplanation"].ToString();
                            mh.HealthTreatment = rdr["HealthTreatment"].ToString();
                            mh.HasAsthma = DbUtilities.GetBool(rdr, "HasAsthma");
                            mh.HasSinusitis = DbUtilities.GetBool(rdr, "HasSinusitis");
                            mh.HasBronchitis = DbUtilities.GetBool(rdr, "HasBronchitis");
                            mh.HasKidneyTrouble = DbUtilities.GetBool(rdr, "HasKidneyTrouble");
                            mh.HasHeartTrouble = DbUtilities.GetBool(rdr, "HasHeartTrouble");
                            mh.HasDiabetes = DbUtilities.GetBool(rdr, "HasDiabetes");
                            mh.HasDizziness = DbUtilities.GetBool(rdr, "HasDizziness");
                            mh.HasStomachUpset = DbUtilities.GetBool(rdr, "HasStomachUpset");
                            mh.HasHayFever = DbUtilities.GetBool(rdr, "HasHayFever");
                            mh.Explanation = rdr["Explanation"].ToString();
                            mh.PastOperationsOrIllnesses = rdr["PastOperationsOrIllnesses"].ToString();
                            mh.CurrentMeds = rdr["CurrentMeds"].ToString();
                            mh.SpecialDietOrNeeds = rdr["SpecialDietOrNeeds"].ToString();
                            mh.HadChickenPox = DbUtilities.GetBool(rdr, "HadChickenPox");
                            mh.HadMeasles = DbUtilities.GetBool(rdr, "HadMeasles");
                            mh.HadMumps = DbUtilities.GetBool(rdr, "HadMumps");
                            mh.HadWhoopingCough = DbUtilities.GetBool(rdr, "HadWhoopingCough");
                            mh.OtherChildhoodDiseases = rdr["OtherChildhoodDiseases"].ToString();
                            mh.DateOfTetanusShot = DbUtilities.GetDateTime(rdr, "DateOfTetanusShot");
                            mh.FamilyDoctor = rdr["FamilyDoctor"].ToString();
                            mh.FamilyDoctorPhone = rdr["FamilyDoctorPhone"].ToString();
                            p.MedHist.Add(mh);
                        }
                    }
                }

                return p;
            }
        }

        protected class UpdatedPeople : List<People>, IEnumerable<SqlDataRecord>
        {
            IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
            {

                SqlDataRecord sdr = new SqlDataRecord(
                    new SqlMetaData("AddressFK", SqlDbType.SmallInt),
                    new SqlMetaData("age", SqlDbType.SmallInt, 30),
                    new SqlMetaData("Church", SqlDbType.VarChar),
                    new SqlMetaData("Denomination", SqlDbType.VarChar),
                    new SqlMetaData("DisabilitiesExplanation", SqlDbType.VarChar),
                    new SqlMetaData("DOB", SqlDbType.Date),
                    new SqlMetaData("EducationFK", SqlDbType.SmallInt),
                    new SqlMetaData("EducationMajor", SqlDbType.VarChar),
                    new SqlMetaData("Email", SqlDbType.VarChar),
                    new SqlMetaData("EmergencyNotify", SqlDbType.VarChar),
                    new SqlMetaData("Employer", SqlDbType.VarChar),
                    new SqlMetaData("EmployerPhone", SqlDbType.VarChar),
                    new SqlMetaData("EnrollmentTypeFK", SqlDbType.SmallInt),
                    new SqlMetaData("FamilyKey", SqlDbType.SmallInt),
                    new SqlMetaData("FirstName", SqlDbType.VarChar),
                    new SqlMetaData("Gender", SqlDbType.VarChar),
                    new SqlMetaData("Grade", SqlDbType.SmallInt),
                    new SqlMetaData("HasLearningDisabilities", SqlDbType.Bit),
                    new SqlMetaData("HasPhysicalDisabilities", SqlDbType.Bit),
                    new SqlMetaData("InHSLDA", SqlDbType.Bit),
                    new SqlMetaData("inMTHEA", SqlDbType.Bit),
                    new SqlMetaData("IsPrimaryAddress", SqlDbType.Bit),
                    new SqlMetaData("keyfield", SqlDbType.SmallInt),
                    new SqlMetaData("LastName", SqlDbType.VarChar),
                    new SqlMetaData("LastYrSchool", SqlDbType.VarChar),
                    new SqlMetaData("PersonFK", SqlDbType.SmallInt),
                    new SqlMetaData("PrimaryInsurance", SqlDbType.VarChar),
                    new SqlMetaData("PrimaryPhone", SqlDbType.VarChar),
                    new SqlMetaData("SecondaryPhone", SqlDbType.VarChar),
                    new SqlMetaData("SSN", SqlDbType.VarChar),
                    new SqlMetaData("SupportGroupOrCoop", SqlDbType.VarChar),
                    new SqlMetaData("WillGraduate", SqlDbType.Bit));

                foreach (People i in this)
                {
                    sdr.SetSqlInt16(0, i.AddressFK);
                    sdr.SetSqlInt16(1, i.age);
                    sdr.SetString(3, i.Church);
                    sdr.SetString(4, i.Denomination);
                    sdr.SetString(5, i.DisabilitiesExplanation);
                    sdr.SetNullableDateTime(5, i.DOB);
                    sdr.SetSqlInt16(5, i.EducationFK);
                    sdr.SetString(5, i.EducationMajor);
                    sdr.SetString(5, i.Email);
                    sdr.SetString(5, i.EmergencyNotify);
                    sdr.SetString(5, i.Employer);
                    sdr.SetString(5, i.EmployerPhone);
                    sdr.SetSqlInt16(5, i.EnrollmentTypeFK);
                   // sdr.SetSqlInt16(5, i.FamilyKey);
                    sdr.SetString(5, i.FirstName);
                    sdr.SetString(5, i.Gender);
                    sdr.SetSqlInt16(5, i.Grade);
                    sdr.SetBoolean(5, i.HasLearningDisabilities);
                    sdr.SetBoolean(5, i.HasPhysicalDisabilities);
                    sdr.SetBoolean(5, i.InHSLDA);
                    sdr.SetBoolean(5, i.inMTHEA);
                    sdr.SetBoolean(5, i.IsPrimaryAddress);
                    sdr.SetSqlInt16(5, i.keyfield);
                    sdr.SetString(5, i.LastName);
                    sdr.SetString(5, i.LastYrSchool);
                    sdr.SetSqlInt16(5, i.PersonFK);
                    sdr.SetBoolean(5, i.PrimaryInsurance);
                    sdr.SetString(5, i.PrimaryPhone);
                    sdr.SetString(5, i.SecondaryPhone);
                    sdr.SetString(5, i.SSN);
                    sdr.SetString(5, i.SupportGroupOrCoop);
                    sdr.SetBoolean(5, i.WillGraduate);
                    yield return sdr;
                }
            }

        }
        public List<LookUp> getPeople(short? personTypeFK)
        {
            List<LookUp> l = new List<LookUp>();
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspGetPeople";
                    if (personTypeFK != null)
                    {
                        cmd.Parameters.Add("@personTypeFK", SqlDbType.SmallInt).Value = personTypeFK;
                    }
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        LookUp p = new LookUp();

                        p.keyfield = Convert.ToInt16(rdr["KeyField"].ToString());
                        p.name = rdr["name"].ToString();
                        l.Add(p);
                    }
                }
                return l;
            }
        }

        public string UpdPeople(List<People> data)
        {
            UpdatedPeople up = new UpdatedPeople();
            foreach (People i in data)
                up.Add(i);

            string errMsg = "";
            if (data.Count > 0)
            {
                using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
                {
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "uspUpdPeople";
                        cmd.Parameters.Add("@Rooms", SqlDbType.Structured).Value = up;
                        cmd.Parameters.Add("@ErrMsg", SqlDbType.VarChar, 512).Direction = ParameterDirection.InputOutput;
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        if (!Convert.IsDBNull(cmd.Parameters["@ErrMsg"].Value))
                            return cmd.Parameters["@ErrMsg"].Value.ToString();
                        conn.Close();
                    }
                }
            }
            return errMsg;
        }
    }
}