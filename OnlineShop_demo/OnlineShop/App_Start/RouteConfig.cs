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
               name: "Products",
               url: "san-pham",
               defaults: new { controller = "Product", action = "Index", id = UrlParameter.Optional },
               namespaces: new[] { "OnlineShop.Controllers" }
           );
            routes.MapRoute(
               name: "Product Category",
               url: "san-pham/{metatitle}-{id}",
               defaults: new { controller = "Product", action = "Category", id = UrlParameter.Optional },
               namespaces: new[] { "OnlineShop.Controllers" }
           );


            routes.MapRoute(
              name: "Product Detail",
              url: "chi-tiet/{metatitle}-{id}",
              defaults: new { controller = "Product", action = "Detail", id = UrlParameter.Optional },
              namespaces: new[] { "OnlineShop.Controllers" }
          );

            routes.MapRoute(
                 name: "Introduce",
                 url: "gioi-thieu",
                 defaults: new { controller = "About", action = "Index", id = UrlParameter.Optional },
                 namespaces: new[] { "OnlineShop.Controllers" }
             );

            routes.MapRoute(
               name: "News",
               url: "tin-tuc",
               defaults: new { controller = "News", action = "Index", id = UrlParameter.Optional },
               namespaces: new[] { "OnlineShop.Controllers" }
           );

            routes.MapRoute(
               name: "Contact",
               url: "lien-he",
               defaults: new { controller = "Contact", action = "Index", id = UrlParameter.Optional },
               namespaces: new[] { "OnlineShop.Controllers" }
           );

            routes.MapRoute(
             name: "Card",
             url: "gio-hang",
             defaults: new { controller = "Card", action = "Index", id = UrlParameter.Optional },
             namespaces: new[] { "OnlineShop.Controllers" }
         );
            routes.MapRoute(
         name: "Payment",
         url: "thanh-toan",
         defaults: new { controller = "Card", action = "Payment", id = UrlParameter.Optional },
         namespaces: new[] { "OnlineShop.Controllers" }
     );

            routes.MapRoute(
              name: "Add To Card",
              url: "them-vao-gio",
              defaults: new { controller = "Card", action = "AddToCard", id = UrlParameter.Optional },
              namespaces: new[] { "OnlineShop.Controllers" }
          );


            routes.MapRoute(
              name: "Payment Success",
              url: "hoan-thanh",
              defaults: new { controller = "Card", action = "PaymentSuccess", id = UrlParameter.Optional },
              namespaces: new[] { "OnlineShop.Controllers" }
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
