$(document).ready(function () {
  // Set up stylesheet
  if (Cookies.get('mode') == 'dark') {
    $("#stylesheet").attr('href', "./resume/styles/light.css");
    $("#changeTheme").empty().append(`<i class="fas fa-moon"></i>`);
  } else {
    $("#stylesheet").attr('href', "./resume/styles/dark.css");
    $("#changeTheme").empty().append(`<i class="fas fa-sun"></i>`);
  }

  // Toggle Slide
  $(".toggleSlide").each(function (i, obj) {
    $(this).on("click", () => {
      par = $(this).parent().parent();
      par.find(".content").slideToggle();
    });
  });

  // Change Theme
  $("#changeTheme").on('click', () => {
    $("#changeTheme").blur();
    if (Cookies.get('mode') == 'dark') {
      $("#stylesheet").attr('href', "./resume/styles/dark.css");
      $("#changeTheme").empty().append(`<i class="fas fa-sun"></i>`);
      Cookies.set('mode', 'light', {
        expires: 365
      });
    } else {
      $("#stylesheet").attr('href', "./resume/styles/light.css");
      $("#changeTheme").empty().append(`<i class="fas fa-moon"></i>`);
      Cookies.set('mode', 'dark', {
        expires: 365
      });
    }
  });
});