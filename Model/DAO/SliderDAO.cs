using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.DAO
{
    public class SliderDAO
    {
        OnlineShopDbContext db = null;
        public SliderDAO()
        {
            db = new OnlineShopDbContext();
        }

        public IEnumerable<Slide> ListAllSlider(string keyword, ref int totalSlider, int page = 1, int pageSize = 10)
        {
            IQueryable<Slide> model = db.Slides;
            if (!string.IsNullOrEmpty(keyword))
            {
                model = model.Where(x => x.Description.Contains(keyword) || x.Title.Contains(keyword));
            }
            totalSlider = model.Count();
            return model.OrderBy(x => x.DisplayOrder).ToPagedList(page, pageSize);
        }

        public Slide GetByID(int ID)
        {
            return db.Slides.Find(ID);
        }

        public int Insert(Slide slide)
        {
           try
            {
                db.Slides.Add(slide);
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Update(Slide slide)
        {
            try
            {
                var slideTemp = db.Slides.Find(slide.ID);
                slideTemp.Image = slide.Image;
                slideTemp.Description = slide.Description;
                slideTemp.DisplayOrder = slide.DisplayOrder;
                slideTemp.Status = slide.Status;
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
                var slide = db.Slides.Find(ID);
                db.Slides.Remove(slide);
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
