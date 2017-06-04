using Model.EF;
using Model.ViewModels;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;

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
                var list = db.Products.SqlQuery("select * from [Product] where Status !=4 and ( Name like N'%" + keyword + "%' or Code like N'%" + keyword + "%' or Description like N'%"
                    + keyword + "%')").AsQueryable<Product>();
                model = list;
            }
            else
            {
                model = model.Where(x => x.Status != 4);
            }


            totalProduct = model.Count();
            return model.OrderByDescending(x => x.GroupID).ToPagedList(page, pageSize);
        }

        public List<Product> ListAllProductMen()
        {
            return db.Products.Where(x => (x.CategoryID == 4 || x.CategoryID == 5 || x.CategoryID == 6) && (x.Status != 3 && x.Status != 4)).ToList();
        }

        public List<Product> ListAllProductWomen()
        {
            return db.Products.Where(x => (x.CategoryID == 7 || x.CategoryID == 8 || x.CategoryID == 9) && (x.Status != 3 && x.Status != 4)).ToList();
        }

        public List<Product> ListAllProductKid()
        {
            return db.Products.Where(x => (x.CategoryID == 10 || x.CategoryID == 11 || x.CategoryID == 12) && (x.Status != 3 && x.Status != 4)).ToList();
        }


        public List<Product> ListAllSaleProduct()
        {
            return db.Products.Where(x => x.Sale > 0 && (x.Status != 3 && x.Status != 4)).ToList();
        }

        public List<Product> ListProductNew()
        {
            return db.Products.Where(x => x.Status != 3 && x.Status != 4).OrderByDescending(x => x.CreateDate).Take(2).ToList();
        }

        public List<Product> ListProductFeature()
        {
            return db.Products.Where(x => x.Status != 3 && x.Status != 4).OrderByDescending(x => x.BuyAmount).Take(2).ToList();
        }

        public List<Product> ListProductTopRate(int limit)
        {
            return db.Products.Where(x => x.Status != 3 && x.Status != 4).OrderByDescending(x => x.BuyAmount).Take(limit).ToList();
        }
        public List<StatusViewModel> GetAllStatus()
        {
            var listStatus = new List<StatusViewModel>();
            listStatus.Add(new StatusViewModel()
            {
                Value = 1,
                Name = "Sản phẩm mới"

            });
            listStatus.Add(new StatusViewModel()
            {
                Value = 2,
                Name = "Sản phẩm đang sale"

            });
            listStatus.Add(new StatusViewModel()
            {
                Value = 3,
                Name = "Hết hàng"

            });
            listStatus.Add(new StatusViewModel()
            {
                Value = 4,
                Name = "Đã xóa"

            });
            return listStatus;

        }

        public List<Product> ListAll()
        {
            return db.Products.Where(x => x.Status != 4).ToList();
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

        public List<Product> GetByCategoryID(long categoryID, ref int totalProduct, int page = 1,
            int pageSize = 9, string valueSelectSort = null, string searchProduct = null, double minPrice = 0, double maxPrice = 0)
        {
            var model = new List<Product>();
            totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).Count();
            var offset = (page - 1) * pageSize;
            model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.CreateDate).Skip(offset).Take(pageSize).ToList();
            if (valueSelectSort == "1")
            {
                model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.CreateDate).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.CreateDate).Count();
            }
            else if (valueSelectSort == "2")
            {
                model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.Rate).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.Rate).Count();
            }
            else if (valueSelectSort == "3")
            {
                model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.BuyAmount).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.BuyAmount).Count();
            }
            else if (valueSelectSort == "4")
            {

                model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderBy(x => x.Price).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderBy(x => x.Price).Count();
            }
            else if (valueSelectSort == "5")
            {
                model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.Price).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.Price).Count();
            }
            if (!string.IsNullOrEmpty(searchProduct))
            {

                model = db.Products.SqlQuery("select * from Product where CategoryID =" + categoryID + " and Name like N'%" + 
                    searchProduct + "%' or Description like N'%" + searchProduct + "%' or Price like N'%"+ searchProduct + "%'").OrderByDescending(x => x.CreateDate).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.SqlQuery("select * from Product where CategoryID =" + categoryID + " and Name like N'%" +
                    searchProduct + "%' or Description like N'%" + searchProduct + "%' or Price like N'%" + searchProduct + "%'").OrderByDescending(x => x.CreateDate).Count();
            }

            if (minPrice > 0 && maxPrice > 0 && minPrice<= maxPrice)
            {
               model = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4 && (double)x.Price >= minPrice && (double)x.Price <= maxPrice).OrderByDescending(x => x.Price).Skip(offset).Take(pageSize).ToList();
                totalProduct = db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4 && (double)x.Price >= minPrice && (double)x.Price <= maxPrice).OrderByDescending(x => x.Price).Count();
            }
            
            return model;
        }

        public List<Product> ResultSearch(string Keyword)
        {
            var listProduct = new List<Product>();
            if (!string.IsNullOrEmpty(Keyword))
            {

                listProduct = db.Products.SqlQuery("select * from Product where Name like N'%" +
                    Keyword + "%'").ToList();
            }
            return listProduct;
        }


        public List<Product> GetListRelateProduct(long? categoryID)
        {
            return db.Products.Where(x => x.CategoryID == categoryID && x.Status != 3 && x.Status != 4).OrderByDescending(x => x.CreateDate).ToList();
        }
        public long Insert(Product product)
        {
            try
            {
                product.GroupID = new ProductDAO().ConvertToTimestamp(DateTime.Now);
                product.Code = "SP" + product.GroupID;
                product.Status = 1;
                product.CreateDate = DateTime.Now;
                db.Products.Add(product);
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

        public int Update(Product product)
        {
            try
            {
                var editProduct = db.Products.Find(product.ID);
                editProduct.Name = product.Name;
                editProduct.MetaTitle = product.MetaTitle;
                editProduct.MainImage = product.MainImage;
                editProduct.GalleryImage = product.GalleryImage;
                editProduct.Price = product.Price;
                editProduct.Sale = product.Sale;
                editProduct.Tag = product.Tag;
                editProduct.Description = product.Description;
                editProduct.Status = product.Status;
                editProduct.Amount = product.Amount;
                editProduct.CategoryID = product.CategoryID;
                editProduct.LastChange = DateTime.Now;
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
                product.Status = 4;
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
