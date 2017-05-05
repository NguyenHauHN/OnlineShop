using Model.DAO;
using OnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            var listNewProduct = new ProductDisplayDAO().ListNewProduct();
            ViewBag.ListNew = listNewProduct;
            return View();
        }

        [ChildActionOnly]
        public ActionResult Header()
        {
            var listItem = new List<CardItem>();
            if (Session[Common.CommonConstant.CardSession] != null)
            {
                listItem = (List<CardItem>)Session[Common.CommonConstant.CardSession];
            }
            return PartialView(listItem);
        }

        
    }
}