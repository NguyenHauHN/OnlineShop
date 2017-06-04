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
                $.get("/Category/Index", {
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
            $('#searchProduct').keyup(function (e) {
                    $.get("/Category/Index", {
                        ID: $('#categoryID').val(),
                        valueselectsort: $(this).val(),
                        searchProduct: $(this).val(),
                        page: 1
                    },
                    function (data, status, xhr) {
                        $('.product-wrapper').html($(data).find('.product-wrapper').html());
                    }
                )
            });
        },
        filterProductByPrice: function () {
            $('#filterPrice').off('click').on('click', function () {
                $.post("/Category/Index", {
                    ID: $('#categoryID').val(),
                    valueselectsort: $(this).val(),
                    searchProduct: $(this).val(),
                    minPrice: $('#min_price').val(),
                    maxPrice: $('#max_price').val()
                },
                    function (data, status, xhr) {
                        
                        $('.product-listing').html($(data).find('.product-listing').html());
                    }
                )

            });
        }
    };
    product.init();
});
