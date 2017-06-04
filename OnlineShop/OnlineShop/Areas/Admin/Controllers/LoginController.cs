using Model.DAO;
using OnlineShop.Areas.Admin.Models;
using OnlineShop.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

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
            UserDAO userDAO = new UserDAO();
            if (ModelState.IsValid)
            {
                var result = userDAO.Login(model.Username, Encrypt.MD5Hash(model.Password), true);
                if(result >0)
                {
                    var user = userDAO.GetByUsername(model.Username);
                    var userLogin = new UserLogin();
                    // gan session
                    userLogin.Username = user.Username;
                    userLogin.UserID = user.ID;
                    userLogin.Avatar = user.Avatar;
                    userLogin.Name = user.Name;
                    userLogin.Password = user.Password;
                    userLogin.Email = user.Email;
                    userLogin.JoinDate = user.JoinDate;
                    userLogin.GroupID = user.GroupID;
                    var listCredential = userDAO.GetListCredential(user.Username);
                    Session.Add(CommonConstant.SESSION_CREDENTIAL, listCredential);
                    Session.Add(CommonConstant.USER_SESSION, userLogin);
                    return RedirectToAction("Index", "AdminManage");
                }
                else if(result == -1)
                {
                    ModelState.AddModelError("", "Tài khoản đang bị khóa!");
                }
                else if (result == 0)
                {
                    ModelState.AddModelError("", "Tài khoản không tồn tại!");
                }
                else if (result == -2)
                {
                    ModelState.AddModelError("", "Sai mật khẩu!");
                }
                else if (result == -3)
                {
                    ModelState.AddModelError("", "Tài khoản của bạn không có quyền đăng nhập!");
                }

            }
            return View("Index");
        }

        public ActionResult RedrectLogin(string Username, string Password)
        {
            var loginModel = new LoginModel();
            loginModel.Username = Username;
            loginModel.Password = Password;
            return RedirectToAction("Login","Login", new {
                Username = Username,
                Password = Password
            });
        }

        
    }
}