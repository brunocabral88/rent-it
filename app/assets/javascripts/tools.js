$(document).ready(function() {
  // Hide elements on load
  $('img.preview,#file-field,button.delete-pic,div.suggestions').hide();

  $('div.pic-upload').on('click', function(ev) {
    $('#file-field').trigger('click');
  })
  $('#file-field').change(function() {
    var preview = document.querySelector('img.preview');
    var file = document.querySelector('#file-field').files[0];
    var reader = new FileReader();

    reader.addEventListener("load", function () {
      preview.src = reader.result;
      $('img.preview,button.delete-pic').show();
      $('div.pic-upload').hide();

      var image64 = reader.result.split(',')[1];
      $.ajax({
        url: "https://infinite-sierra-87845.herokuapp.com/api",
        data: { image: JSON.stringify(image64) },
        type: "POST"
      }).success(function(response) {
        if (response.length > 0) {
          loadSuggestions(response);
        } else {
          console.log("No suggestion from API..");
        }
      })
    }, false);

    if (file) {
      reader.readAsDataURL(file);
    }
  })

  $('button.delete-pic').click(function(ev) {
    ev.preventDefault();
    var preview = document.querySelector('img.preview');
    preview.src = "";
    $(this).hide();
    $('img.preview').hide();
    $('div.pic-upload').show();
    $('div.suggestions').empty().hide();
  })

  $('div.suggestions').on('click','div.suggestion',function(ev) {
    $('#tool_name').val($(this).text());
  })
})

function loadSuggestions(suggestions) {
  $('div.suggestions').show();
  $('div.suggestions').append(`<h4>Suggestions (${suggestions.length})</h4>`);
  suggestions.forEach((suggestion) => {
    $('div.suggestions').append(`<div class='suggestion alert alert-success'>${suggestion}</div>`);
  })
}