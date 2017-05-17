var product = {
    init: function () {
        product.loadImage();
        product.registerEvents();
        product.uploadSingleImage();
    },
    registerEvents: function () {
        var listImageGallery = [];
        $("#inputUploadGallery").change(function () {
            if ($(this).val().length > 0) {

                var fileName = "";
                var data = new FormData();
                var files = $("#inputUploadGallery").get(0).files;

                if (files.length > 0) { data.append("HelpSectionImages", files[0]); }
                $.ajax({
                    url: "/Admin/Product/UploadImage/",
                    type: "POST",
                    processData: false,
                    data: data,
                    dataType: "json",
                    contentType: false,
                    success: function (srcImage) {
                        fileName = srcImage.name;
                        listImageGallery.push(fileName);
                        $('#image-list').append("<div class='pull-left wrap-gallery-image'><img src='" + fileName + "' style='width: 100px;' /><a href='#' class='delete-image'><i class='fa fa-times'></i></a></div>");
                        $('.wrap-gallery-image .delete-image').off('click').on('click', function (e) {
                            e.preventDefault();
                            $(this).parent().remove();
                        });
                    },
                    error: function () {
                        alert('error');
                    }
                });

            }
        });
        $('#btn-save-image').off('click').on('click', function () {
            if (listImageGallery.length > 0) {
                $.ajax({
                    url: "/Admin/Product/SaveGalleryImage",
                    type: "POST",
                    data: {
                        id: $('#hideInputProduct').val(),
                        images: JSON.stringify(listImageGallery)
                    },
                    dataType: 'json',
                    success: function (response) {
                        alert('Thêm ảnh mô tả cho sản phẩm thành công!');
                    },
                    error: function (err) {

                    }
                });
            }
        });
    },
    uploadSingleImage: function(){
        $("#singleImageUpload").change(function () {
            if ($(this).val().length > 0) {

                var fileName = "";
                var data = new FormData();
                var files = $("#singleImageUpload").get(0).files;

                if (files.length > 0) { data.append("HelpSectionImages", files[0]); }
                $.ajax({
                    url: "/Admin/AdminManage/UploadSingleImage/",
                    type: "POST",
                    processData: false,
                    data: data,
                    dataType: "json",
                    contentType: false,
                    success: function (srcImage) {
                        fileName = srcImage.name;
                        $('.avatar').attr('src', fileName);
                        $('#saveSrcAvatar').val(fileName);
                    },
                    error: function () {
                        alert('error');
                    }
                });

            }
        });
    },
    loadImage: function () {
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
                    html += "<div class='pull-left wrap-gallery-image'><img src='" + item + "' style='width: 100px;' /><a href='#' class='delete-image'><i class='fa fa-times'></i></a></div>";
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