using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Common
{
    public class HasCredentialAttribute :AuthorizeAttribute
    {
        public string RoleID { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            var session = (UserLogin)HttpContext.Current.Session[CommonConstant.USER_SESSION];
            if(session == null)
            {
                return false;
            }
            List<string> privilegeLevels = this.GetCredentialByLoggedInUser(session.Username);
            if (privilegeLevels.Contains(this.RoleID) || session.GroupID == "ADMIN")
            {
                return true;

            }
            else
            {
                return false;
            }
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            var session = (UserLogin)HttpContext.Current.Session[CommonConstant.USER_SESSION];
            if(session != null)
            {
                filterContext.Result = new ViewResult
                {
                    ViewName = "~/Areas/Admin/Views/Shared/Error401.cshtml"
                };
            }
           
        }


        private List<string> GetCredentialByLoggedInUser(string username)
        {
            var credential = (List<string>)HttpContext.Current.Session[CommonConstant.SESSION_CREDENTIAL];
            return credential;
        }
    }
}