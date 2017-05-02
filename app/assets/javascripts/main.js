$animated_elements = null;
$window = $(window);

function checkIfElementsInView() {
  let windowHeight = $window.height();
  let window_top_position = $window.scrollTop();
  let windows_bottom_position = window_top_position + windowHeight;

  $.each($animated_elements, function() {
    let $element = $(this);
    let element_height = $element.outerHeight();
    let element_top_position = $element.offset().top;
    let element_bottom_position = element_top_position + element_height;

    if (element_top_position <= windows_bottom_position) {
       $element.addClass('in-view');
     } else {
       $element.removeClass('in-view');
     }
  })
}
const pageReady = () => {
  $animated_elements = $('div.animated-element');
  $window.on('scroll resize',checkIfElementsInView);
  $window.trigger('scroll');
}
$(document).ready(pageReady);
