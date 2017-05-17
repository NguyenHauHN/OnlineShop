using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ViewModels
{
    public class ProductViewModel
    {
        public List<Product> Product { get; set; }
        public long Amount { get; set; }

        public ProductViewModel()
        {
            Product = new List<Product>();
        }
    }
}
