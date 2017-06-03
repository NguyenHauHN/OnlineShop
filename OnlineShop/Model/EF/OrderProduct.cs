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

        public long OrderID { get; set; }

        public long? ProductID { get; set; }

        public long? Amount { get; set; }

        public int? Status { get; set; }

        public decimal? TotalMoney { get; set; }
    }
}
