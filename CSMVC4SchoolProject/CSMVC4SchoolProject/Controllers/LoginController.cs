using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CSMVC4SchoolProject.Models;
using CSMVC4SchoolProject.DataRepository;

namespace CSMVC4SchoolProject.Controllers
{
    public class LoginController : Controller
    {
        //
        // GET: /Login/

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(Login l)
        {
            if (ModelState.IsValid)
            {
                LoginRepository repository = new LoginRepository();
                ViewBag.ErrorMessage = repository.ValidLogin(l.Username, repository.GetSHA2_512Hash(l.Password));
                if (ViewBag.ErrorMessage.Length == 0)
                {
                    Session["loginGreeting"] = "Welcome " + l.Username;
                    //      TempData["loginID"]= "Welcome " + l.Username;
                    
                }
                
            }
            return View();
        }
    }
}
