using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;

namespace Model.ViewModels
{
    public class ProductDisplay
    {
        public Product Product { get; set; }
        public List<ImageProduct> ListImage { get; set; }

        public ProductDisplay()
        {
            ListImage = new List<ImageProduct>();
        }
    }
}
