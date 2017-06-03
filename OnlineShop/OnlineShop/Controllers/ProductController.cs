using Model.DAO;
using Model.EF;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Xml.Linq;

namespace OnlineShop.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult ViewDetail(long ID)
        {
            var product = new ProductDAO().GetByID(ID);
            var galleryImage = new ProductController().LoadGalleryImage(ID).Data;
            var json = JsonConvert.SerializeObject(galleryImage);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            dynamic jsonObject = serializer.Deserialize<dynamic>(json);
            dynamic x = jsonObject["data"];
            ViewBag.GalleryImage = x;
            ViewBag.Category = new CategoryDAO().GetByID(product.CategoryID);
            ViewBag.ListRelateProduct = new ProductDAO().GetListRelateProduct(product.CategoryID);
            return View(product);
        }

        public JsonResult SearchProduct(string Keyword)
        {
            var listProduct = new List<Product>();
            listProduct = new ProductDAO().ResultSearch(Keyword);
            return Json(new
            {
                Status = true,
                ListData = listProduct
            }, JsonRequestBehavior.AllowGet);
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

    }
}