var deleteItem = {
    init: function () {
        deleteItem.deleteAdmin();
    },
    deleteAdmin: function () {
        $('.btn-delete').on('click', function () {
            var name = $(this).data('name');

            var confirm = confirm("Bạn chắc chắn muốn xóa quản trị viên " + name + "!");
            if (confirm == true) {
                $.post("Admin/AdminManage/Delete",
                    {
                        ID: $(this).data('id')
                    },
                    function (data, status, xhr) {
                        alert(ok);
                        //$('.list-admin').html($(data).find('.list-admin').html());
                        location.reload();
                    }
                )
            }
        });
    }
};
deleteItem.init();