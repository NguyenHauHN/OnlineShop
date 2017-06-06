using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.DAO
{
    public class ProductDAO
    {
        DemoDbContext db = null;
        public ProductDAO()
        {
            db = new DemoDbContext();
        }
        //public List<>
    }
}
