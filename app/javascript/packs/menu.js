$(document).ready(function() {
  $(".openbtn").click(function () {
    $(this).toggleClass('active');
    $("#navbarNavDropdown").toggleClass('show');
  });
});