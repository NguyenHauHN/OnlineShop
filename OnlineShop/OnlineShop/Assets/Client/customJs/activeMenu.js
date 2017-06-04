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
        
        if (urlCurrent.includes('Category')) {
            $("li.menu-item").eq(1).addClass('current-menu-ancestor');
            check = true;
        }
        if (urlCurrent == 'http://localhost:64109/') {
            $("li.menu-item").eq(0).addClass('current-menu-ancestor');
        }

    });
   
    

});