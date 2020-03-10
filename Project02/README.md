# CS1XA3 Project02 - hutchm6

## Overview

This webpage is hutchm6's online resume. Being completely hand designed by Mark Hutchison with no external guides or references, this combination of HTML, SCSS, and JavaScript will come together to act as his personal online resume for employers to reference.

## Custom Javascript Code

### Feature: toggleSlide

Description:

This feature was designed to allow each component of the webpage to fold into dropdown menus, hidden from sight until brought back via the toggle button. Additionally, the link I have at the bottom of the page to send you to the top of the page will `fadeToggle` if **and only if** all 3 dropdowns have been collapsed.

Code:

```javascript
$(".toggleSlide").each(function (i, obj) {
    $(this).on("click", () => {
      par = $(this).parent().parent();
      par.find(".content").slideToggle();

      if ($(".toggleSlide").is(":visible")) {
        $("#bottom").fadeToggle(1000);
      }
    });
  });
```

### Feature: changeTheme

Description:

Using jQuery and js-cookie, I will have a light and dark style sheet that toggles and logs your choice as a cookie in your browser.

Code:

```javascript
$("#changeTheme").on("click", () => {
  $("#changeTheme").blur();
  if (Cookies.get("mode") == "dark") {
    $("#stylesheet").attr("href", "./resume/styles/dark.css");
    $("#changeTheme")
      .empty()
      .append(`<i class="fas fa-sun"></i>`);
    Cookies.set("mode", "light", {
      expires: 365
    });
  } else {
    $("#stylesheet").attr("href", "./resume/styles/light.css");
    $("#changeTheme")
      .empty()
      .append(`<i class="fas fa-moon"></i>`);
    Cookies.set("mode", "dark", {
      expires: 365
    });
  }
});
```

## Links and Libraries

For this Project, I used the `jQuery` library and `js-cookie` library to accomplish my JavaScript effects.

- **jQuery**: <https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js>
- **js-cookie**: <https://cdnjs.cloudflare.com/ajax/libs/js-cookie/2.2.1/js.cookie.min.js>
  - js-cookie GitHub: <https://github.com/js-cookie/js-cookie>
