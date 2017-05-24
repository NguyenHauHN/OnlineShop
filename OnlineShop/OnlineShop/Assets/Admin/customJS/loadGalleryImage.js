var product = {
    init: function () {
        product.loadGalleryImage();
    },
    loadGalleryImage: function () {
        $.ajax({
            url: "/Admin/Product/LoadGalleryImage",
            type: "GET",
            data: {
                id: $('#hideInputProduct').val()
            },
            dataType: 'json',
            success: function (response) {
                var data = response.data;
                var html = '';
                $.each(data, function (idx, item) {
                    html += "<div class='pull-left wrap-gallery-image'><img src='" + item + "' class='img-responsive' /><button type='button' class='btn btn-social-icon btn-twitter delete-image'><i class='fa fa-times'></i></button></div>";
                });
                $('#image-list').html(html);
                $('.wrap-gallery-image .delete-image').off('click').on('click', function (e) {
                    e.preventDefault();
                    $(this).parent().remove();
                });
            },
            error: function (err) {

            }
        });

    }
}
product.init();