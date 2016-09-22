using CSMVC4SchoolProject.DataRepository;
using CSMVC4SchoolProject.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace CSMVC4SchoolProject.Controllers
{
    public class EnrollmentTypesController : Controller
    {
        //
        // GET: /EnrollmentTypes/

        public ActionResult Index()
        {
            EnrollmentTypesRepository rep = new EnrollmentTypesRepository();
            return View(rep.GetEnrollmentTypes());
        }
        public ActionResult Edit()
        {
            EnrollmentTypesRepository rep = new EnrollmentTypesRepository();
            ViewBag.KeyField = Request["ID"];
            return View(rep.GetEnrollmentTypes());
        }
        [HttpPost]
        public ActionResult Edit(List<EnrollmentType> l)
        {
            l[0].UpdateYN = true;
            EnrollmentTypesRepository rep = new EnrollmentTypesRepository();
            rep.UpdEnrollmentTypes(l);
            return View(rep.GetEnrollmentTypes());

        }
        public ActionResult Delete()
        {
            EnrollmentType et = new EnrollmentType();
            et.KeyField = Convert.ToInt16(Request["ID"]);
            et.Description = "Deleted Item";
            et.DeleteYN = true;
            List<EnrollmentType> l = new List<EnrollmentType>();
            l.Add(et);
            EnrollmentTypesRepository rep = new EnrollmentTypesRepository();
            rep.UpdEnrollmentTypes(l);
            return RedirectToAction("Index", "EnrollmentTypes");

        }
        public ActionResult Add()
        {
            EnrollmentTypesRepository rep = new EnrollmentTypesRepository();
            return View(rep.GetEnrollmentTypes());
        }
        [HttpPost]
        public ActionResult Add(List<EnrollmentType> l)
        {
            EnrollmentType et = new EnrollmentType();
            et.KeyField = -1;
            et.Description = Request["desc"];
            et.DisplayOrder = Convert.ToInt16(Request["order"]);
            l = new List<EnrollmentType>();
            l.Add(et);
            EnrollmentTypesRepository rep = new EnrollmentTypesRepository();
            rep.UpdEnrollmentTypes(l);
            return RedirectToAction("Index", "EnrollmentTypes");

        }

    }
}
