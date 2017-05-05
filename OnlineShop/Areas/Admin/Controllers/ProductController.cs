using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.DAO;
using Model.ViewModels;
using System.IO;
using Model.EF;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        // GET: Admin/Product
        public ActionResult Index(string keyword, int page = 1, int pageSize = 10)
        {
            int totalProduct = 0;
            var listProduct = new ProductDisplayDAO().ListAllProduct(keyword, ref totalProduct, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listProduct);
        }

        [HttpGet]
        public ActionResult Create()
        {
            if (TempData["pathImage"] != null)
            {
                Session["imageProduct"] = TempData["pathImage"];
                ViewBag.srcImg = TempData["pathImage"];
            }
            else
            {
                ViewBag.srcImg = "~/Images/plus.png";
            }

            return View();
        }

        [HttpPost]
        public ActionResult Create(ProductDisplay productDisplay)
        {
            if (ModelState.IsValid)
            {
                ImageProduct img = new ImageProduct();
                productDisplay.ListImage = new List<ImageProduct>();
                img.Src = Session["imageProduct"].ToString();
                productDisplay.ListImage.Add(img);

                productDisplay.Product.CreateDate = DateTime.Now;
                productDisplay.Product.Status = 1;
                productDisplay.Product.Type = 0;

                var result = new ProductDisplayDAO().Insert(productDisplay);
                if (result > 0)
                {
                    return RedirectToAction("Index", "Product");
                }
                else
                {
                    ModelState.AddModelError("", "Thêm mới sản phẩm không thành công!");
                }

            }
            return View();
        }

        [HttpPost]
        public ActionResult UploadSingleImage(HttpPostedFileBase file)
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
            return RedirectToAction("Create", "Product");
        }

        [HttpGet]
        public ActionResult Edit(int ID)
        {
            var productDisplay = new ProductDisplay();
            var product = new ProductDAO().GetByID(ID);
            var imageProduct = new ImageDAO().GetMainImgByProductID(ID);
            productDisplay.Product = product;
            productDisplay.ListImage = new List<ImageProduct>();
            productDisplay.ListImage.Add(imageProduct);
            ViewBag.srcImgEdit = "~/Images/plus.png";

            if (TempData["pathImageEdit"] != null)
            {
                Session["avatarUploadEdit"] = TempData["pathImageEdit"];
                ViewBag.srcImgEdit = TempData["pathImageEdit"];
            }
            else if(!string.IsNullOrEmpty(imageProduct.Src))
            {

                ViewBag.srcImgEdit = imageProduct.Src;
                Session["avatarUploadEdit"] = imageProduct.Src;
            }
            else
            {
                ViewBag.srcImgEdit = "~/Images/plus.png";
            }
            return View(productDisplay);
        }

        [HttpPost]
        public ActionResult Edit(ProductDisplay productDisplay)
        {
            if (ModelState.IsValid)
            {
                var imgUpload = new ImageProduct();
                if (Session["avatarUploadEdit"] != null)
                {
                    foreach(var item in productDisplay.ListImage)
                    {
                        if(item.Type == 1)
                        {
                            item.Src = Session["avatarUploadEdit"].ToString(); ;
                        }
                    }
                }
                
                var result = new ProductDisplayDAO().Update(productDisplay);
                if (result == 1)
                {
                    return RedirectToAction("Index", "Product");

                }
                else
                {
                    ModelState.AddModelError("", "Đã xảy ra lỗi, Cập nhật không thành công!");
                }
            }
            return View("Index");
        }


        [HttpPost]
        public ActionResult UploadSingleImageEdit(HttpPostedFileBase file, int productID)
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
            return RedirectToAction("Edit", "Product", new { ID = productID });
        }

        [HttpDelete]
        public ActionResult Delete(int ID)
        {
            var productDisplay = new ProductDisplay();
            var product = new ProductDAO().GetByID(ID);
            var imageProduct = new ImageDAO().GetMainImgByProductID(ID);
            productDisplay.Product = product;
            productDisplay.ListImage = new List<ImageProduct>();
            productDisplay.ListImage.Add(imageProduct);

            var result = new ProductDisplayDAO().Delete(productDisplay);
            return View();
        }
    }
}