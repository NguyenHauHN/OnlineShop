using OnlineShop.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class HomeController : BaseController
    {
        // GET: Admin/Home
        public ActionResult Index()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult Header()
        {
            var adminInfo = Session[CommonConstant.USER_SESSION];
            return PartialView(adminInfo);
        }

        [ChildActionOnly]
        public ActionResult Navigation()
        {
            var adminInfo = Session[CommonConstant.USER_SESSION];
            return PartialView(adminInfo);
        }

        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return RedirectToAction("Index", "Login");
        }
    }
}