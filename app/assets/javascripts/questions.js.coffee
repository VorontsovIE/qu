# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

page_ready = ->
  $('#question_answer').focus();

$(document).ready(page_ready);
$(document).on('page:load', page_ready);
