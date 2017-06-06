using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace DemoLyThuyet
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            Application["OnlineCounter"] = 0;
           
        }
        protected void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
            if (Application["OnlineCounter"] != null)
            {
                Application.Lock();
                Application["OnlineCounter"] =
                ((int)Application["OnlineCounter"]) + 1;
                Application.UnLock();
            }
        }
        protected void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
            if (Application["OnlineCounter"] != null)
            {
                Application.Lock();
                Application["OnlineCounter"] =
            ((int)Application["OnlineCounter"]) - 1;
                Application.UnLock();
            }
        }
    }
}
