using Models.DAO;
using Models.EF;
using OnlineShop.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class UserController : BaseController
    {
        // GET: Admin/User
        public ActionResult Index(string searchString, int page = 1, int pageSize = 1)
        {
            var userDAO = new UserDAO();
            var model = userDAO.ListAll(searchString, page, pageSize);
            ViewBag.SearchString = searchString;
            return View(model);
        }
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(User user)
        {
            if (ModelState.IsValid)
            {
                var userDAO = new UserDAO();
                user.Password = Encrypt.MD5Hash(user.Password);
                var id = userDAO.Insert(user);
                if (id > 0)
                {
                    return RedirectToAction("Index", "User");
                }
                else
                {
                    ModelState.AddModelError("", "Thêm mới không thành công!");
                }
            }
            return View("Index");

        }

        [HttpPost]
        public ActionResult Edit(User user)
        {
            if (ModelState.IsValid)
            {
                var result = false;
                var userDAO = new UserDAO();
                if (!string.IsNullOrEmpty(user.Password))
                {
                    user.Password = Encrypt.MD5Hash(user.Password);
                    result = userDAO.Update(user);
                }
               
                if (result)
                {


                    return RedirectToAction("Index", "User");
                }
                else
                {
                    ModelState.AddModelError("", "Cập nhật không thành công!");
                }
            }
            return View("Edit");

        }

        //[HttpPut]
        public ActionResult Edit(int id)
        {
            var userDAO = new UserDAO();
            var user = userDAO.ViewDetail(id);
            return View(user);
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            new UserDAO().Delete(id);
            return RedirectToAction("Index");
        }
    }
}