$animated_elements = null;
$window = $(window);

function checkIfElementsInView() {
  var window_height = $window.height();
  var window_top_position = $window.scrollTop();
  var windows_bottom_position = window_top_position + window_height;

  $.each($animated_elements, function() {
    var $element = $(this);
    var element_height = $element.outerHeight();
    var element_top_position = $element.offset().top;
    var element_bottom_position = element_top_position + element_height;

    if (element_top_position <= windows_bottom_position) {
       $element.addClass('in-view');
     } else {
       $element.removeClass('in-view');
     }
  })
}
var pageReady = () => {
  $animated_elements = $('div.animated-element');
  $window.on('scroll resize',checkIfElementsInView);
  $window.trigger('scroll');
}
$(document).ready(pageReady);
