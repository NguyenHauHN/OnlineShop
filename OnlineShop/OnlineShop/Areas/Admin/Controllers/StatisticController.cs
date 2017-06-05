using Model.DAO;
using OnlineShop.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class StatisticController : BaseController
    {
        // GET: Admin/Statistic
        [HasCredential(RoleID = "STATISTIC_MANAGE")]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult StatisticOrder(string startDate, string endDate)
        {
            try
            {
                var listData = new StatisticDAO().StatisticOrder(startDate, endDate);
                return Json(new
                {
                    result = listData,
                    status = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new
                {
                    status = false
                }, JsonRequestBehavior.AllowGet);
            }
           
        }
    }
}