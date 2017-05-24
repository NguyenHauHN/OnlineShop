var urlCurrent = window.location.href;
console.log(urlCurrent);
$("li.treeview a").each(function () {
    console.log($(this).attr('href'));
    if (urlCurrent.includes($(this).attr('href'))) {
        $(this).parent().addClass('active');
    }
    else {
        $(this).parent().removeClass('active');
    }
});
