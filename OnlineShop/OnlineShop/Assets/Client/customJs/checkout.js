jQuery(function ($) {
    var checkout = {
        init: function () {
            checkout.checkLogin();
            checkout.placeOrder();
            
        },
        checkLogin:function(){
            $(document).on('click','.btn-checkout', function () {
                var account = $('#save-login').val();
                console.log(account);
                if (account.length > 0) {
                    window.location.href = '/Checkout/Index';
                }
                else {
                    confirm("Bạn chưa đăng nhập, hãy đăng nhập để thanh toán sản phẩm!");
                }
            });
        },
        placeOrder: function () {
            $('#place-order').off('click').on('click', function (e) {
                e.preventDefault();
                var customerInfo = $('#save-account').val();
                var orderAddress = $('#order-address').val();
                var note = $('#order-note').val();
                if (orderAddress.length > 0) {
                    $.post("/Checkout/PlaceOrder",
                    {
                        Username: customerInfo,
                        AddressOrder: orderAddress,
                        Note: note
                    },
                    function (data, status, xhr) {
                        console.log(data);
                        if (data.status == true) {
                            window.location.href = '/Checkout/PlaceSuccess';
                        }
                        else {
                            confirm("Xảy ra lỗi từ hệ thống, đơn hàng của bạn chưa được ghi nhận, chúng tôi sẽ liên lạc lại với bạn ngay khi có thể! Mong bạn thông cảm");
                        }
                    }
                )
                }
                else {
                    $('#notify-msg').text("Bạn vui lòng nhập đầy đủ địa chỉ giao hàng để tránh đơn hàng bị hủy!");
                }
                
            });
        }
    };
    checkout.init();
});