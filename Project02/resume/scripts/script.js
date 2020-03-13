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
      hideBottom();
    });
  });

  // Hide "Back to Top"
  function hideBottom() {
    setTimeout(() => {
      if ($(".resume .content").css("display") == "none" && $(".portfolio .content").css("display") == "none" && $(".contacts .content").css("display") == "none") {
        $("#bottom").fadeOut(1000);
      } else {
        $("#bottom").fadeIn(1000);
      }
    }, 800);
  }

  // Change Theme
  $("#changeTheme").on('click', () => {
    $("#changeTheme").blur();
    if (Cookies.get('mode') == 'dark') {
      $("#stylesheet").attr('href', "./resume/styles/dark.css");
      $("#changeTheme").empty().append(`< i class="fas fa-sun" ></i > `);
      Cookies.set('mode', 'light', {
        expires: 365
      });
    } else {
      $("#stylesheet").attr('href', "./resume/styles/light.css");
      $("#changeTheme").empty().append(`< i class="fas fa-moon" ></i > `);
      Cookies.set('mode', 'dark', {
        expires: 365
      });
    }
  });
});