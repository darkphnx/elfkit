# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  secretBox = $('.js-secret-box')
  new Elfkit.SecretBox(secretBox) if secretBox.length
