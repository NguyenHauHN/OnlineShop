jQuery(function ($) {
    $('#sortProduct').val();
    var product = {
        init: function () {
            product.changeSortProduct();
            product.searchProduct();
            product.filterProductByPrice();

        },
        changeSortProduct: function () {
            $('#sortProduct').off('change').on('change', function () {
                $.get("/Category/ListProduct", {
                    ID: $('#categoryID').val(),
                    valueselectsort: $(this).val()
                },
                    function (data, status, xhr) {
                        $('.product-listing').html($(data).find('.product-listing').html());
                    }
                )
            });

        },
        searchProduct: function () {
            $('#searchProduct').keypress(function (e) {
                if (e.which == 13) {
                    console.log($(this).val());
                    $.get("/Category/ListProduct", {
                        ID: $('#categoryID').val(),
                        valueselectsort: $(this).val(),
                        searchProduct: $(this).val()
                    },
                    function (data, status, xhr) {
                        $('.product-listing').html(data.list);
                    }
                )
                }
            });
        },
        filterProductByPrice: function () {
            $('#filterPrice').off('click').on('click', function () {
                $.post("/Category/ListProduct", {
                    ID: $('#categoryID').val(),
                    valueselectsort: $(this).val(),
                    searchProduct: $(this).val(),
                    minPrice: $('#min_price').val(),
                    maxPrice: $('#max_price').val()
                },
                    function (data, status, xhr) {
                        alert('ok');
                        $('.product-listing').html($(data).find('.product-listing').html());
                    }
                )

            });
        }
    };
    product.init();
});
