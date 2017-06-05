jQuery(function ($) {
    var contact = {
        init: function () {
            contact.sendEmail();
        },
        sendEmail: function () {
            $('#submit-contact').on('click', function () {
                var name = $('#your-name').val();
                var email = $('#your-email').val();
                var content = $('#your-message').val();
                if (name.length <= 0 || email.length <= 0 || content.length <= 0) {

                }
                else {
                    $.post("/Contact/SendContact",
                    {
                        Name: name,
                        Email: email,
                        Content: content
                    },
                    function (data, status, xhr) {
                        if (data.status == true) {
                            $('#feedback').removeClass('hide');
                        }
                        else {
                            alert('Có thể email của bạn không tồn tại, bạn vui lòng kiểm tra lại!');
                        }
                    }
                    )
                }
            });
        }
    }
    contact.init();
});