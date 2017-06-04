var deleteItem = {
    init: function () {
        deleteItem.deleteAdmin();
        deleteItem.deleteProduct();
        deleteItem.deleteCustomer();
    },
    deleteAdmin: function () {
        $(document).on('click','.btn-delete', function () {
            var name = $(this).data('name');
            var a = confirm("Bạn chắc chắn muốn xóa quản trị viên " + name + "!");
            if (a == true) {
                $.post("/Admin/AdminManage/Delete",
                    {
                        ID: $(this).data('id')
                    },
                    function (data, status, xhr) {
                        location.reload();
                    }
                )
            }
        });
    },
    deleteProduct: function () {
        $(document).on('click', '.btn-delete-product', function () {
            var name = $(this).data('name');
            var a = confirm("Bạn chắc chắn muốn xóa sản phẩm " + name + "!");
            if (a == true) {
                $.post("/Admin/Product/Delete",
                    {
                        ID: $(this).data('id')
                    },
                    function (data, status, xhr) {
                        location.reload();
                    }
                )
            }
        });
    },
    deleteCustomer: function () {
        $(document).on('click', '.btn-delete-customer', function () {
            var name = $(this).data('name');
            var a = confirm("Bạn chắc chắn muốn xóa khách hàng " + name + "!");
            if (a == true) {
                $.post("/Admin/Customer/Delete",
                    {
                        ID: $(this).data('id')
                    },
                    function (data, status, xhr) {
                        location.reload();
                    }
                )
            }
        });
    }

};
deleteItem.init();
