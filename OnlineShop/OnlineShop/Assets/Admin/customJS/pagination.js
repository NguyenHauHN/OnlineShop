var pagination = {
    init: function () {
        pagination.changePage();
    },
    changePage: function () {
        $('.page-link').off('click').on('click', function (e) {
            e.preventDefault();
            $('#curr-page').val($(this).data('page'));
            $.get("/Admin/AdminManage/Index",
                {
                    page: $(this).data('page'),
                    pageSize: 1,
                    keyword: $('#txtSearch').val()
                },
                function (data, status, xhr) {
                    $('.list-admin').html($(data).find('.list-admin').html());
                    $("a.page-link").each(function () {
                        $(this).parent().removeClass('active');
                    });
                    var idLinkPage = '#page-link-' + $('#curr-page').val();
                    $(idLinkPage).parent().addClass('active');
                }
            )
        });
    }
};
pagination.init();