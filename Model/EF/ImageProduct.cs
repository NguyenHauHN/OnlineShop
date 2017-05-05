namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ImageProduct")]
    public partial class ImageProduct
    {
        public long ID { get; set; }

        public long? ProductID { get; set; }

        [StringLength(250)]
        public string Src { get; set; }

        public int? Status { get; set; }

        public int? Type { get; set; }
    }
}
