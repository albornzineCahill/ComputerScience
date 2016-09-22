using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CSMVC4SchoolProject.Models
{
    public class StudentClasses
    {
        public int keyfield { get; set; }
        public short ClassFK { get; set; }
        public Decimal Grade {get; set;}
        public DateTime Year { get; set; }
    }
}