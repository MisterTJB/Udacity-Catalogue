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

// Initiate the Google sign in process
function signIn() {
    auth2.grantOfflineAccess({'redirect_uri': 'postmessage'})
        .then(signInCallback);
};

// Initiate server-side validation
function signInCallback(authResult) {
    if (authResult['code']) {
        $.ajax({
            type: 'POST',
            url: '/gconnect',
            processData: false,
            data: authResult['code'],
            contentType: 'application/octet-stream; charset=utf-8',
            success: function(result) {
                location.reload(true);
            },
            error: function(result){
                alert("An error occurred while logging in. Try again");
            }
        }) ;
    }
}

// Initiate the server-side sign out process
function signOut() {
    $.ajax({
        type: 'POST',
        url: '/gdisconnect',
        success: function(result) {
            location.reload(true);

        },
        error: function(result){
            alert("An error occurred while logging out. Try again");
        }
    })
};