function hideFlashMessages() {
  setTimeout(function () {
    $('.flash-notice').fadeOut('slow');
  }, 3000);
}

$(document).ready(function () {
  hideFlashMessages();
});
