$(document).foundation()

function signInCallback(authResult) {
  if (authResult['code']) {
    // Hide the sign-in button now that the user is authorized
    $('#signInButton').hide();
    //  Send the one-time-use code to the server, if the server responds,
    //  write a 'login successful' message
    $.ajax({
      type: 'POST',
      url: '/gconnect',
      processData: false,
      data: authResult['code'],
      contentType: 'application/octet-stream; charset=utf-8',
      success: function(result) {
        // Handle or verify the server response if necessary.
        if (result) {
            $('#signInButton').hide();
            $('#logout').show()
      } else if (authResult['error']) {
            alert('There was an error: ' + authResult['error']);
            $('#signInButton').disable();
  } else {
        $('#result').html('Failed to make a server-side call. Check your configuration and console.');
         }
      }

  }); } }

function signOut() {
    $.ajax({
      type: 'POST',
      url: '/gdisconnect',
      success: function(result) {
          $('#logout').hide();
          $('#signInButton').show();

      },
      fail: function(result){
          alert(result)
      }
    })};