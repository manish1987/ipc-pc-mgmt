// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker/core
//= require_tree .

$(function () {
  $('#warriors th a, #warriors .pagination a, #sessions_list th a, #sessions_list .pagination a,#sessions_tabs th a,#sessions_tabs .pagination a, #warrior_sessions th a, #warrior_sessions .pagination a').live('click', function () {
    $.getScript(this.href);
    return false;
  });

//  $('#warriors_search').submit(function () {
//    $.get(this.action, $(this).serialize(), null, 'script');
//    return false;
//  });

    $('#warrior_sessions_date, #sessions_daterange, #stats-daterange').submit(function () {
    var docHeight = $(document).height();

   $("#stats").append("<div id='overlay'></div>");

   $("#overlay")
      .height(docHeight)
      .css({
         'opacity' : 0.4,
         'position': 'absolute',
         'top': 0,
         'left': 0,
         'background-color': 'black',
         'width': '100%',
         'z-index': 5000
      });
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });

     $('#end_session').live('click',function() {
        $.getScript(this.href);
        return false;
        });

      $('#warriors_search input').keyup(function () {
      $.get($('#warriors_search').attr('action'),
        $('#warriors_search').serialize(), null, 'script');
      return false;
    });

    $(".chzn-select").chosen();

});
