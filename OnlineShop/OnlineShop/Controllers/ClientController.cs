using Model.DAO;
using OnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class ClientController : Controller
    {
        // GET: Client
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Login(string Username, string Password, bool RememberMe)
        {
            var result = new UserDAO().Login(Username, Password);
            if(result > 0)
            {
                if(RememberMe == true)
                {
                    Session[Common.CommonConstant.RememberMe] = 1;
                    
                }
                var clientModel = new ClientModel();
                clientModel.username = Username;
                clientModel.password = Password;
                Session[Common.CommonConstant.CLIENT_SESSION] = clientModel;
                return Json(new
                {
                    Result = result,
                    status = true
                });
            }
            else
            {
                return Json(new
                {
                    Result = result,
                    status = false
                });
            }
            
        }

        [HttpPost]
        public JsonResult Register(string Name, string Username, string Password, string ConfirmPassword, string Email, string PhoneNumber)
        {
            if(!string.IsNullOrEmpty(Name) && !string.IsNullOrEmpty(Username) && !string.IsNullOrEmpty(Password) && !string.IsNullOrEmpty(ConfirmPassword) 
                && !string.IsNullOrEmpty(Email) && !string.IsNullOrEmpty(PhoneNumber))
            {
                if(Password == ConfirmPassword)
                {
                    var result = new UserDAO().Register(Name, Username, Password, Email, PhoneNumber);
                    if(result > 0)
                    {
                        return Json(new
                        {
                            confirm = true,
                            check = true,
                            Status = true
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            confirm = true,
                            check = true,
                            Status = false
                        });
                    }
                    
                }
                else
                {
                    return Json(new
                    {
                        confirm = false,
                        check = true,
                        Status = false
                    });
                }
               
            }
            else
            {
                return Json(new
                {
                    confirm = false,
                    check = false,
                    Status = false
                });
            }
           
        }
    }
}