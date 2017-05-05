using Model.DAO;
using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class CategoryController : BaseController
    {
        // GET: Admin/Category
        public ActionResult Index(string keyword, int page = 1, int pageSize = 10)
        {
            int totalCategory = 0;
            var listCategory = new CategoryDAO().ListAll(keyword, ref totalCategory, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listCategory);
        }

        [HttpDelete]
        public ActionResult Delete(int ID)
        {
            var result = new CategoryDAO().Delete(ID);
            return RedirectToAction("Index", "Category");
        }

        [HttpGet]
        public ActionResult Create()
        {
            var listCategory = new CategoryDAO().GetListAll();
            ViewBag.ListCategory = listCategory;
            return View();
        }
        [HttpPost]
        public ActionResult Create(Category category)
        {
            if (ModelState.IsValid)
            {
                var result = new CategoryDAO().Insert(category);
                if(result > 0)
                {
                    return RedirectToAction("Index", "Category");

                }

                else
                {
                    ModelState.AddModelError("", "Thêm mới không thành công!");
                }
            }
            return View("Index");
        }

        [HttpGet]
        public ActionResult Edit(long ID)
        {
            var category = new CategoryDAO().GetByID(ID);
            var listCategory = new CategoryDAO().GetListAll();
            ViewBag.ListCategory = listCategory;
            return View(category);
        }

        [HttpPost]
        public ActionResult Edit(Category category)
        {
            if (ModelState.IsValid)
            {
                var result = new CategoryDAO().Update(category);
                if(result > 0)
                {
                    return RedirectToAction("Index", "Category");
                }

                else
                {
                    ModelState.AddModelError("", "Cập nhật không thành công!");
                }
            }
            return View("Index");
        }

    }
}