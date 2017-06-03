﻿using Model.EF;
using Model.ViewModels;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.DAO
{
    public class OrderDAO
    {
        OnlineShopDbContext db = null;
        public OrderDAO()
        {
            db = new OnlineShopDbContext();
        }

        public IEnumerable<Order> ListAllOrder(string keyword, ref int totalOrder, int page = 1, int pageSize = 5)
        {
            IQueryable<Order> model = db.Orders;
            if (!string.IsNullOrEmpty(keyword))
            {
                model = model.Where(x => x.Status != 5 && (x.CustomerName.Contains(keyword) || x.CustomerAddress.Contains(keyword) || x.CustomerPhone.Contains(keyword)));
            }
            else
            {
                model = model.Where(x => x.Status != 5);
            }


            totalOrder = model.Count();
            return model.OrderByDescending(x => x.CreateDate).ToPagedList(page, pageSize);
        }

        public List<StatusViewModel> GetAllStatus()
        {
            var listStatusOrder = new List<StatusViewModel>();
            listStatusOrder.Add(new StatusViewModel()
            {
                Value = 1,
                Name = "Đơn hàng mới"
            });
            listStatusOrder.Add(new StatusViewModel()
            {
                Value = 2,
                Name = "Đang giao hàng"
            });
            listStatusOrder.Add(new StatusViewModel()
            {
                Value = 3,
                Name = "Đã thanh toán"
            });
            listStatusOrder.Add(new StatusViewModel()
            {
                Value = 4,
                Name = "Đã hủy"
            });
            return listStatusOrder;
        }

        public Order GetByID(long ID)
        {
            return db.Orders.Find(ID);
        }
       

        public int Update(Order order)
        {
            try
            {
                var editOrder = db.Orders.Find(order.ID);
                editOrder.Status = order.Status;
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Delete(long ID)
        {
            try
            {
                var order = db.Orders.Find(ID);
                order.Status = 5;
                db.SaveChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public List<OrderProduct> GetProductOrder(long orderID)
        {
            return db.OrderProducts.Where(x => x.OrderID == orderID).ToList();
        }


        public IEnumerable<OrderProduct> ListAllProduct(long orderID, string keyword, ref int totalOrderProduct, int page = 1, int pageSize = 5)
        {
            IQueryable<OrderProduct> model = db.OrderProducts;
            if (!string.IsNullOrEmpty(keyword))
            {
                //model = model.Where(x => x.OrderID == orderID && (x.ProductName.Contains(keyword)));
            }
            else
            {
                model = model.Where(x => x.OrderID == orderID);
            }


            totalOrderProduct = model.Count();
            return model.OrderByDescending(x => x.ProductID).ToPagedList(page, pageSize);
        }

        public long InsertOrder(long customerID, string orderAddress, string Note)
        {
            try
            {
                var customer = db.Users.Find(customerID);
                var order = new Order();
                order.CustomerID = customer.ID;
                order.CustomerName = customer.Name;
                order.CustomerAddress = customer.Address;
                order.CustomerEmail = customer.Email;
                order.CustomerPhone = customer.Phone;
                order.OrderAddress = orderAddress;
                order.Note = Note;
                order.Status = 1;
                order.CreateDate = DateTime.Now;
                db.Orders.Add(order);
                db.SaveChanges();
                return order.ID;
            }
            catch (Exception)
            {
                return -1;
            }
            
        }

        public int InsertOrderProduct(long orderID, List<OrderProduct> listOrderProduct)
        {
            try
            {
                foreach(var item in listOrderProduct)
                {
                    item.OrderID = orderID;
                }
                db.OrderProducts.AddRange(listOrderProduct);
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int PlaceOrder(long customerID, string orderAddress, string Note, List<OrderProduct> listOrderProduct)
        {
            try
            {
                var orderID = new OrderDAO().InsertOrder(customerID, orderAddress, Note);
                if (orderID > 0)
                {
                    var result = new OrderDAO().InsertOrderProduct(orderID, listOrderProduct);
                    if(result > 0)
                    {
                        return 1;
                    }
                    else
                    {
                        return -3;
                    }
                }
                else
                {
                    return -1;
                }
            }
            catch (Exception)
            {
                return -2;
            }

            
        }

    }
}
