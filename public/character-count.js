$(document).ready(function() {
  $("textarea").keyup(function() {
    var charCount = $(this).val().length;
    var textColor, buttonDisabled;

    $(".char-count").html(charCount);

    if (charCount > 140) {
      textColor = "red";
      buttonDisabled = true;
    } else {
      textColor = "black";
      buttonDisabled = false;
    }

    $(".char-count").css("color", textColor);
    $("input[type='submit']").prop("disabled", buttonDisabled);
  });
});
