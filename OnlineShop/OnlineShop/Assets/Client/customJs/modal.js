jQuery(function ($) {
    var modal = {
        init: function () {
            modal.getInfo();
            modal.modalRegister();
            modal.modalLogin();
        },
        getInfo: function(){
            var value = $('#save-login').val();
            if (value.length > 0) {
                $('#btn-login').addClass('hide');
                $('#btn-register').addClass('hide');
                $('#dash').addClass('hide');
                $('#btn-logout').removeClass('hide');
            }
        },
        modalRegister: function () {
            $('#btn-register').off('click').on('click', function (e) {
                e.preventDefault();
                $('#modal-register').modal('show');
            });
            $('#btn-register-client').off('click').on('click', function () {
                $.post("/Client/Register", 
                {
                    Name: $('#name-register').val(),
                    Username: $('#username-register').val(),
                    Password: $('#password-register').val(),
                    ConfirmPassword: $('#confirm-password-register').val(),
                    Email: $('#email-register').val(),
                    PhoneNumber: $('#phone-number-register').val()
                },
                function (data, status, xhr) {
                    if (data.check == true) {
                        if (data.confirm == true) {
                            if (data.Status == true) {
                                $('#notify-message-register').addClass('hide');
                                $('#success-message-register').removeClass('hide').text('Đăng ký tài khoản mới thành công!');
                                $('#link-login').removeClass('hide');
                            }
                            else {
                                $('#success-message-register').addClass('hide');
                                $('#notify-message-register').removeClass('hide').text('Tên đăng nhập đã đươc sử dụng!');
                            }
                        }
                        else {
                            $('#success-message-register').addClass('hide');
                            $('#notify-message-register').removeClass('hide').text('Xác nhận mật khẩu sai!');
                        }
                    }
                    else {
                        $('#success-message-register').addClass('hide');
                        $('#notify-message-register').removeClass('hide').text('Bạn không được bỏ trống bất kỳ trường nào!');
                    }
                });
            });
            $('#link-login').off('click').on('click', function (e) {
                e.preventDefault();
                $.post("/Client/Login",
                {
                    Username: $('#username-register').val(),
                    Password: $('#password-register').val(),
                    RememberMe: $('#remember-me').val()
                },
                function (data, status, xhr) {
                    if (data.status == true) {
                        if (data.Result == 1) {
                            $('#modal-register').modal('hide');
                            $('#btn-login').addClass('hide');
                            $('#btn-register').addClass('hide');
                            $('#dash').addClass('hide');
                            $('#btn-logout').removeClass('hide');
                        }
                        else {

                        }
                    }
                    else {
                       
                    }
                });
            });
        },
        modalLogin: function () {
            $('#btn-login').off('click').on('click', function (e) {
                e.preventDefault();
                $('#modal-login').modal('show');
            });
            $('#btn-login-client').off('click').on('click', function () {
                $.post("/Client/Login",
                {
                    Username: $('#username-login').val(),
                    Password: $('#password-login').val(),
                    RememberMe: $('#remember-me').val()
                },
                function (data, status, xhr) {
                    if (data.status == true) {
                        if (data.Result == 1) {
                            $('#modal-login').modal('hide');
                            $('#btn-login').addClass('hide');
                            $('#btn-register').addClass('hide');
                            $('#dash').addClass('hide');
                            $('#btn-logout').removeClass('hide');
                            location.reload();
                        }
                        else {
                            
                        }
                    }
                    else {
                        if (data.Result == -2) {
                            $('#notify-message').removeClass('hide').text('Tên đăng nhập hoặc mật khẩu không chính xác!');
                        }
                        else if (data.Result == -1) {
                            $('#notify-message').removeClass('hide').text('Tài khoản đang bị khóa!');
                        }
                    }
                });
            });
        }
    };
    modal.init();
});