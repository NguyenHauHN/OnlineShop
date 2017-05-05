using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace OnlineShop.Areas.Admin.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Bạn không được để trống Tên đăng nhập")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Bạn không được để trống Mật khẩu")]
        public string Password { get; set; }

        public bool RememberMe { get; set; }
    }
}