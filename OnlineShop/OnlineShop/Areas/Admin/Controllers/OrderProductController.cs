using Model.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.EF;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class OrderProductController : BaseController
    {
        // GET: Admin/OrderProduct
        public ActionResult Index(string keyword, int page = 1, int pageSize = 5)
        {
            int totalOrder = 0;
            var listOrder = new OrderProductViewModelDAO().ListAllOrderProduct(keyword, ref totalOrder, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listOrder);
        }

        [HttpGet]
        public ActionResult Create()
        {
            var listUser = new UserDAO().ListAllUserOrder();
            var listProduct = new ProductDAO().ListAll();
            ViewBag.ListUser = listUser;
            ViewBag.ListProduct = listProduct;
            return View();
        }
    }
}