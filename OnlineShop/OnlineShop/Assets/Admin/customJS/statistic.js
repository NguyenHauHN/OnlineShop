jQuery(function ($) {
    var chart = {
        init: function () {
            chart.datetimepickerSelect();
            chart.statistic();
        },
        datetimepickerSelect: function () {
            $('#start-date').datepicker({
                autoClose: true
            });
            $('#end-date').datepicker({
                autoClose: true
            });
        },
        statistic: function () {
            $('#statistic').on('click', function () {
                var start = new Date($("#start-date").datepicker("getDate"));
                var end = new Date($("#end-date").datepicker("getDate"));
                var compare = (end - start) / (86400000 * 7);
                if (compare > 0) {
                    $.get("/Admin/Statistic/StatisticOrder",
                    {
                        startDate: (start.getMonth() + 1) + "/" + start.getDate() + "/" + start.getFullYear(),
                        endDate: (end.getMonth() + 1) + "/" + end.getDate() + "/" + end.getFullYear()
                    },
                    function (data, status, xhr) {
                        var listDisplay = [];
                        var listData = data.result;
                        if (listData && listData.length > 0) {
                            listData.forEach(function (item, idx) {
                                var object = {
                                    y: item.Date,
                                    a: item.AmountProduct,
                                    b: item.AmountOrder
                                };
                                listDisplay.push(object);
                            });
                        }
                        if (listDisplay && listDisplay.length > 0) {
                            $('#msg-statistic').addClass('hide');
                            Morris.Bar({
                                element: 'bar-example',
                                data: listDisplay,
                                hoverCallback: function (index, options, content) {
                                    return (content);
                                },
                                xkey: 'y',
                                ykeys: ['a', 'b'],
                                labels: ['Số sản phẩm', 'Số đơn hàng']
                            });
                        }
                        else {
                            $('#msg-statistic').removeClass('hide');
                        }

                    });
                }
                else {
                    alert("Bạn phải nhập ngày bắt đầu nhỏ hơn ngày kết thúc!");
                }
                
            });
        }
    };
    chart.init();
});



