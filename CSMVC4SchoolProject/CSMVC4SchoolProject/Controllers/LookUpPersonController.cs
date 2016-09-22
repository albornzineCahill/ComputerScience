using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CSMVC4SchoolProject.Models;
using CSMVC4SchoolProject.DataRepository;


namespace CSMVC4SchoolProject.Controllers
{
    public class LookUpPersonController : Controller
    {
        //
        // GET: /LookUpPerson/

        public ActionResult Index()
        {
            PeopleRepository pr = new PeopleRepository();
            List<LookUp> l = pr.getPeople(null);
            ViewBag.PeopleLookUp = l;
            People p = new People();
            return View(p);
        }

        public JsonResult getPersonGeneralCon(short PersonFK)
        {
            PeopleRepository pr = new PeopleRepository();
            return Json(pr.getPersonGeneral(PersonFK), JsonRequestBehavior.AllowGet);
          // return Json(new People() { FirstName= "Joe", LastName= "Brown"}, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getPersonChurch(short PersonFK)
        {
            PeopleRepository pr = new PeopleRepository();
            return Json(pr.getPersonChurch(PersonFK), JsonRequestBehavior.AllowGet);
        }

        public JsonResult getPersonHealth(short PersonFK)
        {
            PeopleRepository pr = new PeopleRepository();
            return Json(pr.getPersonHealth(PersonFK), JsonRequestBehavior.AllowGet);
        }
    }
}
