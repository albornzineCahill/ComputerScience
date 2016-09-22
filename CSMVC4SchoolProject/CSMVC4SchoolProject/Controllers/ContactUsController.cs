using CSMVC4SchoolProject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace CSMVC4SchoolProject.Controllers
{
    public class ContactUsController : Controller
    {
        //
        // GET: /ContactUs/

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(ContactUs c)
        {
            if (ModelState.IsValid)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("Name: " + c.Name + "\r\n");
                sb.Append("Phone: " + c.Phone + "\r\n");
                sb.Append("Email: " + c.EMail + "\r\n\r\n");

                if ((c.Comments == null) || (c.Comments.Length == 0))
                {
                    sb.Append("There were no comments in this email.");
                }
                else
                {
                    sb.Append("Comments/Questions:\r\n\r\n");
                    sb.Append(c.Comments);
                }
                string body = sb.ToString();

                MailMessage msg = new MailMessage("support@ctsoftwaresystems.com", "legojonah39@gmail.com",
                    "Contact information from Student Registration", body);

                SmtpClient smtp = new SmtpClient("mail.ctsoftwaresystems.com", 587);
                System.Net.NetworkCredential eMailPW = new System.Net.NetworkCredential("cmcmahel@ctsoftwaresystems.com", "mSHt6Pq");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = eMailPW;

                smtp.Send(msg);

                return View("EmailSuccess");
            }
            else return View();
        }

    }
}
