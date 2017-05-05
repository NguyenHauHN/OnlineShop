using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult ViewDetail(int ID)
        {
            var product = new ProductDisplayDAO().GetByProductID(ID);
            var listRelateProduct = new ProductDisplayDAO().GetListRelateProduct(product.Product.CategoryID);
            ViewBag.ListRelate = listRelateProduct;
            return View(product);
        }
    }
}