using System.ComponentModel.DataAnnotations;

namespace CSMVC4SchoolProject.Models
{
    public class ContactUs
    {
        [Required(ErrorMessage ="Name Required")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Phone Required")] 
        public string Phone { get; set; }
        [Required(ErrorMessage = "EMail Required")]
        [RegularExpression("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$",
            ErrorMessage="Invalid Email Address")]
        public string EMail { get; set; }
        public string Comments { get; set; }
    }
}