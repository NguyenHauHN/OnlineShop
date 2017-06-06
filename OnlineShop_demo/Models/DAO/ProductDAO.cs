using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DAO
{
    public class ProductDAO
    {
        OnlineShopDbContext db = null;
        public ProductDAO()
        {
            db = new OnlineShopDbContext();
        }

        public List<Product> ListAll()
        {
            return db.Products.Where(x => x.Status == true).ToList();
        }

        public List<Product> ListNewProduct(int top)
        {
            return db.Products.OrderByDescending(x => x.CreateDate).Take(top).ToList();
        }

        public List<Product> ListFeatureProduct(int top)
        {
            return db.Products.Where(x => x.TopHot != null && x.TopHot > DateTime.Now).OrderByDescending(x => x.CreateDate).ToList();
        }

        public List<Product> ListRelateProduct(long productID)
        {
            var product = db.Products.Find(productID);
            return db.Products.Where(x => x.ID != productID && x.CategoryID == product.CategoryID).OrderByDescending(x => x.CreateDate).ToList();
        }

        public Product ViewDetail(long id)
        {
            return db.Products.Find(id);
        }

        public List<Product> ListProduct(long id, ref int totalProduct, int pageIndex = 1, int pageSize = 2)
        {
            totalProduct = db.Products.Where(x => x.CategoryID == id && x.Status == true).Count();
            var model = db.Products.Where(x => x.CategoryID == id && x.Status == true).OrderByDescending(x => x.CreateDate).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();
            return model;
        }


    }
}
