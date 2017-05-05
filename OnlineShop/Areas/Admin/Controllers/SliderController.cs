using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.DAO;
using System.IO;
using Model.EF;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class SliderController : BaseController
    {
        // GET: Admin/Slider
        public ActionResult Index(string keyword, int page = 1, int pageSize = 10)
        {
            int totalSlider = 0;
            var listSlider = new SliderDAO().ListAllSlider(keyword, ref totalSlider, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listSlider);
        }

        [HttpGet]
        public ActionResult Create()
        {
            if (TempData["pathImage"] != null)
            {
                Session["imageUpload"] = TempData["pathImage"];
                ViewBag.srcImg = TempData["pathImage"];
            }
            else
            {
                ViewBag.srcImg = "~/Images/plus.png";
            }
            return View();
        }

        [HttpPost]
        public ActionResult Create(Slide slide)
        {
            if (ModelState.IsValid)
            {
                slide.Image = Session["imageUpload"].ToString();
                var result = new SliderDAO().Insert(slide);
                if(result > 0)
                {
                    return RedirectToAction("Index", "Slider");
                }
                else
                {
                    ModelState.AddModelError("", "Thêm mới không thành công!");
                }
                
            }
            return View("Index");
        }

        [HttpPost]
        public ActionResult UploadImageCreate(HttpPostedFileBase file)
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
                    TempData["pathImage"] = "~/Images/" + file.FileName;
                }
            }
            return RedirectToAction("Create", "Slider");
        }

        [HttpGet]
        public ActionResult Edit(int ID)
        {
            var slider = new SliderDAO().GetByID(ID);
            if (TempData["pathImageEdit"] != null)
            {
                Session["imageUploadEdit"] = TempData["pathImageEdit"];
                ViewBag.srcImgEdit = TempData["pathImageEdit"];
            }
            else if (!string.IsNullOrEmpty(slider.Image))
            {

                ViewBag.srcImgEdit = slider.Image;
                Session["imageUploadEdit"] = slider.Image;
            }
            else
            {
                ViewBag.srcImgEdit = "~/Images/plus.png";
            }
            return View(slider);
        }

        [HttpPost]
        public ActionResult Edit(Slide slide)
        {
            if (ModelState.IsValid)
            {
                if (Session["imageUploadEdit"] != null)
                {
                    slide.Image = Session["imageUploadEdit"].ToString();
                }
                var result = new SliderDAO().Update(slide);
                if(result > 0)
                {
                    return RedirectToAction("Index", "Slider");
                }
                else
                {
                    ModelState.AddModelError("", "Thêm mới không thành công!");
                }
            }
            return View("Index");
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
            return RedirectToAction("Edit", "Slider", new { ID = ID });
        }


        [HttpDelete]
        public ActionResult Delete(int ID)
        {
            var result = new SliderDAO().Delete(ID);
            return View();
        }

    }
}