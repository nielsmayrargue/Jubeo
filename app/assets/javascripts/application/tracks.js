$(function() {
  $(".btn-attending-create-wait").click(function() {
    $(this).attr("value", "Abonné");
    $(this).css("background", "#2DCC70");
  });
});

$(function() {
  $(".btn-attending-destroy-wait").click(function() {
    $(this).attr("value", "Désabonné");
    $(this).css("background", "#2DCC70");
  });
});

 