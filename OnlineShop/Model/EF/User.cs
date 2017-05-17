namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("User")]
    public partial class User
    {
        public long ID { get; set; }

        [StringLength(250)]
        public string Name { get; set; }

        [StringLength(250)]
        public string Username { get; set; }

        [StringLength(50)]
        public string Password { get; set; }

        public int? Gender { get; set; }

        [StringLength(250)]
        public string Address { get; set; }

        public DateTime? JoinDate { get; set; }

        [StringLength(50)]
        public string Phone { get; set; }

        [StringLength(250)]
        public string Email { get; set; }

        public int? Status { get; set; }

        public int? Type { get; set; }

        [StringLength(250)]
        public string Avatar { get; set; }

        public DateTime? RecentChange { get; set; }
    }
}
