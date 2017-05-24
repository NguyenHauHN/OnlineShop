jQuery(function ($) {
    var urlCurrent = window.location.href;
    var check = false;
    $("li.menu-item").each(function () {
        if (urlCurrent.includes($(this).find('a').attr('href'))) {
            $(this).addClass('current-menu-ancestor');
            check = true;
        }
        else {
            $(this).removeClass('current-menu-ancestor');
        }
        if (urlCurrent.includes('danh-muc')) {
            $("li.menu-item").eq(1).addClass('current-menu-ancestor');
            check = true;
        }

        
    });
    if (check == false) {
        $("li.menu-item").eq(0).addClass('current-menu-ancestor');
    }
});