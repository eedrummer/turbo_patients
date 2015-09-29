$(document).on('page:change', function(event) {
  let bmiSeries = [];
  $('.bmi').each(function() {
    let bmiDate = Date.parse($(this).data('date'));
    let bmi = $(this).data('bmi');
    bmiSeries.push([bmiDate, bmi]);
  });
  $('#chart').highcharts({
      title: {
          text: 'BMI',
          x: -20 //center
      },
      xAxis: {
          type: 'datetime'
      },
      yAxis: {
          title: {
              text: 'BMI'
          },
          plotLines: [{
              value: 0,
              width: 1,
              color: '#808080'
          }],
          plotBands: [{
            color: 'green',
            from: 18.5,
            to: 25
          },
          {
            color: 'yellow',
            from: 25,
            to: 30
          },
          {
            color: 'red',
            from: 30,
            to: 50
          }]
      },
      series: [{
          name: 'BMI',
          data: bmiSeries
      }]
  });
});
