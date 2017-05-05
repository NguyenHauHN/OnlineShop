$(document).ready(function () {
    console.log(1);
    var card = {
        init: function () {
            card.regEvents();
        },
        regEvents: function () {
            $('#btnContinue').off('click').on('click', function () {
                window.location.href = "/";
            });
            $('#btn-payment').off('click').on('click', function () {
                window.location.href = "/thanh-toan";
            });
            $('#btnUpdate').off('click').on('click', function () {
                var listProduct = $('.txtQuantity');
                var cardList = [];
                $.each(listProduct, function (i, item) {
                    cardList.push({
                        Quantity: $(item).val(),
                        Product: {
                            ID: $(item).data('id')
                        }
                    });
                });
                $.ajax({
                    url: '/Cart/Update',
                    data: { cardModel: JSON.stringify(cardList) },
                    dataType: 'json',
                    type: 'POST',
                    success: function (data) {
                        if (data.status == true) {
                            window.location.href = "/gio-hang";
                        }

                    }
                })
            });
            $('#btnDeleteAll').off('click').on('click', function () {

                $.ajax({
                    url: '/Cart/DeleteAll',
                    dataType: 'json',
                    type: 'POST',
                    success: function (data) {
                        if (data.status == true) {
                            window.location.href = "/gio-hang";
                        }

                    }
                })
            });
            $('.btn-delete').off('click').on('click', function () {

                $.ajax({
                    data: { id: $(this).data('id') },
                    url: '/Cart/Delete',
                    dataType: 'json',
                    type: 'POST',
                    success: function (data) {
                        if (data.status == true) {
                            window.location.href = "/gio-hang";
                        }

                    }
                })
            });
        }
    }
    card.init();
});