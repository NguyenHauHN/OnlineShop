namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Category")]
    public partial class Category
    {
        public long ID { get; set; }

        [StringLength(250)]
        public string Name { get; set; }

        public long? ParentID { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        public int? DisplayOrder { get; set; }

        public DateTime? CreateDate { get; set; }

        public long? CreateBy { get; set; }

        [StringLength(300)]
        public string Description { get; set; }

        [StringLength(250)]
        public string Tag { get; set; }

        public int? Status { get; set; }

        public int? Type { get; set; }
    }
}
