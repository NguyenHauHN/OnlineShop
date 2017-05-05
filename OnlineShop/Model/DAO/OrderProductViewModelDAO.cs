using Model.EF;
using Model.ViewModels;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.DAO
{
    public class OrderProductViewModelDAO
    {
        OnlineShopDbContext db = null;
        public OrderProductViewModelDAO()
        {
            db = new OnlineShopDbContext();
        }

        public IEnumerable<OrderViewModel> ListAllOrderProduct(string keyword, ref int totalOrder, int page = 1, int pageSize = 5)
        {
            var listOrder = from o in db.OrderProducts
                            join p in db.Products
                            on o.ProductID equals p.ID
                            join u in db.Users
                            on o.ReceiverID equals u.ID
                            select new OrderViewModel()
                            {
                                OrderID = o.OrderID,
                                ProductID = p.ID,
                                ProductName = p.Name,
                                ProductPrice = p.Price,
                                ProductAmount = o.Amount,
                                ReceiverID = u.ID,
                                ReceiverName = u.Name,
                                ReceiverAddress = u.Address,
                                ReceiverPhone = u.Phone,
                                ReveiverEmail = u.Email,
                                Status = o.Status
                            };
            totalOrder = listOrder.Count();
            return listOrder.OrderBy(x => x.Status).ToPagedList(page, pageSize);
        }

        public int Insert(OrderViewModel order)
        {
            try
            {
                var orderProduct = new OrderProduct();
                orderProduct.ProductID = order.ProductID;
                orderProduct.ReceiverID = order.ReceiverID;
                orderProduct.Price = order.ProductPrice;
                orderProduct.Amount = order.ProductAmount;
                orderProduct.Status = 0;
                orderProduct.CreateDate = DateTime.Now;
                db.OrderProducts.Add(orderProduct);
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }
    }
}
