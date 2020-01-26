$(document).ready(function () {
 
  if( $("#restricted").val() == 'true' )
    {
    $("#restricted_reason").show();
	}
  else
    {
    $("#restricted_reason").hide();
    }
 
	
	
$('#restricted').change(function(e) 
   {
    if (e.target.value=='true') 
     {
     $("#restricted_reason").show();
     }
    else
     {
     $("#restricted_reason").hide();
     }
  })

})





