var slider;

$(document).on('turbolinks:load',function() {
  slider = $("#slider").slider({
      range: true,
      min: 0,
      max: 100,
      values: [10, 35],
      slide: function(event, ui) {
          $("#first-price").html("$ " + ui.values[0]);
          $("#second-price").html("$ " + ui.values[1]);
      }
  });
  $("#first-price").html("$ " + slider.slider("values")[0]);
  $("#second-price").html("$ " + slider.slider("values")[1]);
});