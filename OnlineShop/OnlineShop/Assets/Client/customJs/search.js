jQuery(function ($) {
    $('#input-search').keyup(function (e) {
        $('.search-header-result ul').empty();
        if ($(this).val().length > 0) {
             $.get("/Product/SearchProduct",
                 {
                     Keyword: $('#input-search').val()
                 },
                 function (data, status, xhr) {
                     console.log(data);
                     var listResult = data.ListData;
                     $.each(listResult, function (idx, item) {
                         var liItem = "<li class='selected'><a href='/san-pham/" + item.MetaTitle +"/"+item.ID+ "'>"
                                        + "<img width='150' height='150' src='" + item.MainImage + "' class='attachment-thumbnail wp-post-image' alt='" + item.Name + "'>" + item.Name + "</a>"
                                        + "<div class='price'><span class='amount'>$"+ item.Price+"</span></div>"
                                        + "</li>";
                         $('.search-header-result').removeClass('hide');
                         $(liItem).appendTo('.search-header-result ul');
                     });
                 });
         }
   });
});