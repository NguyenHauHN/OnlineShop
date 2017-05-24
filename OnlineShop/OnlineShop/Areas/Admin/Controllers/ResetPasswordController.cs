using Model.DAO;
using Model.EF;
using OnlineShop.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class ResetPasswordController : Controller
    {
        // GET: Admin/ResetPassword
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ResetPassword(User user, string newPassword, string reNewPassword)
        {
            if (newPassword.Equals(reNewPassword))
            {
                user.Password = Encrypt.MD5Hash(newPassword);
                var result = new UserDAO().ResetPassword(user);
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
            return RedirectToAction("Index", "ResetPassword");
        }
    }
}