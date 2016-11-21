# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  secretBox = $('.js-secret-box')
  secretBox.each (i, el)=>
    new Elfkit.SecretBox($(el))

  dates = $('.js-datepicker')
  dates.each (i, el)=>
    new Elfkit.DatePicker($(el))

  countdowns = $('.js-countdown-timer')
  countdowns.each (i, el)=>
    new Elfkit.CountdownTimer($(el))

  signupForm = $('.js-data-form')
  signupForm.each (i, el)=>
    new Elfkit.DataRemoteForm($(el))
