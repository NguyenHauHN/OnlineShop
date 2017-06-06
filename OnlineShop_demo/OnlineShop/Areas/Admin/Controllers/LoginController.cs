using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OnlineShop.Areas.Admin.Models;
using Models.DAO;
using OnlineShop.Common;


namespace OnlineShop.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        // GET: Admin/Login
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login(LoginModel model)
        {
            var userDAO = new UserDAO();
            if (ModelState.IsValid)
            {
                var result = userDAO.Login(model.Username, Encrypt.MD5Hash(model.Password));
                if (result == 1)
                {
                    var user = userDAO.GetByUsername(model.Username);
                    var userSession = new UserLogin();
                    userSession.Username = user.Username;
                    userSession.UserID = user.ID;

                    Session.Add(CommonConstant.USER_SESSION, userSession);
                    return RedirectToAction("Index", "Home");
                }
                else if(result == 0)
                {
                    ModelState.AddModelError("", "Tài khoản không tồn tại!");
                }
                else if(result == -1)
                {
                    ModelState.AddModelError("", "Tài khoản đang bị khóa!");
                }
                else if(result == -2)
                {
                    ModelState.AddModelError("", "Mật khẩu bị sai!");
                }
            }
            return View("Index");
           
        }
    }
}