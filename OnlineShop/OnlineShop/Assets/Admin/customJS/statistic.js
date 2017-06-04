jQuery(function ($) {
    var chart = {
        init: function () {
            chart.datetimepickerSelect();
        },
        datetimepickerSelect: function () {
            $('#start-date').datetimepicker();
            $('#end-date').datetimepicker();
        },
       
    };
    chart.init();
});
Morris.Bar({
    element: 'bar-example',
    data: [
      { y: '2006', a: 100, b: 90, c: 70 },
      { y: '2007', a: 75, b: 65, c: 70 },
      { y: '2008', a: 50, b: 40, c: 70 },
      { y: '2009', a: 75, b: 65, c: 70 },
    ],

    hoverCallback: function (index, options, content) {
        return (content);
    },
    xkey: 'y',
    ykeys: ['a', 'b', 'c'],
    labels: ['Series A', 'Series B', 'Series C']
});


