$(document).ready(function() {
  $("textarea").keyup(function() {
    updateCharacterCount.bind(this)();
  });
});

function updateCharacterCount() {
  var charCount = $(this).val().length;
  $(".char-count").html(charCount);
  if (charCount > 140) {
    overLimit(true);
  } else {
    overLimit(false);
  }
}

function overLimit(pastLimit) {
  var textColor, buttonDisabled
  if (pastLimit) {
    textColor = "red";
    buttonDisabled = true;
  } else {
    textColor = "black";
    buttonDisabled = false;
  }
  $(".char-count").css("color", textColor);
  $("input[type='submit']").prop("disabled", buttonDisabled);
}
