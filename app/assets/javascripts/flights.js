$(document).ready(function(){
  $('#search_one_flight').click(function(event){
    event.preventDefault();
    $.ajax({
      url: "/flight_respons",
      method: 'post',
      data: jQuery.param({
        origin: $('#origin').val(),
        destination: $('#destination').val(),
        date: $('#date').val(),
        preferredCabin: $('#preferredCabin').val(),
        maxStops: $('#maxStops').val(),
        maxConnectionDuration: $('#maxConnectionDuration').val(),
        adultCount: $('#adultCount').val(),
        seniorCount: $('#seniorCount').val(),
        childCount: $('#childCount').val(),
        infantInLapCount: $('#infantInLapCount').val(),
        infantInSeatCount: $('#infantInSeatCount').val(),
        refundable: $('#refundable').is(':checked'),
        solutions: $('#solutions').val()
      }),
      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
      success: function(){
        $('#search_form_one_flight').addClass('hidden');
        $('#search_result_one_flight').removeClass('hidden');
      }
    })
  })
})
