using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoLyThuyet.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            int OnlineUsers = 0;
            if (this.HttpContext.Application["OnlineCounter"] != null)
            {
                OnlineUsers = ((int)this.HttpContext.Application["OnlineCounter"]);
            }
            ViewBag.NumberOnlineUser = OnlineUsers;
            return View();
        }

        //[HttpPost]
        public ActionResult DemoApplication(string YourName)
        {
            string param1 = this.Request.QueryString["YourName"];
            ViewBag.Param1 = param1;
            return View();
        }

        [HttpPost]
        public ActionResult Test(string YourName)
        {
            string name = Request.Form["name"];
            string password = Request.Form["password"];
            if (name == "homer" && password == "donuts")
                ViewBag.Message = "Succeeded";
            else
                ViewBag.Message = "Failed";
            Response.Write("Response Demo by BCDONLINE.NET");
            return View("Index");
        }

        public void TestResponse()
        {
            ViewBag.Text = "Test response";
            Response.Redirect("/Home/DemoApplication");
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}