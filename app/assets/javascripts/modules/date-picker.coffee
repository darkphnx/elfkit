class DatePicker
  constructor: (el)->
    @date = el.find('.js-datepicker--date').get(0)
    @time = el.find('.js-datepicker--time')
    @hiddenFields = el.find('.js-datepicker--hidden')

    @startDate = moment(el.data('date'));

    @picker = @_initPikaday()
    @picker.setMoment(@startDate)

    @time.on 'change', @_setHiddenFields

  _initPikaday: =>
    new Pikaday
      field: @date
      firstDay: 1
      defaultDate: @startDate
      minDate: moment().toDate()
      setDefaultDate: true
      format: 'Do MMM YYYY'
      onSelect: @_setHiddenFields


  _setHiddenFields: =>
    @hiddenFields.filter('.js-datepicker--year').val(@picker.getMoment().year())
    @hiddenFields.filter('.js-datepicker--month').val(@picker.getMoment().month() + 1) # 0-indexed months - WHY?
    @hiddenFields.filter('.js-datepicker--day').val(@picker.getMoment().date())
    @hiddenFields.filter('.js-datepicker--hour').val(@time.val())
    @hiddenFields.filter('.js-datepicker--min').val(0) # No options, mofos

window.Elfkit.DatePicker = DatePicker
