var product = {
    init: function () {
        product.registerEvents();
        product.uploadAvatarAdmin();
        product.uploadMainImageProduct();
    },
    registerEvents: function () {
        var listImageGallery = [];
        $('#btnUploadGallery').off('click').on('click', function () {
            $('#uploadGalleryImage').modal('show');
        });
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
                        $('#image-list').append("<div class='pull-left wrap-gallery-image'><img class='img-responsive' src='" + fileName + "'/><button type='button' class='btn btn-social-icon btn-twitter delete-image'><i class='fa fa-times'></i></button></div>");
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
                        //id: $('#hideInputProduct').val(),
                        images: JSON.stringify(listImageGallery)
                    },
                    dataType: 'json',
                    success: function (response) {
                        if (response.status == true) {
                            alert('Thêm ảnh mô tả cho sản phẩm thành công!');
                        }
                        else {
                            alert('Thêm ảnh mô tả cho sản phẩm không thành công!');
                        }
                        
                    },
                    error: function (err) {

                    }
                });
            }
        });
    },
    uploadAvatarAdmin: function(){
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
    uploadMainImageProduct: function () {
        $("#imageUploadProduct").change(function () {
            if ($(this).val().length > 0) {

                var fileName = "";
                var data = new FormData();
                var files = $("#imageUploadProduct").get(0).files;

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
                        $('.avatar').attr('src', fileName);
                        $('#saveMainImageProduct').val(fileName);
                        $('#saveMainImage').val(fileName);
                    },
                    error: function () {
                        alert('Upload ảnh không thành công!');
                    }
                });

            }
        });
    }
}
product.init();