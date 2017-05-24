using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ViewModels
{
    public class OrderViewModel
    {
        public Order Order { get; set; }
        public List<OrderProduct> ListProduct { get; set; }
        public OrderViewModel()
        {
            ListProduct = new List<OrderProduct>();
        }
    }
}
