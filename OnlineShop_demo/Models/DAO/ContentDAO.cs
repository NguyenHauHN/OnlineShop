using Models.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.DAO
{
    public class ContentDAO
    {
        OnlineShopDbContext db = null;
        public ContentDAO()
        {
            db = new OnlineShopDbContext();
        }

        public Content GetById(long id)
        {
            return db.Contents.Find(id);
        }
    }
}
