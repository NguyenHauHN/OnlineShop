using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnlineShop.Common
{
    [Serializable]
    public class UserLogin
    {
        public long UserID { get; set; }
        public string Username { get; set; }
        public string Name { get; set; }
        public string Avatar { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public DateTime? JoinDate { get; set; } 
        public string GroupID { get; set; }
    }
}