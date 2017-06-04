using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.DAO;
using Model.EF;
using Model.ViewModels;
using OnlineShop.Common;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class OrderController : BaseController
    {
        // GET: Admin/Order
        [HasCredential(RoleID = "ORDER_MANAGE")]
        public ActionResult Index(string keyword, int page = 1, int pageSize = 5)
        {
            int totalOrder = 0;
            var listOrder = new OrderDAO().ListAllOrder(keyword, ref totalOrder, page, pageSize);
            ViewBag.ListStatusOrder = new OrderDAO().GetAllStatus();
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listOrder);
        }

        [HasCredential(RoleID = "ORDER_MANAGE")]
        public ActionResult Create()
        {
            //var listProduct
            return View();
        }

        [HasCredential(RoleID = "ORDER_MANAGE")]
        public ActionResult Edit(long ID)
        {
            var order = new OrderDAO().GetByID(ID);
            //list product
            var listProduct = new OrderDAO().GetProductOrder(ID);
            // list status
            ViewBag.ListStatusOrder = new OrderDAO().GetAllStatus();
            return View(order);
        }

        [HttpPost]
        [HasCredential(RoleID = "ORDER_MANAGE")]
        public ActionResult Edit(Order order)
        {
            if (ModelState.IsValid)
            {
                var result = new OrderDAO().Update(order);
                if (result > 0)
                {
                    return RedirectToAction("Index", "Order");
                }
                else
                {
                    TempData["EditError"] = "Cập nhật trạng thái đơn hàng không thành công!";
                    return RedirectToAction("Edit", "Order");
                }
            }
            
            return View();
        }

        [HasCredential(RoleID = "ORDER_MANAGE")]
        public ActionResult ListProduct(long ID, string keyword, int page = 1, int pageSize = 5)
        {
            int totalOrderProduct = 0;
            var listOrderProduct = new OrderDAO().ListOrderProduct(ID, keyword, ref totalOrderProduct, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            ViewBag.OrderID = ID;
            return View(listOrderProduct);
        }

        [HttpDelete]
        [HasCredential(RoleID = "ORDER_MANAGE")]
        public ActionResult Delete(long ID)
        {
            var result = new OrderDAO().Delete(ID);
            return View();
        }
    }
}