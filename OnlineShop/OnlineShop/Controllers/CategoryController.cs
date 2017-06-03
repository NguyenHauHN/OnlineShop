using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.EF;

namespace OnlineShop.Controllers
{
    public class CategoryController : Controller
    {
        // GET: Category
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ListProduct(long id, int page = 1, int pageSize = 9, string valueSelectSort = null,
            string searchProduct = null, double minPrice = 0, double maxPrice = 0)
        {
            int totalProduct = 0;
            IEnumerable<Product> listProduct = new ProductDAO().GetByCategoryID(id, ref totalProduct, page, pageSize, valueSelectSort, 
                searchProduct, minPrice, maxPrice);
            ViewBag.Page = page;
            ViewBag.TotalProduct = totalProduct;
            var category = new CategoryDAO().GetByID(id);
            ViewBag.CategoryInfo = category;
            // category product for men
            var listCategoryMen = new CategoryDAO().ListCategoryMen();
            ViewBag.ListcategoryMen = listCategoryMen;
            // category product for women
            var listCategoryWomen = new CategoryDAO().ListCategoryWomen();
            ViewBag.ListcategoryWomen = listCategoryWomen;
            // category product for kid
            var listCategoryKid = new CategoryDAO().ListCategoryKid();
            ViewBag.ListcategoryKid = listCategoryKid;
            //list top rate product
            var listProductTopRate = new ProductDAO().ListProductTopRate(5);
            ViewBag.ListProductTopRate = listProductTopRate;
            return View(listProduct);
        }

        public JsonResult GetResultSearch(string keyword)
        {

            return Json(new
            {
                status=false
            });
        }
    }
}