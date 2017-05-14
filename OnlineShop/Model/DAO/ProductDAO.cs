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

        public IEnumerable<Product> ListAllproduct(string keyword, ref int totalProduct, int page = 1, int pageSize = 5)
        {
            IQueryable<Product> model = db.Products;
            if (!string.IsNullOrEmpty(keyword))
            {
                model = model.Where(x => x.Status != 0 && (x.Name.Contains(keyword) || x.Code.Contains(keyword) || x.Description.Contains(keyword)));
            }
            else
            {
                model = model.Where(x => x.Status != 0);
            }

            totalProduct = model.Count();
            return model.OrderByDescending(x => x.CreateDate).ToPagedList(page, pageSize);
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

        public int SaveGalleryImage(long ID, string listImage)
        {
            try
            {
                var product = new ProductDAO().GetByID(ID);
                product.GalleryImage = listImage;
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
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
                prod.MainImage = product.MainImage;
                prod.GalleryImage = product.GalleryImage;
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
