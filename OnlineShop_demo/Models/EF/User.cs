namespace Models.EF
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

        [StringLength(50)]
        [Display(Name = "Tên đăng nhập")]
        [Required(ErrorMessage ="Bạn không được để trống trường này!")]
        public string Username { get; set; }

        [StringLength(32)]
        [Display(Name = "Mật khẩu")]
        [Required(ErrorMessage = "Bạn không được để trống trường này!")]
        public string Password { get; set; }

        [StringLength(50)]
        [Display(Name = "Họ tên")]
        [Required(ErrorMessage = "Bạn không được để trống trường này!")]
        public string Name { get; set; }

        [StringLength(50)]
        [Display(Name = "Địa chỉ")]
        public string Address { get; set; }

        [StringLength(50)]
        [Display(Name = "Email")]
        [Required(ErrorMessage = "Bạn không được để trống trường này!")]
        public string Email { get; set; }

        [StringLength(50)]
        [Display(Name = "Số điện thoại")]
        public string Phone { get; set; }

        public DateTime? CreateDate { get; set; }

        [StringLength(50)]
        public string CreateBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        [StringLength(50)]
        public string ModifiedBy { get; set; }

        [Display(Name = "Trạng thái tài khoản")]
        public bool Status { get; set; }
    }
}
