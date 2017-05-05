$(document).ready(function () {
    $('ul.sidebar-menu li a').click(function(){
        $('li a').removeClass("active");
        $(this).parent().addClass("active");
    }
    
});