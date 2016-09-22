using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CSMVC4SchoolProject.Models
{
    public class Addresses
    {
        public short Keyfield { get; set; }
        public string Adr1 { get; set; }
        public string Adr2 { get; set; }
        public string City { get; set; }
        public string St { get; set; }
        public string ZIP { get; set; }
    }
}