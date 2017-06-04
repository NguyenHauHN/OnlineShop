using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using Model.DAO;
using System.IO;
using Model.EF;
using System.Threading.Tasks;
using System.Net;
using System.Web.Script.Serialization;
using System.Xml.Linq;
using OnlineShop.Common;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class ProductController : BaseController
    {
        // GET: Admin/Product
        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult Index(string keyword, int page = 1, int pageSize = 5)
        {
            int totalProduct = 0;
            var listProduct = new ProductDAO().ListAllproduct(keyword, ref totalProduct, page, pageSize);
            ViewBag.Keyword = keyword;
            ViewBag.Page = page;
            return View(listProduct);
        }

        [HttpGet]
        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult Create()
        {
            TempData["ListGalleryImage"] = null;
            var listCategory = new CategoryDAO().GetList();
            ViewBag.ListCategory = listCategory;
            return View();
        }

        [HttpPost]
        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult Create(Product product, string mainImageProduct)
        {
            if (ModelState.IsValid)
            {
                try
                {
                   
                    if (TempData["ListGalleryImage"] != null)
                    {
                        product.GalleryImage = TempData["ListGalleryImage"].ToString();
                    }
                    if (!string.IsNullOrEmpty(mainImageProduct))
                    {
                        product.MainImage = mainImageProduct;
                    }
                    
                    var result = new ProductDAO().Insert(product);
                    if (result > 0)
                    {
                        return RedirectToAction("Index", "Product");
                    }
                    else
                    {
                        TempData["CreateError"] = "Thêm mới sản phẩm không thành công!";
                        return RedirectToAction("Create", "Product");
                    }

                }
                catch (Exception)
                {

                }
            }
            return View();
        }

        [HttpGet]
        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult Edit(long ID)
        {
            var product = new ProductDAO().GetByID(ID);
            TempData["SaveGalleryImage"] = product.GalleryImage;
            var listCategory = new CategoryDAO().GetList();
            ViewBag.ListCategory = listCategory;
            var listStatusProduct = new ProductDAO().GetAllStatus();
            ViewBag.ListStatusProduct = listStatusProduct;
            return View(product);
        }

        [HttpPost]
        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult Edit(Product product, string saveMainImage)
        {
            if (ModelState.IsValid)
            {

                if (!string.IsNullOrEmpty(saveMainImage))
                {
                    product.MainImage = saveMainImage;
                }
                if (TempData["ListGalleryImage"] != null)
                {
                    product.GalleryImage = product.GalleryImage + TempData["ListGalleryImage"].ToString();
                }
                else if(TempData["SaveGalleryImage"] != null)
                {
                    product.GalleryImage = TempData["SaveGalleryImage"].ToString();
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
      
        [HttpPost]
        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult UploadImage()
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

        public JsonResult SaveGalleryImage(string images)
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
                TempData["ListGalleryImage"] = xmlImage;

                return Json(new
                {
                    status = true
                });
              
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

        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult UpdateGalleryImage(long ID)
        {
            ViewBag.ProductID = ID;
            return View();
        }

        [HasCredential(RoleID = "PRODUCT_MANAGE")]
        public ActionResult Delete(long ID)
        {
            var result = new ProductDAO().Delete(ID);
            return RedirectToAction("Index", "Product");
        }



    }
}