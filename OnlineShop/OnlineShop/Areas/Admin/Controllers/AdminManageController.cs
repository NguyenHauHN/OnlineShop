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
            if (TempData["pathImage"] != null)
            {
                Session["avatarUpload"] = TempData["pathImage"];
                ViewBag.srcImg = TempData["pathImage"];
            }
            else
            {
                ViewBag.srcImg = "~/Images/plus.png";
            }
            
            return View();
        }

        [HttpPost]
        public ActionResult Create(User admin)
        {

            if (ModelState.IsValid)
            {
                admin.Avatar = Session["avatarUpload"].ToString();
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
                    ModelState.AddModelError("", "Tên đăng nhập đã được sử dụng, thêm mới không thành công!");
                }
            }
            return View("Index");
        }

        [HttpGet]
        public ActionResult Edit(int ID)
        {
            var admin = new UserDAO().GetByID(ID);
            if (TempData["pathImageEdit"] != null)
            {
                Session["avatarUploadEdit"] = TempData["pathImageEdit"];
                ViewBag.srcImgEdit = TempData["pathImageEdit"];
            }
            else if(!string.IsNullOrEmpty(admin.Avatar))
            {
                
                ViewBag.srcImgEdit = admin.Avatar;
                Session["avatarUploadEdit"] = admin.Avatar;
            }
            else
            {
                ViewBag.srcImgEdit = "~/Images/plus.png";
            }

            return View(admin);
        }

        [HttpPost]
        public ActionResult Edit(User admin)
        {
            if (ModelState.IsValid)
            {
                if(Session["avatarUploadEdit"] != null)
                {
                    admin.Avatar = Session["avatarUploadEdit"].ToString();
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
                    ModelState.AddModelError("", "Đã xảy ra lỗi, Cập nhật không thành công!");
                 }
            }
            return View("Index");
        }

        [HttpDelete]
        public ActionResult Delete(int ID)
        {
            var result = new UserDAO().Delete(ID);
            return View();
        }


        [HttpPost]
        public ActionResult UploadImageCreate(HttpPostedFileBase file)
        {
            var path = "";
            if(file != null && file.ContentLength > 0)
            {
                // check extension of file
                if(Path.GetExtension(file.FileName).ToLower() == ".jpg" || Path.GetExtension(file.FileName).ToLower() == ".png"
                   || Path.GetExtension(file.FileName).ToLower() == ".gif" || Path.GetExtension(file.FileName).ToLower() == ".jpeg" ||
                   Path.GetExtension(file.FileName).ToLower() == ".svg")
                {
                    path = Path.Combine(Server.MapPath("~/Images"), file.FileName);
                    file.SaveAs(path);
                    TempData["pathImage"] = "~/Images/" + file.FileName;
                }
            }
            return RedirectToAction("Create", "AdminManage");
        }

        [HttpPost]
        public ActionResult UploadImageEdit(HttpPostedFileBase file, int ID)
        {
            var path = "";
            if (file != null && file.ContentLength > 0)
            {
                // check extension of file
                if (Path.GetExtension(file.FileName).ToLower() == ".jpg" || Path.GetExtension(file.FileName).ToLower() == ".png"
                   || Path.GetExtension(file.FileName).ToLower() == ".gif" || Path.GetExtension(file.FileName).ToLower() == ".jpeg" ||
                   Path.GetExtension(file.FileName).ToLower() == ".svg")
                {
                    path = Path.Combine(Server.MapPath("~/Images"), file.FileName);
                    file.SaveAs(path);
                    TempData["pathImageEdit"] = "~/Images/" + file.FileName;
                }
            }
            return RedirectToAction("Edit", "AdminManage", new { ID = ID });
        }
    }
}