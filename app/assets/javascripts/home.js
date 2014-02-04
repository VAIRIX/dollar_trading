$(document).ready(function(){
  $(".tablesorter").tablesorter({ headers: { 0: {sorter: false },
                                             1: {sorter: false },
                                             2: {sorter: false },
                                             5: {sorter: false },
                                             4: {sorter: false },
                                             9: {sorter: false },
                                             10:{sorter: false }}
  });

  $("#index_graph").ready(function(){
    $(".exchange_rate_values").each(function(){
      var average = $(this).data("average");
      var company = $(this).data("company");
      $("#sparkline_"+company).sparkline(average, {
        type: 'bar',
        barSpacing: 5,
      });
    });
  });
});