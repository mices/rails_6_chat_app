$(document).ready(function () {

 $("#birth_place_state").show();
 $("#state").show();

 var start_date = new Date();


$('#birth_place_country').change(function(e) 
   {
    if (e.target.value=='US') 
     {
     $("#birth_place_state").show();
     }
    else
     {
     $("#birth_place_state").hide();
     }
  })





})

