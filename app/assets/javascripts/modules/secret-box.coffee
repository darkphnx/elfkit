class SecretBox
  constructor: (el)->
    @contents = el.find('.js-secret-box--contents')
    @link = el.find('.js-secret-box--reveal')

    @_bindEvents()

  _bindEvents: =>
    @link.on 'click', @_revealClicked

  _revealClicked: (e)=>
    e.preventDefault()

    @revealContents(2500)

  revealContents: (duration)=>
    @contents.addClass('is-selected')
    setTimeout(@hideContents, duration)

  hideContents: =>
    @contents.removeClass('is-selected')

window.Elfkit.SecretBox = SecretBox
