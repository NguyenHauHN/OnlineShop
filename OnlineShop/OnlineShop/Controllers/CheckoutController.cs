using Model.DAO;
using Model.EF;
using OnlineShop.Common;
using OnlineShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class CheckoutController : Controller
    {
        // GET: Checkout
        public ActionResult Index()
        {
            var listItem = new List<CartItem>();
            ViewBag.TotalMoneyCart = 0;
            if (Session[CommonConstant.CardSession] != null)
            {
                listItem = (List<CartItem>)Session[CommonConstant.CardSession];
                foreach (var item in listItem)
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

        [HttpPost]
        public JsonResult PlaceOrder(string Username, string AddressOrder, string Note)
        {
            var customer = new UserDAO().GetByUsername(Username);
            var listCartItem = new List<CartItem>();
            var listOrderProduct = new List<OrderProduct>();
            if (Session[CommonConstant.CardSession] != null)
            {
                listCartItem = (List<CartItem>)Session[CommonConstant.CardSession];
                foreach (var item in listCartItem)
                {
                    var orderProduct = new OrderProduct();
                    orderProduct.ProductID = item.Product.ID;
                    orderProduct.Amount = item.Amount;
                    orderProduct.TotalMoney = item.Product.Price * ((100 - item.Product.Sale) / 100) * item.Amount;
                    listOrderProduct.Add(orderProduct);
                }
                var result = new OrderDAO().PlaceOrder(customer.ID, AddressOrder, Note, listOrderProduct);
                if (result > 0)
                {
                    TempData["listOrderProduct"] = listOrderProduct;
                    TempData["customer"] = customer;
                    TempData["AddressOrder"] = AddressOrder;
                    return Json(new
                    {
                        status = true
                    });
                }
            }


            return Json(new
            {
                status = false
            });


        }

        public ActionResult PlaceSuccess()
        {
            var listCartItem = new List<CartItem>();
            ViewBag.TotalMoney = 0;
            if (Session[CommonConstant.CardSession] != null)
            {
                listCartItem = (List<CartItem>)Session[CommonConstant.CardSession];
            }
            var listOrderProduct = (List<OrderProduct>)TempData["listOrderProduct"];
            long orderID = 0;
            ViewBag.OrderCode = "ODZK-" + orderID;
            foreach (var item in listOrderProduct)
            {
                ViewBag.TotalMoney += item.TotalMoney;
                orderID = item.OrderID;
            }
            if(orderID > 0)
            {
                var order = new OrderDAO().GetByID(orderID);
                ViewBag.Order = order;
            }
            Session.Remove(CommonConstant.CardSession);
            return View(listCartItem);
        }
    }
}