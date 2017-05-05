namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        public long ID { get; set; }

        [Required]
        [StringLength(250)]
        public string Name { get; set; }

        [Required]
        [StringLength(50)]
        public string Code { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(300)]
        public string Description { get; set; }

        public decimal? Price { get; set; }

        public decimal? Sale { get; set; }

        public DateTime? CreateDate { get; set; }

        public long? CreateBy { get; set; }

        [StringLength(250)]
        public string Tag { get; set; }

        public int? Status { get; set; }

        public int? Type { get; set; }

        public DateTime? LastChange { get; set; }

        public long? ChangeBy { get; set; }

        public long? CategoryID { get; set; }
    }
}
