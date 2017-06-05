using Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class ContactController : Controller
    {
        // GET: Contact
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult SendContact (string Name, string Email, string Content)
        {
            try
            {
                string content = System.IO.File.ReadAllText(Server.MapPath("/Views/Shared/EmailContact.cshtml"));

                content = content.Replace("{{CustomerName}}", Name);
                content = content.Replace("{{CustomerEmail}}", Email);
                content = content.Replace("{{ContactContent}}", Content);
                var toEmailAddress = ConfigurationManager.AppSettings["FromEmailAddress"].ToString();
                new MailHelper().SendMail(toEmailAddress, "Email từ khách hàng", content);
                return Json(new
                {
                    status = true
                });
            }
            catch(Exception e)
            {
                return Json(new
                {
                    status = false
                });
            }
            
            
        }
    }
}