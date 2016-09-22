using CSMVC4SchoolProject.Models;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace CSMVC4SchoolProject.DataRepository
{
    public class RoomsRepository
    {
        protected class UpdatedRooms : List<Room>, IEnumerable<SqlDataRecord>
        {
            IEnumerator<SqlDataRecord> IEnumerable<SqlDataRecord>.GetEnumerator()
            {

                SqlDataRecord sdr = new SqlDataRecord(
                    new SqlMetaData("KeyField", SqlDbType.SmallInt),
                    new SqlMetaData("description", SqlDbType.VarChar, 30),
                    new SqlMetaData("MaxStudents", SqlDbType.Int),
                    new SqlMetaData("DeletedYN", SqlDbType.Bit),
                    new SqlMetaData("UpdateYN", SqlDbType.Bit),
                    new SqlMetaData("OKToDelete", SqlDbType.Bit));

                foreach (Room i in this)
                {
                    sdr.SetSqlInt16(0, i.KeyField);
                    sdr.SetString(1, i.description);
                    sdr.SetSqlNullableInt32(2, i.MaxStudents);
                    sdr.SetBoolean(3, i.DeleteYN);
                    sdr.SetBoolean(4, i.UpdateYN);
                    sdr.SetBoolean(5, i.OKToDelete);
                    yield return sdr;
                }
            }
        }

        public List<Room> GetRooms()
        {
            List<Room> l = new List<Room>();
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspGetRooms";
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        Room i = new Room();

                        i.KeyField = Convert.ToInt16(rdr["KeyField"].ToString());
                        i.description = rdr["Description"].ToString();
                        if (rdr["MaxStudents"].ToString().Length > 0)
                        {
                            i.MaxStudents = Convert.ToInt32(rdr["MaxStudents"].ToString());
                        }
                        l.Add(i);
                    }
                }
                return l;
            }
        }
        public string UpdRooms(List<Room> data)
        {
            UpdatedRooms ui = new UpdatedRooms();
            foreach (Room i in data)
                ui.Add(i);

            string errMsg = "";
            if (data.Count > 0)
            {
                using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
                {
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "uspUpdRooms";
                        cmd.Parameters.Add("@Rooms", SqlDbType.Structured).Value = ui;
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