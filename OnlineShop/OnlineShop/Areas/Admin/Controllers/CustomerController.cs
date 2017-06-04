using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.DAO;
using Model.EF;
using OnlineShop.Common;
using System.Text.RegularExpressions;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class CustomerController : BaseController
    {
        // GET: Admin/User
        [HasCredential(RoleID = "CUSTOMER_MANAGE")]
        public ActionResult Index(string keyword, int page = 1, int pageSize = 5)
        {
            int totalCustomer = 0;
            var listCustomer = new UserDAO().ListAllCustomer(keyword, ref totalCustomer, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listCustomer);
        }

        [HasCredential(RoleID = "CUSTOMER_MANAGE")]
        public ActionResult Create()
        {
            return View();
        }

        [HasCredential(RoleID = "CUSTOMER_MANAGE")]
        [HttpPost]
        public ActionResult Create(User customer)
        {
            if (ModelState.IsValid)
            {
                customer.Type = 0;
                if (!string.IsNullOrEmpty(customer.Password))
                {
                    customer.Password = Encrypt.MD5Hash(customer.Password);
                }
                var result = new UserDAO().Insert(customer);
                if (result == 1)
                {
                    return RedirectToAction("Index", "Customer");
                }
                else if (result == -1)
                {
                    TempData["CreateError"] = "Tên đăng nhập đã được sử dụng, thêm mới không thành công!";
                }
            }
            return RedirectToAction("Create", "Customer");
        }

        [HasCredential(RoleID = "CUSTOMER_MANAGE")]
        public ActionResult Edit(int ID)
        {
            var customer = new UserDAO().GetByID(ID);
            return View(customer);
        }

        [HttpPost]
        [HasCredential(RoleID = "CUSTOMER_MANAGE")]
        public ActionResult Edit(User customer)
        {
            if (ModelState.IsValid)
            {
               
                Regex rgx = new Regex(@"^[0-9a-f]{32}$");
                if (!rgx.IsMatch(customer.Password))
                {
                    customer.Password = Encrypt.MD5Hash(customer.Password);
                }
                var result = new UserDAO().Update(customer);
                if (result == 1)
                {
                    return RedirectToAction("Index", "Customer");

                }
                else
                {
                    TempData["EditError"] = "Đã xảy ra lỗi, Cập nhật không thành công!";
                }
            }
            return RedirectToAction("Edit", "Customer");
        }

        [HasCredential(RoleID = "CUSTOMER_MANAGE")]
        public ActionResult Delete(int ID)
        {
            var result = new UserDAO().Delete(ID);
            return View();
        }
    }
}