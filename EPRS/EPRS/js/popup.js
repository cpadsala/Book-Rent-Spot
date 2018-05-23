$(document).ready(function () {
    alertErrorMessage();

    setTimeout(function () {
        var alerts = document.getElementsByClassName("dismis-alert");

        for (var i = 0; i < alerts.length; i++) {
            alerts[i].style.display = "none";
        }
    }, 2000);

});
function alertErrorMessage() {
    var popup = $(".popup-msg:visible");
    if (popup.length > 0) {
        var message = $.trim($(popup).html());
        if (message !== '')
            alert(message);
    }
}

