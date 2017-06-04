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
    }
}