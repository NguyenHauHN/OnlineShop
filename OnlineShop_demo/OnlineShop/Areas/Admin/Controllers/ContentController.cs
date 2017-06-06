using Models.DAO;
using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class ContentController : BaseController
    {
        // GET: Admin/Content
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
        {
            SetViewbag();
            return View();
        }
        [HttpPost]
        public ActionResult Edit(long id)
        {
            if (ModelState.IsValid)
            {
                var content = new ContentDAO().GetById(id);
                SetViewbag(content.CategoryID);
            }
            return View();
        }

        [HttpPost]
        public ActionResult Create(Content model)
        {
            if (ModelState.IsValid)
            {

            }
            SetViewbag();
            return View();
        }
        public void SetViewbag(long? selectedID = null)
        {
            var categoryDAO = new CategoryDAO();
            ViewBag.CategoryID = new SelectList(categoryDAO.ListAll(), "ID", "Name", selectedID);
        }

    }
}