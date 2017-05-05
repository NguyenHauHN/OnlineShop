using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace OnlineShop
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
            name: "Add To Cart",
            url: "them-vao-gio",
            defaults: new { controller = "Cart", action = "AddToCart", id = UrlParameter.Optional },
            namespaces: new[] { "OnlineShop.Controllers" }
        );
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
            name: "Cart",
            url: "gio-hang",
            defaults: new { controller = "Cart", action = "Index", id = UrlParameter.Optional },
            namespaces: new[] { "OnlineShop.Controllers" }
        );
            routes.MapRoute(
               name: "Admin",
               url: "Admin/{controller}/{action}/{id}",
               defaults: new { controller = "AdminManage", action = "Index", id = UrlParameter.Optional }
           );
          
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
               namespaces: new[] { "OnlineShop.Controllers" }
            );
        }
    }
}
