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
    if difference < 0
      "Any second now!"
    else
      duration = moment.duration(difference)
      @_humanizeDuration(duration)

  _humanizeDuration: (duration)=>
    duration = @_splitTime(duration)

    parts = []

    if duration.weeks > 0
      parts.push @_pluralize(duration.weeks, "week")
    if duration.days > 0
      parts.push @_pluralize(duration.days, "day")

    # Always display hours, minutes and seconds
    parts.push @_pluralize(duration.hours, "hour")
    parts.push @_pluralize(duration.minutes, "minute")
    parts.push @_pluralize(duration.seconds, "second")

    @_toSentence(parts)

  _pluralize: (count, singular)=>
    if count == 1
      "#{count} #{singular}"
    else
      "#{count} #{singular}s"

  _toSentence: (parts)=>
    str = parts.slice(0,-1).join(', ')
    str += " and #{parts.slice(-1)}"

  _splitTime: (milliseconds)->
    split = {}
    seconds = Math.floor(milliseconds / 1000)

    split.weeks = Math.floor(seconds / 604800)
    seconds = seconds % 604800

    split.days = Math.floor(seconds / 86400)
    seconds = seconds % 86400

    split.hours = Math.floor(seconds / 3600)
    seconds = seconds % 3600

    split.minutes = Math.floor(seconds / 60)
    split.seconds = seconds % 60

    return split

window.Elfkit.CountdownTimer = CountdownTimer
