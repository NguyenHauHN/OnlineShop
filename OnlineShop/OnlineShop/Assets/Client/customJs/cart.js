jQuery(function ($) {
    var cart = {
        init: function () {
            cart.initCart();
            cart.addToCart();
            cart.removeItemCart();
            cart.changeAmountProduct();
            cart.updateCart();
            cart.changeBtnCart();
        },
        initCart: function () {
            console.log('init');
            var listItemCart = [];
            $.get("/HomeClient/GetProductCart",
                {

                },
                function (data, status, xhr) {
                    console.log(data);
                    listItemCart = data.listItem;
                    if (listItemCart != null) {
                        $.each(listItemCart, function (idx, item) {
                            cart.changeBtnCart(item.Product.ID);
                        });
                    }
                    
                });
        },
        changeBtnCart: function (productID) {
            var imgLoader = '#loader-' + productID;
            var viewCart = '#view-cart-' + productID;
            var btn = '#btn-add-to-cart-' + productID;
            $(imgLoader).removeClass('display-block').addClass('hide');
            $(btn).removeClass('display-block').addClass('hide');
            $(viewCart).removeClass('hide').addClass('display-block');

            // for block sale off
            var imgLoaderSale = '.sale-off #loader-' + productID;
            var viewCartSale = '.sale-off #view-cart-' + productID;
            var btnSale = '.sale-off #btn-add-to-cart-' + productID;

            $(imgLoaderSale).removeClass('display-block').addClass('hide');
            $(btnSale).removeClass('display-block').addClass('hide');
            $(viewCartSale).removeClass('hide').addClass('display-block');

            // for block type product
            var btnIcon = '.wrap-btn-icon #btn-icon-' + productID;
            $(btnIcon).removeClass('rotate').addClass('hide');
            var btnViewCartIcon = '.wrap-btn-icon #view-cart-' + productID;
            $(btnViewCartIcon).removeClass('hide').addClass('display-block');
           
        },
        addToCart: function () {
            $('.btn-add-to-cart').off('click').on('click', function () {
                $(this).find('img.loader-add-to-cart').removeClass('hide').addClass('display-block');
                var parent = $(this).parent();
                if ($(parent).hasClass('wrap-btn-icon')) {
                    $(this).addClass('rotate');
                }
                var productID = $(this).data("id");
                var amount = 1;
                if ($(parent).hasClass('cart')) {
                    amount = $(parent).find('input').val();
                    console.log('amount:' + amount);
                }
                else {
                    amount = $(this).data("amount");
                }
                $.post("/Cart/AddToCart",
                {
                    productID: productID,
                    amount: amount
                },
                function (data, status, xhr) {
                    cart.changeBtnCart(data.productID);
                    $.get("/HomeClient/Header",
                        {
                        },
                        function (data, status, xhr) {
                            $('.shopping-cart-wrapper').html($(data).find('.shopping-cart-wrapper').html());
                        }
                    )
                  
                });
            });
        },
        removeItemCart: function () {
            $('.remove-item-cart').off('click').on('click', function (e) {
                e.preventDefault();
                $.post("/Cart/Delete",
                    {
                        id: $(this).data("id")
                    },
                    function (data, status, xhr) {
                        if (data.status == true) {
                            var tr = 'tr#item-cart-' + data.productID;
                            var li = 'li#item-cart-' + data.productID;
                            if (data.amount <= 0) {
                                $('p.cart-empty-second').css('display', 'block');
                                $('table.shop_table').css('display', 'none');
                                $('.cart-subtotal span.amount').text(0.00);
                                $('.order-total span.amount').text(0.00);
                            }
                            $(tr).css('display', 'none');
                            $(li).css('display', 'none');
                            $.get("/HomeClient/Header",
                         {
                         },
                         function (data, status, xhr) {
                             $('.shopping-cart-wrapper').html($(data).find('.shopping-cart-wrapper').html());
                         }
                     )
                        }
                    }
                )
            });
        },
        changeAmountProduct: function () {
            $('.btn-plus').on('click', function () {
                var valInput = parseInt($(this).parent().find('input').val(), 10) + 1;

                // for list item in cart
                var trParent = $(this).closest('tr');
                var price = parseInt(trParent.find('.product-price').find('span.amount').text(), 10);
                var sale = parseInt(trParent.find('.product-sale').find('span.amount').text(), 10);
                var totalMoney = ((price * (100 - sale) / 100) * valInput).toFixed(2);
                trParent.find('.product-subtotal span.money').text(totalMoney);
                var totalMoneyCart = parseInt($('.cart-subtotal span.amount').text(), 10) + price * (100 - sale) / 100;
                $('.cart-subtotal span.amount').text(totalMoneyCart.toFixed(2));
                var paymentMoneyCart = totalMoneyCart + 9;
                $('.order-total span.amount').text(paymentMoneyCart.toFixed(2));
            });
            $('.btn-minus').on('click', function () {
                var valInput = parseInt($(this).parent().find('input').val(), 10) - 1;
                var trParent = $(this).closest('tr');
                var price = parseInt(trParent.find('.product-price').find('span.amount').text(), 10);
                var sale = parseInt(trParent.find('.product-sale').find('span.amount').text(), 10);
                var totalMoney = ((price * (100 - sale) / 100) * valInput).toFixed(2);
                trParent.find('.product-subtotal span.money').text(totalMoney);
                var totalMoneyCart = parseInt($('.cart-subtotal span.amount').text(), 10) - price * (100 - sale) / 100;
                $('.cart-subtotal span.amount').text(totalMoneyCart.toFixed(2));
                var paymentMoneyCart = totalMoneyCart + 9;
                $('.order-total span.amount').text(paymentMoneyCart.toFixed(2));
            });
        },
        updateCart: function () {
            $('#btn-update-cart').on('click', function () {
                var listItem = $('td.product-quantity input');
                var listProductCart = [];
                $.each(listItem, function (idx, item) {
                    listProductCart.push({
                        Amount: $(item).val(),
                        Product: {
                            ID: $(item).data('id')
                        }
                    });
                });
                $.post("/Cart/Update",
                {
                    cardModel: JSON.stringify(listProductCart)
                },
                function (data, status, xhr) {
                    if (data.status == true) {
                        window.location.href = "/gio-hang";
                    }
                });
            });
        }

    }
    cart.init();
});