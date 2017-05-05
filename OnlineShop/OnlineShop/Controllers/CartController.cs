using Model.DAO;
using OnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace OnlineShop.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        private const string CardSession = "CardSession";
        public ActionResult Index()
        {
            var listItem = new List<CardItem>();
            if (Session[CardSession] != null)
            {
                listItem = (List<CardItem>)Session[CardSession];
            }
            return View(listItem);
        }

        public ActionResult AddToCart(long productID, int quantity)
        {
            var product = new ProductDAO().GetByID(productID);
            if (Session[CardSession] != null)
            {
                var listExistItem = (List<CardItem>)Session[CardSession];
                if (listExistItem.Exists(x => x.Product.ID == productID))
                {
                    listExistItem.Find(x => x.Product.ID == productID).Quantity += quantity;
                }
                else
                {
                    var item = new CardItem();
                    item.Product = product;
                    item.Quantity = quantity;
                    listExistItem.Add(item);

                }
                Session[CardSession] = listExistItem;
            }
            else
            {
                var item = new CardItem();
                item.Product = product;
                item.Quantity = quantity;
                var listNewItem = new List<CardItem>();
                listNewItem.Add(item);
                Session[CardSession] = listNewItem;
            }

            return RedirectToAction("Index","Cart");
        }

        public JsonResult Update(string cardModel)
        {
            var jsonCard = new JavaScriptSerializer().Deserialize<List<CardItem>>(cardModel);
            var sessionCard = (List<CardItem>)Session[CardSession];
            foreach (var item in sessionCard)
            {
                var jsonItem = jsonCard.SingleOrDefault(x => x.Product.ID == item.Product.ID);
                if (jsonItem != null)
                {
                    item.Quantity = jsonItem.Quantity;
                }
            }
            Session[CardSession] = sessionCard;
            return Json(
                new
                {
                    status = true
                });

        }


        public JsonResult DeleteAll()
        {
            Session[CardSession] = null;
            return Json(
                new
                {
                    status = true
                });

        }
        public JsonResult Delete(long id)
        {
            var sessionCard = (List<CardItem>)Session[CardSession];
            sessionCard.RemoveAll(x => x.Product.ID == id);
            Session[CardSession] = sessionCard;
            return Json(
                new
                {
                    status = true
                });

        }

        public ActionResult Payment()
        {
            var listItem = new List<CardItem>();
            if (Session[CardSession] != null)
            {
                listItem = (List<CardItem>)Session[CardSession];
            }
            return View(listItem);
        }

        //[HttpPost]
        //public ActionResult Payment(string CustomerName, string CustomerPhone, string CustomerEmail, string CustomerAddress)
        //{
        //    var order = new Order();
        //    order.CreateDate = DateTime.Now;
        //    order.CustomerName = CustomerName;
        //    order.CustomerPhone = CustomerPhone;
        //    order.CustomerEmail = CustomerEmail;
        //    order.CustomerAddress = CustomerAddress;
        //    try
        //    {
        //        var id = new OrderDAO().Insert(order);
        //        var card = (List<CardItem>)Session[CardSession];
        //        var detailDAO = new OrderDetailDAO();
        //        foreach (var item in card)
        //        {
        //            var orderDetail = new OrderDetail();
        //            orderDetail.ProductID = item.Product.ID;
        //            orderDetail.OrderID = id;
        //            orderDetail.Price = item.Product.Price;
        //            orderDetail.Quantity = item.Quantity;
        //            detailDAO.Insert(orderDetail);
        //        }
        //    }
        //    catch
        //    {

        //    }

        //    return Redirect("/hoan-thanh");
        //}

        public ActionResult PaymentSuccess()
        {
            return View();
        }
    }
}