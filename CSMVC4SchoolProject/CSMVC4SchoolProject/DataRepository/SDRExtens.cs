using Microsoft.SqlServer.Server;

namespace CSMVC4SchoolProject.DataRepository
{
    public static class SDRExtens
    {
        public static void SetSqlNullableInt16(this SqlDataRecord sdr, int index, short? value)
        {
            if (value.HasValue)
                sdr.SetSqlInt16(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetSqlNullableInt32(this SqlDataRecord sdr, int index, int? value)
        {
            if (value.HasValue)
                sdr.SetSqlInt32(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
        public static void SetSqlNullableMoney(this SqlDataRecord sdr, int index, decimal? value)
        {
            if (value.HasValue)
                sdr.SetSqlMoney(index, value.GetValueOrDefault());
            else
                sdr.SetDBNull(index);
        }
    }
}