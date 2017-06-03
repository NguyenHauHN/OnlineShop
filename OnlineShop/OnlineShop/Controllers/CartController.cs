using Model.DAO;
using OnlineShop.Common;
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
        public ActionResult Index()
        {
            var listItem = new List<CartItem>();
            ViewBag.TotalMoneyCart = 0;
            ViewBag.TotalMoneyCartVAT = 0;
            if (Session[CommonConstant.CardSession] != null)
            {
                listItem = (List<CartItem>)Session[CommonConstant.CardSession];
                foreach(var item in listItem)
                {
                    ViewBag.TotalMoneyCart += item.Product.Price * ((100 - item.Product.Sale) / 100) * item.Amount;
                }
               
            }
            if (Session[Common.CommonConstant.CLIENT_SESSION] != null)
            {
                var clientModel = Session[Common.CommonConstant.CLIENT_SESSION] as ClientModel;
                ViewBag.ClientSession = clientModel.username;
            }

            return View(listItem);
        }


        public JsonResult AddToCart(long productID, int amount)
        {
            try
            {
                var product = new ProductDAO().GetByID(productID);
                if (Session[CommonConstant.CardSession] != null)
                {
                    var listExistItem = (List<CartItem>)Session[CommonConstant.CardSession];
                    if (listExistItem.Exists(x => x.Product.ID == productID))
                    {
                        listExistItem.Find(x => x.Product.ID == productID).Amount += amount;
                    }
                    else
                    {
                        var item = new CartItem();
                        item.Product = product;
                        item.Amount = amount;
                        listExistItem.Add(item);

                    }
                    Session[CommonConstant.CardSession] = listExistItem;
                }
                else
                {
                    var item = new CartItem();
                    item.Product = product;
                    item.Amount = amount;
                    var listNewItem = new List<CartItem>();
                    listNewItem.Add(item);
                    Session[CommonConstant.CardSession] = listNewItem;
                }
                return Json(
                   new
                   {
                       listItem = Session[CommonConstant.CardSession],
                       productID = productID,
                       status = true
                   });
            }
            catch (Exception)
            {
                return Json(
                   new
                   {
                       status = false
                   });
            }


        }
        public JsonResult Update(string cardModel)
        {
            var jsonCard = new JavaScriptSerializer().Deserialize<List<CartItem>>(cardModel);
            var sessionCard = (List<CartItem>)Session[CommonConstant.CardSession];
            foreach (var item in sessionCard)
            {
                var jsonItem = jsonCard.SingleOrDefault(x => x.Product.ID == item.Product.ID);
                if (jsonItem != null)
                {
                    item.Amount = jsonItem.Amount;
                }
            }
            Session[CommonConstant.CardSession] = sessionCard;
            return Json(
                new
                {
                    status = true
                });

        }


        public JsonResult DeleteAll()
        {
            Session[CommonConstant.CardSession] = null;
            return Json(
                new
                {
                    status = true
                });

        }
        public JsonResult Delete(long id)
        {
            var sessionCard = (List<CartItem>)Session[CommonConstant.CardSession];
            sessionCard.RemoveAll(x => x.Product.ID == id);
            Session[CommonConstant.CardSession] = sessionCard;
            return Json(
                new
                {
                    productID= id,
                    amount = sessionCard.Count(),
                    status = true
                });

        }

        public ActionResult Payment()
        {
            var listItem = new List<CartItem>();
            if (Session[CommonConstant.CardSession] != null)
            {
                listItem = (List<CartItem>)Session[CommonConstant.CardSession];
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