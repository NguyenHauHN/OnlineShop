using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;

namespace Model.ViewModels
{
    public class OrderViewModel
    {
        public long OrderID { get; set; }
        public long ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public long ReceiverID { get; set; }
        public string ReceiverName { get; set; }
        public string ReceiverAddress { get; set; }
        public string ReveiverEmail { get; set; }
        public string ReceiverPhone { get; set; }
        public decimal? ProductPrice { get; set; }
        public int? ProductAmount { get; set; }
        public int? Status { get; set; }
    }
}
