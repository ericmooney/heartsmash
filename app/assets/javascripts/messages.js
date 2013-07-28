$(document).ready(function() {

  var clock;

  var refresh_messages_container = function(){
      $.ajax({
        dataType: "script",
        type: "get",
        url: $('#refresh_url').val() //need to get the receiver id params sent to page somehow
      });
    };

    var start_timer = function() {
      clock = setInterval(refresh_messages_container, 10000);
    };


  if ($('#messages_container').length !== 0) {
    start_timer();
  }

});