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
//= require_tree
//= require dataTables/jquery.dataTables


$(document).ready(function(){
    oTable = $('.data-table').dataTable({
          sPaginationType: "full_numbers",
          bJQueryUI: true,
          iDisplayLength: 10,
          aLengthMenu: [10, 25, 50, 100, 150]
    });
// var username = '<%= current_user.authorizations.first.screen_name %>';
    var username = 'twitter'
    $.ajax({
      type : "GET",
      dataType : "json",
      url : "http://search.twitter.com/search.json?q=from:"+ username +"&callback=?",
      success : function(data) {
        var time;
        var created_at
        var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
        $("#first_tweet").html(data.results[0].text.replace(exp,"<a href='$1' target='_blank'>$1</a>"));
        created_at = new Date(data.results[0].created_at);
        time = tweet_time(created_at);
        // alert(time);
        $("#first_tweet_days").text(time);

        $("#second_tweet").html(data.results[1].text.replace(exp,"<a href='$1' target='_blank'>$1</a>"));
        created_at = new Date(data.results[1].created_at);
        time = tweet_time(created_at);
        $("#second_tweet_days").text(time);

      }
    });
});


function tweet_time(created_at){

        var one_day=1000*60*60*24;
        var one_hr = 1000*60*60;
    
        var today = new Date();
        var date1_ms = created_at.getTime();
        var date2_ms = today.getTime();
  // Calculate the difference in milliseconds
        var difference_ms = date2_ms - date1_ms;
        if (difference_ms < one_day){
          if(difference_ms < one_hr)
            return(" Few Menutes ago");
          else
              return(Math.round(difference_ms/one_hr)+ " Hours ago");
        }
        else
  // Convert back to days and return
          return(Math.round(difference_ms/one_day)+ " Days ago"); 
  }
 