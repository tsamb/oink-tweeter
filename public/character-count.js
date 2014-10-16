$(document).ready(function() {
  $("textarea").keydown(function() {
    updateCharacterCount.bind(this)();
  });
});

function updateCharacterCount() {
  var textColor = "black";
  var charCount = $(this).val().length;
  $(".char-count").html(charCount);
  if (charCount > 140) {
    textColor = "red";
  } else {
    textColor = "black";
}
  $(".char-count").css("color", textColor);
}
