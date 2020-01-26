import consumer from "./consumer"
import Cookies from "js.cookie"
consumer.subscriptions.create("RoomChannel", {
    connected() {
    // Called when the subscription is ready for use on the server
    
    console.log('yiha we are live!')


  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

       received(data) {
         $(document).on('trix-initialize', function ()  { 
  	        console.log(data.content)
	        console.log(data.msg_time)
	        console.log(data.sender_name)
	        console.log(data.sender)
            console.log(Cookies.get('current_user_id'))
			   if (data.sender==Cookies.get('current_user_id')) 
				   {
				   console.log ('sender matches current_user_id')
					$('#message_holder').editor.insertHTML('<div class="container-right"><div class="subscript">' + data.sender_name + '<br>' + data.msg_time + '</div>' + data.content + '</div>')
				   }
			   else
				   {
					console.log ('sender and current_user_id are different')
					$('#message_holder').editor.insertHTML('<div class="container-left"><div class="subscript">' + data.sender_name + '<br>' + data.msg_time + '</div>' + data.content + '</div>')
				   }
	      })
	   }

});




var submit_messages;

$(document).on('turbolinks:load', function () {
	submit_messages()
})

submit_messages = function () {
	$('#message_content').on('keydown', function (event) {
		if (event.keyCode === 13) {
			$('input').click()
			event.target.value = ''
			event.preventDefault()
			console.log('yes we hit enter!')
		}
    })
}
