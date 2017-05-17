using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;
using System.Web.Services;
using PagedList;
using System.IO;
using OnlineShop.Common;
using System.Text.RegularExpressions;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class AdminManageController : BaseController
    {

        // GET: Admin/AdminManage
        public ActionResult Index(string keyword, int page = 1, int pageSize = 10)
        {
            int totalAdmin = 0;
            var listAdmin = new UserDAO().ListAllAdmin(keyword, ref totalAdmin, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listAdmin);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(User admin, string singleImage)
        {

            if (ModelState.IsValid)
            {
                admin.Avatar = singleImage;
                if (!string.IsNullOrEmpty(admin.Password))
                {
                    admin.Password = Encrypt.MD5Hash(admin.Password);
                }
                var result = new UserDAO().Insert(admin);
                if (result == 1)
                {
                    return RedirectToAction("Index", "AdminManage");
                }
                else if (result == -1)
                {
                    TempData["CreateError"] = "Tên đăng nhập đã được sử dụng, thêm mới không thành công!";
                }
            }
            return RedirectToAction("Create", "AdminManage");
        }

        [HttpGet]
        public ActionResult Edit(int ID)
        {
            var admin = new UserDAO().GetByID(ID);
            return View(admin);
        }

        [HttpPost]
        public ActionResult Edit(User admin, string singleImage, string srcAvatar)
        {
            if (ModelState.IsValid)
            {
                if (!string.IsNullOrEmpty(singleImage))
                {
                    admin.Avatar = singleImage;
                }
                else if (!string.IsNullOrEmpty(srcAvatar))
                {
                    admin.Avatar = srcAvatar;
                }
                Regex rgx = new Regex(@"^[0-9a-f]{32}$");
                if (!rgx.IsMatch(admin.Password))
                {
                    admin.Password = Encrypt.MD5Hash(admin.Password);
                }
                var result = new UserDAO().Update(admin);
                if (result == 1)
                {
                    return RedirectToAction("Index", "AdminManage");

                }
                else
                {
                    TempData["EditError"] = "Đã xảy ra lỗi, Cập nhật không thành công!";
                }
            }
            return RedirectToAction("Edit", "AdminManage");
        }

        [HttpDelete]
        public ActionResult Delete(int ID)
        {
            var result = new UserDAO().Delete(ID);
            return View();
        }

        [HttpPost]
        public ActionResult UploadSingleImage()
        {
            try
            {
                var path = "";
                if (System.Web.HttpContext.Current.Request.Files.AllKeys.Any())
                {
                    var pic = System.Web.HttpContext.Current.Request.Files["HelpSectionImages"];
                    HttpPostedFileBase filebase = new HttpPostedFileWrapper(pic);
                    var fileName = Path.GetFileName(filebase.FileName);
                    path = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    filebase.SaveAs(path);
                    return Json(new { name = "/Images/" + fileName });
                }
                else { return Json(new { name = "~/Images/plus.png" }); }
            }
            catch (Exception ex)
            {
                return Json("Error While Saving.");
            }
        }
    }
}