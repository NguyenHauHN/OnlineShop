using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.DAO
{
    public class ImageDAO
    {
        OnlineShopDbContext db = null;
        public ImageDAO()
        {
            db = new OnlineShopDbContext();
        }

        public List<ImageProduct> GetByProductID(long productID)
        {
            return db.ImageProducts.Where(x => x.ProductID == productID && x.Status == 1).ToList();
        }

        public int Insert(List<ImageProduct> listImage, long productID)
        {
            foreach (var item in listImage)
            {
                item.Status = 1;
                item.Type = 1;
                item.ProductID = productID;
                db.ImageProducts.Add(item);
            }

            db.SaveChanges();
            return 1;

        }

        public ImageProduct GetMainImgByProductID(int productID)
        {
            return db.ImageProducts.SingleOrDefault(x => x.ProductID == productID && x.Type == 1);
        }

        public int Update(List<ImageProduct> listImage)
        {
            foreach (var item in listImage)
            {
                var img = db.ImageProducts.Find(item.ID);
                img.Src = item.Src;
                db.SaveChanges();
            }
            return 1;
        }

        public int Delete(List<ImageProduct> listImage)
        {
            try
            {
                foreach (var item in listImage)
                {
                    var img = db.ImageProducts.Find(item.ID);
                    db.ImageProducts.Remove(img);
                    
                }
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
