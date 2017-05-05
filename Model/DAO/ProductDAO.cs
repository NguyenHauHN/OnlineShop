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
    public class ProductDAO
    {
        OnlineShopDbContext db = null;
        public ProductDAO()
        {
            db = new OnlineShopDbContext();
        }

        public List<Product> ListAll()
        {
            return db.Products.Where(x => x.Status != 0).ToList();
        }
        public Product GetByCode(string code)
        {
            return db.Products.SingleOrDefault(x => x.Code == code);
        }

        public Product GetByID(long ID)
        {
            return db.Products.Find(ID);
        }

        public List<Product> GetNewProduct()
        {
            return db.Products.Where(x => x.Status == 2 && x.Type != 1).ToList();
        }

        public long Insert(Product product)
        {
            var prod = db.Products.SingleOrDefault(x => x.Code == product.Code);
            if (prod != null)
            {
                return -1;
            }
            else
            {
                
                product.Type = 0;
                product.Status = 1;
                product.CreateDate = DateTime.Now;
                db.Products.Add(product);
                db.SaveChanges();
                return product.ID;
            }
        }

        public int Update(Product product)
        {
            try
            {
                var prod = db.Products.Find(product.ID);
                prod.Code = product.Code;
                prod.Name = product.Name;
                prod.MetaTitle = product.MetaTitle;
                prod.Description = product.Description;
                prod.Price = product.Price;
                prod.Sale = product.Sale;
                prod.Tag = product.Tag;
                prod.Status = product.Status;
                prod.Type = product.Type;
                prod.LastChange = DateTime.Now;
                //prod.ChangeBy = IDAdminChange;
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int UpdateCategoryID(int categoryID)
        {
            
            try
            {
                var listProduct = db.Products.Where(x => x.CategoryID == categoryID).ToList();
                foreach(var item in listProduct)
                {
                    item.CategoryID = null;
                }
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
                var product = db.Products.Find(ID);
                db.Products.Remove(product);
                db.SaveChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }


    }
}
