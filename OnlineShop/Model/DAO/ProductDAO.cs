using Model.EF;
using Model.ViewModels;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
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
            //IQueryable<ProductViewModel> model = null;
            //if (!string.IsNullOrEmpty(keyword))
            //{
            //    model = model.Where(x => x.Status != 0 && (x.Name.Contains(keyword) || x.Code.Contains(keyword) || x.Description.Contains(keyword)));
            //}
            //else
            //{
            //    model = model.Where(x => x.Status != 0);
            //}
            var model = db.Products.GroupBy(u => u.GroupID).Select(g => new 
                                                                            {
                                                                                Amount = g.Count(),
                                                                                Product = g.ToList()
                                                                            });

            totalProduct = model.Count();
            return model.OrderByDescending(x => x.Product.Code).ToPagedList(page, pageSize);
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

        public Product GetMaxCode()
        {
            return db.Products.OrderByDescending(i => i.Code.Substring(2)).FirstOrDefault();
        }

        public List<Product> GetNewProduct()
        {
            return db.Products.Where(x => x.Status == 2 && x.Type != 1).ToList();
        }

        public long Insert(List<Product> listProduct)
        {
            try
            {
                db.Configuration.AutoDetectChangesEnabled = false;
                db.Products.AddRange(listProduct);
                db.SaveChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
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

        public int Update(List<Product> listProduct)
        {
            try
            {
                //db.Products.Attach(listProduct);
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
                foreach (var item in listProduct)
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

        public string ConvertToTimestamp(DateTime target)
        {
            var date = new DateTime(1970, 1, 1, 0, 0, 0, target.Kind);
            var unixTimestamp = System.Convert.ToInt64((target - date).TotalSeconds);

            return unixTimestamp.ToString();
        }


    }
}
