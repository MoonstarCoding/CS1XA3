$(document).ready(function () {
  $("#form_id").on("click", function () {
    let old_data = {
      'firstName': $(this).find("#firstName").val(),
      'lastName': $(this).find("#lastName").val()
    };

    $.post('./goodbye/test_ajax/', old_data,
      function (data, status) {
        $(body).append(`<p>The response was "${data.firstName}, ${data.lastName}"\nwith status ${status}</p>`);
      }
    );
  });
});