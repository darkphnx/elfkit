class CountdownTimer
  constructor: (el)->
    @el = el
    @startDate = moment(el.data('date'))

    @updateDisplay()
    @startCountdown()

  updateDisplay: =>
    @el.text(@_timeDifference())

  startCountdown: =>
    setInterval(@updateDisplay, 1000)

  _timeDifference: =>
    difference = @startDate.diff(moment())
    console.log difference
    if difference < 0
      "Any second now!"
    else
      duration = moment.duration(difference)
      @_humanizeDuration(duration)

  _humanizeDuration: (duration)=>
    parts = []
    if duration.weeks() > 0
      parts.push @_pluralize(duration.weeks(), "week")
    if duration.days() > 0
      parts.push @_pluralize(duration.days(), "day")

    # Always display hours, minutes and seconds
    parts.push @_pluralize(duration.hours(), "hour")
    parts.push @_pluralize(duration.minutes(), "minute")
    parts.push @_pluralize(duration.seconds(), "second")

    @_toSentence(parts)

  _pluralize: (count, singular)=>
    if count == 1
      "#{count} #{singular}"
    else
      "#{count} #{singular}s"

  _toSentence: (parts)=>
    str = parts.slice(0,-1).join(', ')
    str += " and #{parts.slice(-1)}"

window.Elfkit.CountdownTimer = CountdownTimer
