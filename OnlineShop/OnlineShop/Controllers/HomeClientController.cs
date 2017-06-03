using Model.DAO;
using OnlineShop.Common;
using OnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace OnlineShop.Controllers
{
    public class HomeClientController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            //list product for men
            var listProductMen = new ProductDAO().ListAllProductMen();
            ViewBag.ListProductMen = listProductMen;
            //list product for women
            var listProductWomen = new ProductDAO().ListAllProductWomen();
            ViewBag.ListProductWomen = listProductWomen;
            //list product for kid
            var listProductKid = new ProductDAO().ListAllProductKid();
            ViewBag.ListProductKid = listProductKid;
            // list saling product 
            var listProductSale = new ProductDAO().ListAllSaleProduct();
            ViewBag.ListProductSale = listProductSale;
            // list new product
            var listProductNew = new ProductDAO().ListProductNew();
            ViewBag.ListProductNew = listProductNew;
            // list feature product
            var listProductFeature = new ProductDAO().ListProductFeature();
            ViewBag.ListProductFeature = listProductFeature;
            //list top rate product
            var listProductTopRate = new ProductDAO().ListProductTopRate(2);
            ViewBag.ListProductTopRate = listProductTopRate;
            return View();
        }

        public JsonResult GetProductCart()
        {
            var listItemCart = Session[CommonConstant.CardSession];
            return Json(
                   new
                   {
                       listItem = listItemCart

                   }, JsonRequestBehavior.AllowGet);
        }

        //[ChildActionOnly]
        public ActionResult Header()
        {
            var listItem = new List<CartItem>();
            double totalMoney = 0;
            if (Session[Common.CommonConstant.CardSession] != null)
            {
                listItem = (List<CartItem>)Session[Common.CommonConstant.CardSession];
            }
            foreach (var item in listItem)
            {
                totalMoney += (double)(item.Product.Price * (100 - item.Product.Sale) / 100);
            }
            if(Session[Common.CommonConstant.CLIENT_SESSION] != null)
            {
                var client = Session[Common.CommonConstant.CLIENT_SESSION] as ClientModel;
                ViewBag.Username = client.username;

            }
            ViewBag.TotalMoney = totalMoney;
            return PartialView(listItem);
        }

        [ChildActionOnly]
        public ActionResult Menu()
        {
            // category product for men
            var listCategoryMen = new CategoryDAO().ListCategoryMen();
            ViewBag.ListcategoryMen = listCategoryMen;
            // category product for women
            var listCategoryWomen = new CategoryDAO().ListCategoryWomen();
            ViewBag.ListcategoryWomen = listCategoryWomen;
            // category product for kid
            var listCategoryKid = new CategoryDAO().ListCategoryKid();
            ViewBag.ListcategoryKid = listCategoryKid;
            return PartialView();
        }

        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return Redirect(Request.UrlReferrer.ToString());
        }


    }
}