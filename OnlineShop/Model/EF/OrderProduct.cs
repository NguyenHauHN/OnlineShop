namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OrderProduct")]
    public partial class OrderProduct
    {
        public long ID { get; set; }

        public long? OrderID { get; set; }

        [StringLength(250)]
        public string ProductName { get; set; }

        public long? ProductID { get; set; }

        [StringLength(250)]
        public string ImageProduct { get; set; }

        public long? Amount { get; set; }

        public decimal? Price { get; set; }

        public decimal? Sale { get; set; }

        public int? Status { get; set; }

        public decimal? TotalMoney { get; set; }
    }
}
