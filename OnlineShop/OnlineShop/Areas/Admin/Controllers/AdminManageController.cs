using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;
using PagedList;
using System.Web.Services;
using System.IO;
using OnlineShop.Common;
using System.Text.RegularExpressions;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class AdminManageController : BaseController
    {

        // GET: Admin/AdminManage
        [HasCredential(RoleID ="ADMIN_MANAGE")]
        public ActionResult Index(string keyword, int page = 1, int pageSize = 5)
        {
            int totalAdmin = 0;
            var listAdmin = new UserDAO().ListAllAdmin(keyword, ref totalAdmin, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listAdmin);
        }

        [HttpGet]
        [HasCredential(RoleID = "ADMIN_MANAGE")]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [HasCredential(RoleID = "ADMIN_MANAGE")]
        public ActionResult Create(User admin, string singleImage)
        {

            if (ModelState.IsValid)
            {
                admin.Avatar = singleImage;
                admin.Type = 1;
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
        [HasCredential(RoleID = "ADMIN_MANAGE")]
        public ActionResult Edit(int ID)
        {
            var admin = new UserDAO().GetByID(ID);
            return View(admin);
        }

        [HttpPost]
        [HasCredential(RoleID = "ADMIN_MANAGE")]
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

        [HasCredential(RoleID = "ADMIN_MANAGE")]
        public ActionResult Delete(int ID)
        {
            var result = new UserDAO().Delete(ID);
            return View();
        }

        [HasCredential(RoleID = "ADMIN_MANAGE")]
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
        public ActionResult ChangePassword()
        {
            var user = Session[CommonConstant.USER_SESSION];
            return View(user);
        }

        [HttpPost]
        public ActionResult ChangePassword(UserLogin user, string newPassword, string reNewPassword)
        {
            if (newPassword.Equals(reNewPassword))
            {
                var userTemp = new User();
                userTemp.Email = user.Email;
                userTemp.Username = user.Username;
                userTemp.Password = user.Password;
                userTemp.Password = Encrypt.MD5Hash(newPassword);
                var result = new UserDAO().ResetPassword(userTemp);
                if (result == 1)
                {
                    TempData["Success"] = "Đổi mật khẩu thành công!";
                }
                else if (result == -1)
                {
                    TempData["ErrorReset"] = "Có lỗi xảy ra!";
                }
                else if (result == -2)
                {
                    TempData["ErrorReset"] = "Tên đăng nhập không tồn tại!";
                }
                else if (result == -3)
                {
                    TempData["ErrorReset"] = "Email không chính xác!";
                }
            }
            else
            {
                TempData["ErrorReset"] = "Mật khẩu mới nhập lại không khớp!";
            }
            return RedirectToAction("ChangePassword", "AdminManage");
        }
    }
}