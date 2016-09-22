using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CSMVC4SchoolProject.Models
{
    public class Insurances
    {
        public short keyfield { get; set; }
        public string InsuranceCo { get; set; }
        public string PolicyNum { get; set; }
        public string SubscriberName { get; set; }
        public string SubscriberNum { get; set; }
        public string SubscriberEmployer { get; set; }
        public string SubscriberJob { get; set; }
        public string SubscriberWorkPhone { get; set; }
    }
}