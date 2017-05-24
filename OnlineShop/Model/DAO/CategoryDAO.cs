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
    public class CategoryDAO
    {
        OnlineShopDbContext db = null;
        public CategoryDAO()
        {
            db = new OnlineShopDbContext();
        }

        public IEnumerable<Category> ListAll(string keyword, ref int totalCategory, int page = 1, int pageSize = 10)
        {
            IQueryable<Category> model = db.Categories;
            if (!string.IsNullOrEmpty(keyword))
            {
                model = model.Where(x => x.Description.Contains(keyword) || x.Name.Contains(keyword));
            }
            return model.OrderBy(x => x.DisplayOrder).ToPagedList(page, pageSize);
        }

        public List<Category> GetList()
        {
            return db.Categories.Where(x => x.Status == 1).ToList();
        }

        public List<Category> ListCategoryMen()
        {
            return db.Categories.Where(x => x.Type == 1 && x.Status == 1).OrderBy(x => x.DisplayOrder).Take(3).ToList();
        }

        public List<Category> ListCategoryWomen()
        {
            return db.Categories.Where(x => x.Type == 2 && x.Status == 1).OrderBy(x => x.DisplayOrder).Take(3).ToList();
        }
        public List<Category> ListCategoryKid()
        {
            return db.Categories.Where(x => x.Type == 3 && x.Status == 1).OrderBy(x => x.DisplayOrder).Take(3).ToList();
        }

        public List<Category> GetListAll()
        {
            return db.Categories.Where(x => x.ParentID == null).ToList();
        }

        public Category GetByID(long? ID)
        {
            return db.Categories.Find(ID);
        }

        public int Insert(Category category)
        {
            var categoryTemp = db.Categories.SingleOrDefault(x => x.Name == category.Name);
            if (categoryTemp != null)
            {
                return -1;
            }
            else
            {
                category.CreateDate = DateTime.Now;
                db.Categories.Add(category);
                db.SaveChanges();
                return 1;
            }
        }

        public int Update(Category category)
        {
            try
            {
                var categoryTemp = db.Categories.Find(category.ID);
                categoryTemp.Name = category.Name;
                categoryTemp.MetaTitle = category.MetaTitle;
                //categoryTemp.ParentID = category.ParentID;
                categoryTemp.Description = category.Description;
                categoryTemp.DisplayOrder = category.DisplayOrder;
                categoryTemp.Tag = category.Tag;
                categoryTemp.Status = category.Status;
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Delete(int ID)
        {
            try
            {
                var result = new ProductDAO().UpdateCategoryID(ID);
                if(result > 0)
                {
                    var category = db.Categories.Find(ID);
                    db.Categories.Remove(category);
                    db.SaveChanges();
                    return 1;
                }
                else
                {
                    return -2;
                }
                
            }
            catch (Exception e)
            {
                return -1;
            }

        }
    }
}
