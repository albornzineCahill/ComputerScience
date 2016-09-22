using CSMVC4SchoolProject.Models;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace CSMVC4SchoolProject.DataRepository
{
    public class EnrollmentTypesRepository
    {
        protected class UpdatedEnrollmentTypes : List<EnrollmentType>, IEnumerable<SqlDataRecord>
        {
            IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
            {

                SqlDataRecord sdr = new SqlDataRecord(
                    new SqlMetaData("KeyField", SqlDbType.SmallInt),
                    new SqlMetaData("Description", SqlDbType.VarChar, 20),
                    new SqlMetaData("DisplayOrder", SqlDbType.SmallInt),
                    new SqlMetaData("OKToDelete", SqlDbType.Bit),
                    new SqlMetaData("UpdateYN", SqlDbType.Bit),
                    new SqlMetaData("DeletedYN", SqlDbType.Bit));

                foreach (EnrollmentType i in this)
                {
                    sdr.SetSqlInt16(0, i.KeyField);
                    sdr.SetString(1, i.Description);
                    sdr.SetSqlNullableInt16(2, i.DisplayOrder);
                    sdr.SetBoolean(3, i.OKToDelete);
                    sdr.SetBoolean(4, i.UpdateYN);
                    sdr.SetBoolean(5, i.DeleteYN);
                    yield return sdr;
                }
            }
        }

        public List<EnrollmentType> GetEnrollmentTypes()
        {
            List<EnrollmentType> l = new List<EnrollmentType>();
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspGetEnrollmentTypes";
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        EnrollmentType i = new EnrollmentType();
                                               
                        i.KeyField = Convert.ToInt16(rdr["KeyField"].ToString());
                        i.Description = rdr["Description"].ToString();
                        if (rdr["DisplayOrder"].ToString().Length > 0) {
                            i.DisplayOrder = Convert.ToInt16(rdr["DisplayOrder"].ToString());
                        }
                        l.Add(i);
                    }
                }
                return l;
            }
        }
        public string UpdEnrollmentTypes(List<EnrollmentType> data)
        {
            UpdatedEnrollmentTypes ui = new UpdatedEnrollmentTypes();
            foreach (EnrollmentType i in data)
                ui.Add(i);

            string errMsg = "";
            if (data.Count > 0)
            {
                using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
                {
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "uspUpdEnrollmentTypes";
                        cmd.Parameters.Add("@EnrollmentTypes", SqlDbType.Structured).Value = ui;
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