using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace CSMVC4SchoolProject.Models
{
    public class Login
    {
        [Required(ErrorMessage = "Username Required")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Password Required")]
        public string Password { get; set; }
        public string ErrorMessage { get; set; }

        public Login()
        {
            ErrorMessage = "";
        }

    }
}