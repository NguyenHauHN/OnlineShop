using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ViewModels
{
    public class OrderProductViewModel
    {
        public long ID { get; set; }
        public string ProductName { get; set; }
        public string MainImage { get; set; }
        public double Price { get; set; }
        public double Sale { get; set; }
        public long? Amount { get; set; }
        public double? TotalMoney { get; set; }
        public DateTime? CreatDate { get; set; }
    }
}
