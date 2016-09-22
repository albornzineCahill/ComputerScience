using CSMVC4SchoolProject.DataRepository;
using CSMVC4SchoolProject.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace CSMVC4SchoolProject.Controllers
{
    public class RoomController : Controller
    {
        //
        // GET: /Room/

        public ActionResult Index()
        {
            RoomsRepository rep = new RoomsRepository();
            return View(rep.GetRooms());
        }
        public ActionResult Edit()
        {
            RoomsRepository rep = new RoomsRepository();
            ViewBag.KeyField = Request["ID"];
            return View(rep.GetRooms());
        }
        [HttpPost]
        public ActionResult Edit(List<Room> l)
        {
            l[0].UpdateYN = true;
            RoomsRepository rep = new RoomsRepository();
            rep.UpdRooms(l);
            return View(rep.GetRooms());

        }
        public ActionResult Delete()
        {
            Room r = new Room();
            r.KeyField = Convert.ToInt16(Request["ID"]);
            r.description = "Deleted Item";
            r.DeleteYN = true;
            List<Room> l = new List<Room>();
            l.Add(r);
            RoomsRepository rep = new RoomsRepository();
            rep.UpdRooms(l);
            return RedirectToAction("Index", "Room");

        }
        public ActionResult Add()
        {
            RoomsRepository rep = new RoomsRepository();
            return View(rep.GetRooms());
        }
        [HttpPost]
        public ActionResult Add(List<Room> l)
        {
            Room r = new Room();
            r.KeyField = -1;
            r.description = Request["Desc"];
            r.MaxStudents = Convert.ToInt32(Request["MaxStudents"]);
            l = new List<Room>();
            l.Add(r);
            RoomsRepository rep = new RoomsRepository();
            rep.UpdRooms(l);
            return RedirectToAction("Index", "Room");

        }
    }
}
