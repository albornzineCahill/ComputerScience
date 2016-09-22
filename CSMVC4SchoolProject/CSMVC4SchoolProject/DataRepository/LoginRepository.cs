using CSMVC4SchoolProject.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace CSMVC4SchoolProject.DataRepository
{
    public class LoginRepository
    {

        public byte[] GetSHA2_512Hash(string value)
        {
            SHA512CryptoServiceProvider sha512 = new SHA512CryptoServiceProvider();
            return sha512.ComputeHash(System.Text.Encoding.Default.GetBytes(value));
        }
        public string ValidLogin(string username, byte[] hashedPW)
        {
            string errMsg = "";

            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "uspLogIn";
                    cmd.Parameters.Add("@Username", SqlDbType.VarChar, 50).Value = username;
                    cmd.Parameters.Add("@Password", SqlDbType.VarBinary, 64).Value = hashedPW;
                    cmd.Parameters.Add("@IsValid", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    rdr.Read();
                    rdr.Close();
                    bool IsValid = Convert.ToBoolean(cmd.Parameters["@IsValid"].Value);
                    if (!IsValid)
                    {
                        errMsg = "Wrong username or password!";
                    }
                }
            };
            return errMsg;
        }
    }
}