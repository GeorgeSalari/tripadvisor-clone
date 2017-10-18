$(document).ready(function(){
  $("#join").click(function(event){
    $.ajax({
      url: '/',
      method: 'get',
      success: function(data){
        if (window.location.href != 'http://localhost:3000/') {
          window.location = 'http://localhost:3000'
        }
      }
    })
    $("#login").removeClass("hidden");
  })
})
