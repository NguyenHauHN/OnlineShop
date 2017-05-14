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
using System.Threading.Tasks;
using System.Net;
using System.Web.Script.Serialization;
using System.Xml.Linq;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        // GET: Admin/Product
        public ActionResult Index(string keyword, int page = 1, int pageSize = 5)
        {
            int totalProduct = 0;
            var listProduct = new ProductDAO().ListAllproduct(keyword, ref totalProduct, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listProduct);
        }

        [HttpGet]
        public ActionResult Create()
        {
            if (TempData["pathImage"] != null)
            {
                Session["avatarUploadProduct"] = TempData["pathImage"];
                ViewBag.srcImg = TempData["pathImage"];
            }
            else
            {
                ViewBag.srcImg = "~/Images/plus.png";
            }
            return View();
        }

        [HttpPost]
        public ActionResult Create(Product product)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (TempData["ListGalleryImage"] != null)
                    {
                        product.GalleryImage = TempData["ListGalleryImage"].ToString();
                    }
                    if (Session["avatarUploadProduct"] != null)
                    {
                        product.MainImage = Session["avatarUploadProduct"].ToString();
                    }
                    var result = new ProductDAO().Insert(product);
                    if (result > 0)
                    {
                        return RedirectToAction("Index", "Product");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Thêm mới sản phẩm không thành công!");
                    }

                }
                catch (Exception)
                {

                }
            }
            return View();
        }

        [HttpGet]
        public ActionResult Edit(long ID)
        {
            var product = new ProductDAO().GetByID(ID);
            ViewBag.Src = "abc";
            return View(product);
        }

        [HttpPost]
        public ActionResult Edit(Product product, string saveMainImg)
        {
            if (ModelState.IsValid)
            {

                if (!string.IsNullOrEmpty(saveMainImg))
                {
                    product.MainImage = saveMainImg;
                }
                if (TempData["ListGalleryImage"] != null)
                {
                    product.GalleryImage = product.GalleryImage + TempData["ListGalleryImage"].ToString();
                }
                try
                {
                    var result = new ProductDAO().Update(product);
                    if (result > 0)
                    {
                        return RedirectToAction("Index", "Product");

                    }
                    else
                    {
                        ModelState.AddModelError("", "Cập nhật thông tin sản phẩm không thành công!");
                    }
                }
                catch (Exception)
                {

                }
            }
            return View();
        }


        public ActionResult UploadGalleryImage()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UploadImageMainImage(HttpPostedFileBase file)
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

        [HttpPost]
        public ActionResult UploadImageGalleryImage()
        {
            try
            {
                var path = "";
                if (System.Web.HttpContext.Current.Request.Files.AllKeys.Any())
                {
                    var pic = System.Web.HttpContext.Current.Request.Files["HelpSectionImages"];
                    HttpPostedFileBase filebase = new HttpPostedFileWrapper(pic);
                    var fileName = Path.GetFileName(filebase.FileName);
                    path = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    filebase.SaveAs(path);
                    return Json(new { name = "/Images/" + fileName });
                }
                else { return Json(new { name = "~/Images/plus.png" }); }
            }
            catch (Exception ex)
            {
                return Json("Error While Saving.");
            }
        }

        public JsonResult SaveGalleryImage(string id, string images)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var listImage = serializer.Deserialize<List<string>>(images);
            XElement xmlImage = new XElement("Images");
            foreach (var item in listImage)
            {
                xmlImage.Add(new XElement("Image", item));
            }
            try
            {
                var result = new ProductDAO().SaveGalleryImage(Convert.ToInt32(id), xmlImage.ToString());
                if (result > 0)
                {
                    TempData["ListGalleryImage"] = xmlImage;
                    return Json(new
                    {
                        status = true
                    });
                }
                else
                {
                    return Json(new
                    {
                        status = false
                    });
                }

            }
            catch (Exception)
            {
                return Json(new
                {
                    status = false
                });
            }

        }

        public JsonResult LoadGalleryImage(long id)
        {
            ProductDAO proDAO = new ProductDAO();
            var product = proDAO.GetByID(id);
            var listImage = product.GalleryImage;
            List<string> listImageReturn = new List<string>();
            if (!string.IsNullOrEmpty(listImage))
            {
                XElement xmlImg = XElement.Parse(listImage);
                foreach (XElement element in xmlImg.Elements())
                {
                    listImageReturn.Add(element.Value);
                }
            }
            return Json(new
            {
                data = listImageReturn
            }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult UpdateGalleryImage(long ID)
        {
            ViewBag.ProductID = ID;
            return View();
        }


    }
}