using Models.DAO;
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
        public int CardSession { get; private set; }

        // GET: Home
        public ActionResult Index()
        {
            ViewBag.Slide = new SlideDAO().ListAll();
            var productDAO = new ProductDAO();
            ViewBag.newProducts = productDAO.ListNewProduct(4);
            ViewBag.featureProducts = productDAO.ListFeatureProduct(4);
            return View();
        }

        [ChildActionOnly]
        public ActionResult MainMenu()
        {
            var model = new MenuDAO().ListByGroupID(1);
            return PartialView(model);
        }

        [ChildActionOnly]
        public ActionResult TopMenu()
        {
            var model = new MenuDAO().ListByGroupID(2);
            return PartialView(model);
        }
        [ChildActionOnly]
        public ActionResult HeaderCard()
        {
            var listItem = new List<CardItem>();
            if (Session[Common.CommonConstant.CardSession] != null)
            {
                listItem = (List<CardItem>)Session[Common.CommonConstant.CardSession];
            }
            return PartialView(listItem);
        }

        [ChildActionOnly]
        public ActionResult Footer()
        {
            var model = new FooterDAO().GetFooter();
            return PartialView(model);
        }
    }
}