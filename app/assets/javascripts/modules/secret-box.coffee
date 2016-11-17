class SecretBox
  constructor: (el)->
    @box = el

    @_bindEvents()

  _bindEvents: =>
    @box.on 'click', @_revealClicked

  _revealClicked: (e)=>
    e.preventDefault()

    clearTimeout(@timer) if @timer?
    @revealContents(2500)

  revealContents: (duration)=>
    @box.addClass('is-selected')
    @timer = setTimeout(@hideContents, duration)

  hideContents: =>
    @box.removeClass('is-selected')

window.Elfkit.SecretBox = SecretBox
