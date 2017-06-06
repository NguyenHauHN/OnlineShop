using Models.DAO;
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
            var model = new ProductDAO().ListAll();
            return View(model);
        }
        
        [ChildActionOnly]
        public PartialViewResult ProductCategory()
        {
            var model = new ProductCategoryDAO().ListAll();
            return PartialView(model);
        }

        public ActionResult Category(long id, int page =1, int pageSize=2)
        {
            int totalProduct = 0;
            var model = new ProductDAO().ListProduct(id,ref totalProduct, page, pageSize);
            ViewBag.categoryDetail = new ProductCategoryDAO().ViewDetail(id);
            ViewBag.Slide = new SlideDAO().ListAll();
            ViewBag.Total = totalProduct;
            ViewBag.Page = page;
            int maxPage = 5;
            int totalPage = 0;
            totalPage = (int)Math.Ceiling((double)(totalProduct / pageSize));
            ViewBag.TotalPage = totalPage;
            ViewBag.MaxPage = maxPage;
            ViewBag.First = 1;
            ViewBag.Last = maxPage;
            ViewBag.Next = page + 1;
            ViewBag.Prev = page - 1;
            return View(model);
        }

        public ActionResult Detail(long id)
        {
            var product = new ProductDAO().ViewDetail(id);
            ViewBag.category = new ProductCategoryDAO().ViewDetail(product.CategoryID.Value);
            ViewBag.relateProduct = new ProductDAO().ListRelateProduct(id);
            ViewBag.listCategory = new ProductCategoryDAO().ListAll();
            return View(product);
        }
    }
}