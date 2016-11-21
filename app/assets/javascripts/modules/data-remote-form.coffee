class DataRemoteForm
  constructor: (form)->
    @form = form
    @errors = @form.find('.js-data-form--errors')

    @_bindEvents()

  _bindEvents: =>
    @form.on 'submit', @_clearErrors
    @form.on 'ajax:error', @_renderErrors
    @form.on 'ajax:success', @_handleSuccess

  _handleSuccess: (jq, data)=>
    console.log data
    if data.redirect
      window.location = data.redirect

  _renderErrors: (jq, xhr, status, error)=>
    if xhr.status == 422
      data = JSON.parse(xhr.responseText)
      @_clearErrors()
      @errors.append(data.errors)
    else
      errMsg = 'Sorry, something went wrong when processing this request.';
      alert(errMsg);

  _clearErrors: =>
    @errors.empty()


window.Elfkit.DataRemoteForm = DataRemoteForm
