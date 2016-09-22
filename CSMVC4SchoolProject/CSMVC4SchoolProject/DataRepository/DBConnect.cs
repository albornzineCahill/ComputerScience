using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace CSMVC4SchoolProject.DataRepository
{
    public static class DBConnect
    {   
        public static string GetSchoolConnStr()
        {
            return ConfigurationManager.ConnectionStrings["SchoolRegistrationConnStr"].ConnectionString;
        }
    }
}