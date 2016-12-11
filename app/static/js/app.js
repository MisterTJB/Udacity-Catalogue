$(document).foundation()

function start(){

gapi.load('auth2', function(){
      // Retrieve the singleton for the GoogleAuth library and set up the client.
      auth2 = gapi.auth2.init({
        client_id: '407235018168-9kpf9phnb4u91lt9i3ge1qjpbs6p2eik.apps.googleusercontent.com',
        cookiepolicy: 'single_host_origin'
      });
    });
}

function signIn() {
    auth2.grantOfflineAccess({'redirect_uri': 'postmessage'}).then(signInCallback);
  };

function signInCallback(authResult) {
  if (authResult['code']) {
    $.ajax({
      type: 'POST',
      url: '/gconnect',
      processData: false,
      data: authResult['code'],
      contentType: 'application/octet-stream; charset=utf-8',
      success: function(result) {
        // Handle or verify the server response if necessary.
        if (result) {
            location.reload(true);
      } else if (authResult['error']) {
            alert('There was an error: ' + authResult['error']);
  } else {
        alert('Failed to make a server-side call. Check your configuration and console.');
         }
      }

  }); } }

function signOut() {
    $.ajax({
      type: 'POST',
      url: '/gdisconnect',
      success: function(result) {
          location.reload(true);

      },
      fail: function(result){
          alert(result)
      }
    })};