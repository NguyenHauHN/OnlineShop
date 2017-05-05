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
    public class ProductDisplayDAO
    {
        OnlineShopDbContext db = null;
        public ProductDisplayDAO()
        {
            db = new OnlineShopDbContext();
        }

        public IEnumerable<ProductDisplay> ListAllProduct(string keyword, ref int totalProduct, int page = 1, int pageSize = 10)
        {
            var listImg = from i in db.ImageProducts
                          group i by i.ProductID into g
                          select new
                          {
                              ProductID = g.Key,
                              img = g.ToList()
                          };
            IQueryable<ProductDisplay> listProduct = null;
            if (!string.IsNullOrEmpty(keyword))
            {
                listProduct = from p in db.Products
                              join i in listImg
                                on p.ID equals i.ProductID
                              where p.Name.Contains(keyword) || p.Description.Contains(keyword)
                              select new ProductDisplay()
                              {
                                  Product = p,
                                  ListImage = i.img
                              };
            }
            else
            {
                listProduct = from p in db.Products
                              join i in listImg
                                on p.ID equals i.ProductID
                              select new ProductDisplay()
                              {
                                  Product = p,
                                  ListImage = i.img
                              };
            }


            totalProduct = listProduct.Count();
            return listProduct.OrderByDescending(x => x.Product.CreateDate).ToPagedList(page, pageSize);

        }

        public List<ProductDisplay> ListNewProduct()
        {
            var listImg = from i in db.ImageProducts
                          group i by i.ProductID into g
                          select new
                          {
                              ProductID = g.Key,
                              img = g.ToList()
                          };
            var listNewProduct = from p in db.Products
                                                     join i in listImg
                                                     on p.ID equals i.ProductID
                                                     where p.Status == 2
                                                     select new ProductDisplay()
                                                     {
                                                         Product = p,
                                                         ListImage = i.img
                                                     };
            return listNewProduct.OrderByDescending(x => x.Product.CreateDate).ToList();
        }

        public List<ProductDisplay> ListProductForMen()
        {
            var listImg = from i in db.ImageProducts
                          group i by i.ProductID into g
                          select new
                          {
                              ProductID = g.Key,
                              img = g.ToList()
                          };
            var listSaleProduct = from p in db.Products
                                  join i in listImg
                                  on p.ID equals i.ProductID
                                  where p.Status != 0 && p.Type == 0
                                  select new ProductDisplay()
                                  {
                                      Product = p,
                                      ListImage = i.img
                                  };
            return listSaleProduct.OrderByDescending(x => x.Product.CreateDate).ToList();

        }
        public List<ProductDisplay> ListProductForWomen()
        {
            var listImg = from i in db.ImageProducts
                          group i by i.ProductID into g
                          select new
                          {
                              ProductID = g.Key,
                              img = g.ToList()
                          };
            var listSaleProduct = from p in db.Products
                                  join i in listImg
                                  on p.ID equals i.ProductID
                                  where p.Status != 0 && p.Type == 1
                                  select new ProductDisplay()
                                  {
                                      Product = p,
                                      ListImage = i.img
                                  };
            return listSaleProduct.OrderByDescending(x => x.Product.CreateDate).ToList();

        }

        public ProductDisplay GetByProductID(int productID)
        {
            var product = new ProductDAO().GetByID(productID);
            var listImg = new ImageDAO().GetByProductID(productID);
            var productDisplay = new ProductDisplay();
            productDisplay.Product = product;
            productDisplay.ListImage = listImg;
            return productDisplay;
        }

        public List<ProductDisplay> GetListRelateProduct(long? categoryID)
        {
            var listProductDisplay = new List<ProductDisplay>();
            var listProduct = db.Products.Where(x => x.CategoryID == categoryID).Take(6).ToList();
            foreach(var item in listProduct)
            {
                var productDisplay = new ProductDisplay();
                var listImg = new ImageDAO().GetByProductID(item.ID);
                productDisplay.Product = item;
                productDisplay.ListImage = listImg;
                listProductDisplay.Add(productDisplay);
            }
            return listProductDisplay;
        }

        public int Insert(ProductDisplay productDisplay)
        {
            var newProduct = new ProductDAO().Insert(productDisplay.Product);
            if (newProduct > 0)
            {
                var newImage = new ImageDAO().Insert(productDisplay.ListImage, productDisplay.Product.ID);
                if (newImage > 0)
                {
                    return 1;
                }
            }
            return -1;

        }

        public int Update(ProductDisplay productDisplay)
        {
            var resultUpdateProduct = new ProductDAO().Update(productDisplay.Product);
            if (resultUpdateProduct > 0)
            {
                var resultUpdatImage = new ImageDAO().Update(productDisplay.ListImage);
                if (resultUpdatImage > 0)
                {
                    return 1;
                }
            }
            return -1;

        }

        public int Delete(ProductDisplay productDisplay)
        {
            var resultDeleteImage = new ImageDAO().Delete(productDisplay.ListImage);
            if (resultDeleteImage > 0)
            {
                var resultDeleteProduct = new ProductDAO().Delete(productDisplay.Product.ID);
                if (resultDeleteProduct > 0)
                {
                    return 1;
                }
            }
            return -1;

        }
    }
}
