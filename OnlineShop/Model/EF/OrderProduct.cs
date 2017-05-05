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
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long ProductID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long ReceiverID { get; set; }

        public int? Amount { get; set; }

        public decimal? Price { get; set; }

        public int? Status { get; set; }

        public DateTime? CreateDate { get; set; }

        public long? CreateBy { get; set; }

        public DateTime? LastChange { get; set; }

        public long? ChangeBy { get; set; }

        [Key]
        [Column(Order = 9)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public long OrderID { get; set; }
    }
}
