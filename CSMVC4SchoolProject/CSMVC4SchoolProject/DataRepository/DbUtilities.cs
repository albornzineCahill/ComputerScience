using CSMVC4SchoolProject.Models;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace CSMVC4SchoolProject.DataRepository
{
    public static class DbUtilities
    {
        #region Data conversion wrappers        

        public static bool GetBool(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToBoolean(rdr[fldNm].ToString());
        }
        public static bool GetBool(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToBoolean(rdr[iFldNm].ToString());
        }
        public static byte GetByte(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToByte(rdr[fldNm].ToString());
        }
        public static byte GetByte(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToByte(rdr[iFldNm].ToString());
        }

        public static T GetByteEnum<T>(SqlDataReader rdr, string fldNm) where T : struct
        {
            return (T)(object)GetByte(rdr, fldNm);
        }
        public static T GetByteEnum<T>(SqlDataReader rdr, int iFldNm) where T : struct
        {
            return (T)(object)GetByte(rdr, iFldNm);
        }

        public static DateTime GetDateTime(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToDateTime(rdr[fldNm].ToString());
        }
        public static DateTime GetDateTime(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToDateTime(rdr[iFldNm].ToString());
        }

        public static decimal GetDecimal(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToDecimal(rdr[fldNm].ToString());
        }
        public static decimal GetDecimal(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToDecimal(rdr[iFldNm].ToString());
        }

        public static int GetInt(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToInt32(rdr[fldNm].ToString());
        }
        public static int GetInt(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToInt32(rdr[iFldNm].ToString());
        }

        public static long GetLong(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToInt64(rdr[fldNm].ToString());
        }
        public static long GetLong(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToInt64(rdr[iFldNm].ToString());
        }

        public static short GetShort(SqlDataReader rdr, string fldNm)
        {
            return Convert.ToInt16(rdr[fldNm].ToString());
        }
        public static short GetShort(SqlDataReader rdr, int iFldNm)
        {
            return Convert.ToInt16(rdr[iFldNm].ToString());
        }

        public static bool? GetNullableBool(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0 ? (bool?) Convert.ToBoolean(rdr[fldNm].ToString()) : null;
        }
        public static bool? GetNullableBool(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0 ? (bool?) Convert.ToBoolean(rdr[iFldNm].ToString()) : null;
        }

        public static byte? GetNullableByte(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0 ? (byte?) Convert.ToByte(rdr[fldNm].ToString()) : null;
        }

        public static byte? GetNullableByte(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0 ? (byte?) Convert.ToByte(rdr[iFldNm].ToString()) : null;
        }

        public static Nullable<T> GetNullableByteEnum<T>(SqlDataReader rdr, string fldNm) where T : struct
        {
            byte? b = GetNullableByte(rdr, fldNm);
            return (b.HasValue) ? (T)(object)b : default(T);
        }
        public static Nullable<T> GetNullableByteEnum<T>(SqlDataReader rdr, int iFldNm) where T : struct
        {
            byte? b = GetNullableByte(rdr,iFldNm);
            return (b.HasValue) ? (T)(object)b : default(T);
        }

        public static DateTime? GetNullableDateTime(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0
                ? (DateTime?)Convert.ToDateTime(rdr[fldNm].ToString())
                : null;
        }
        public static DateTime? GetNullableDateTime(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0
                ? (DateTime?)Convert.ToDateTime(rdr[iFldNm].ToString())
                : null;
        }

        public static decimal? GetNullableDecimal(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0 
                ? (decimal?)Convert.ToDecimal(rdr[fldNm].ToString()) 
                : null;
        }
        public static decimal? GetNullableDecimal(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0 
                ? (decimal?)Convert.ToDecimal(rdr[iFldNm].ToString()) 
                : null;
        }


        public static int? GetNullableInt(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0 ? (int?) Convert.ToInt32(rdr[fldNm].ToString()) : null;
        }
        public static int? GetNullableInt(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0 ? (int?) Convert.ToInt32(rdr[iFldNm].ToString()) : null;
        }

        public static long? GetNullableLong(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0 ? (long?) Convert.ToInt64(rdr[fldNm].ToString()) : null;
        }
        public static long? GetNullableLong(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0 ? (long?) Convert.ToInt64(rdr[iFldNm].ToString()) : null;
        }

        public static short? GetNullableShort(SqlDataReader rdr, string fldNm)
        {
            return rdr[fldNm].ToString().Length > 0 ? (short?) Convert.ToInt16(rdr[fldNm].ToString()) : null;
        }
        public static short? GetNullableShort(SqlDataReader rdr, int iFldNm)
        {
            return rdr[iFldNm].ToString().Length > 0 ? (short?) Convert.ToInt16(rdr[iFldNm].ToString()) : null;
        }
 
        #endregion

        #region Caching

        public static T GetCachedData<T>(string name)
        {
            HttpContext context = HttpContext.Current;
            return context.Cache[name] == null ? default(T) : (T) context.Cache[name];
        }

        public static List<T> GetCachedList<T>(string listNm)
        {
            HttpContext context = HttpContext.Current;
            return context.Cache[listNm] == null ? null : (List<T>) context.Cache[listNm];
        }

        public static T GetCachedListElement<T>(string listNm, Func<T, bool> predicate)
        {
            HttpContext context = HttpContext.Current;
            return context.Cache[listNm] != null
                ? ((List<T>) context.Cache[listNm]).Where(predicate).FirstOrDefault()
                : default(T);
        }

        public static List<T> GetSessionList<T>(string listNm)
        {
            HttpContext context = HttpContext.Current;
            return context.Session[listNm] == null ? null : (List<T>) context.Session[listNm];
        }

        public static void RemoveCachedListElement<T>(string listNm, Predicate<T> predicate)
        {
            // Note that linq is not used here - Predicate<T> is a parameter to RemoveAll which is a method of List<T> and not linq

            ((List<T>)HttpContext.Current.Cache[listNm]).RemoveAll(predicate);
        }

        public static void RemoveItemFromCache(string key)
        {
            HttpContext context = HttpContext.Current;
            if (context.Cache[key] != null) context.Cache.Remove(key);
        }

        public static void SaveDataToCache<T>(string name, T data)
        {
            HttpContext.Current.Cache[name] = data;
        }

        public static void SaveListToCache<T>(string name, List<T> l)
        {
            HttpContext.Current.Cache[name] = l;
        }

        public static void SaveListToSession<T>(string name, List<T> l)
        {
            if ((l != null) && (l.Count > 0))
                HttpContext.Current.Session[name] = l;
        }

        public static void SaveListElementToCachedList<T>(string name, T data)
        {
            HttpContext context = HttpContext.Current;
            List<T> l;
            if (context.Cache[name] == null)
                l = new List<T>();
            else
                l = (List<T>) context.Cache[name];
            l.Add(data);
            context.Cache[name] = l;
        }

        public static void SaveListElementToSessionList<T>(string name, T data)
        {
            HttpContext context = HttpContext.Current;
            List<T> l;
            if (context.Session[name] == null)
                l = new List<T>();
            else
                l = (List<T>) context.Session[name];
            l.Add(data);
            context.Session[name] = l;
        }

        public static void RemoveSessionItem(string key)
        {
            HttpContext context = HttpContext.Current;
            if (context.Session[key] != null) context.Session.Remove(key);
        }

        #endregion

        #region SqlDataRecord Extension Methods

        public static void SetNullableByte(this SqlDataRecord sdr, int index, byte? value)
        {
            if (value.HasValue)
                sdr.SetSqlByte(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetNullableDateTime(this SqlDataRecord sdr, int index, DateTime? value)
        {
            if (value.HasValue)
                sdr.SetSqlDateTime(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetNullableEnum<T>(this SqlDataRecord sdr, int index, T value)
        {
            if (value != null)
                sdr.SetSqlByte(index, Convert.ToByte(value));
            else
                sdr.SetDBNull(index);
        }
        public static void SetNullableInt16(this SqlDataRecord sdr, int index, short? value)
        {
            if (value.HasValue)
                sdr.SetSqlInt16(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetNullableInt32(this SqlDataRecord sdr, int index, int? value)
        {
            if (value.HasValue)
                sdr.SetSqlInt32(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetNullableMoney(this SqlDataRecord sdr, int index, decimal? value)
        {
            if (value.HasValue)
                sdr.SetSqlMoney(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetNullableString(this SqlDataRecord sdr, int index, string value)
        {
            if (value != null)
                sdr.SetString(index, value);
            else
                sdr.SetDBNull(index);
        }

        #endregion

        #region Stored procedure wrappers

        public static T GetData<T>(string storedProcNm, Func<SqlDataReader, T> mapObj) where T : class
        {
            return GetData<T>(storedProcNm, null, mapObj);
        }

        public static T GetData<T>(string storedProcNm,
           Action<SqlParameterCollection> setSqlParams, Func<SqlDataReader, T> mapObj) where T : class
        {
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = storedProcNm;
                    setSqlParams?.Invoke(cmd.Parameters); // Means if setSqlParams != null stops at . if null;
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    return rdr.HasRows ? mapObj(rdr) : null;
                }
            }
        }
        public static List<T> GetList<T>(string storedProcNm, Func<SqlDataReader, List<T>> mapObj) where T: class
        {
            return GetList<T>(storedProcNm, null, mapObj);
        }
        public static List<T> GetList<T>(string storedProcNm,
           Action<SqlParameterCollection> setSqlParams, Func<SqlDataReader, List<T>> mapObj) where T : class
        {
            using (SqlConnection conn = new SqlConnection(DBConnect.GetSchoolConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = storedProcNm;
                    setSqlParams?.Invoke(cmd.Parameters); // Means if setSqlParams != null stops at . if null;
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    return rdr.HasRows ? mapObj(rdr) : null;
                }
            }

        }

       /* public static StoredProcResult UpdData<T>(string storedProcNm, 
            Action<SqlParameterCollection, T> setSqlParams, T data) where T : class
        {
            return UpdData<T>(storedProcNm, "", setSqlParams, data);
        }

        public static StoredProcResult UpdData<T>(string storedProcNm,string keyParamNm, 
            Action<SqlParameterCollection,T> setSqlParams, T data) where T : class
        {
            StoredProcResult result = new StoredProcResult { ErrMsg = "" };
            using (SqlConnection conn = new SqlConnection(DbConnect.SchoolRegistrationConnStr()))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = storedProcNm;
                    setSqlParams(cmd.Parameters, data);
                    cmd.Parameters.Add("@ErrMsg", SqlDbType.NVarChar, 512).Direction = ParameterDirection.InputOutput;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    if ((keyParamNm.Length > 0) && (cmd.Parameters.Contains(keyParamNm)) &&
                        (cmd.Parameters[keyParamNm].Direction == ParameterDirection.InputOutput))
                        result.Key = cmd.Parameters[keyParamNm].Value.ToString();
                    if (!Convert.IsDBNull(cmd.Parameters["@ErrMsg"].Value))
                        result.ErrMsg = cmd.Parameters["@ErrMsg"].Value.ToString();
                    conn.Close();
                }
            }
            return result;
        }*/

        #endregion

        public static string GetCurrentKey()
        {
            // ?? Null coalesce left side returns non null value - ?. stops operation if null and then would return "" the right side
            return HttpContext.Current.Session["CurrentKey"]?.ToString() ?? "";
        }
        public static string GetSurveyId()
        {
            return HttpContext.Current.Session["SurveyId"]?.ToString() ?? "";
        }
        public static void SetCurrenKey(string key)
        {
            HttpContext.Current.Session["CurrentKey"] = key; 
        }
    }
}