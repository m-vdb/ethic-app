require 'marionette'
AuthUtils = require '../../utils/auth.coffee'


class LoginView extends Backbone.Marionette.ItemView

  template: require './login.view.html'
  ui:
    email: '#login-email'
    password: '#login-password'
    submit: '#login-submit'

  events:
    'click @ui.submit': 'onSubmit'

  onSubmit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    data =
      email: @ui.email.val()
      password: @ui.password.val()
    if @model.set data, {validate: true}
      AuthUtils.authenticate data, =>
        @onAuthError()

   onRender: ->
    Backbone.Validation.bind @,
      valid: (view, attr) ->
        view.onValid attr

      invalid: (view, attr, error) ->
        view.onInvalid attr, error

  onValid: (attr) ->
    formGroup = @ui[attr].parents('.form-group')
    formGroup.removeClass 'has-error'
    formGroup.children('.form-error-msg').html ''

  onInvalid: (attr, error) ->
    formGroup = @ui[attr].parents('.form-group')
    formGroup.removeClass 'has-success'
    formGroup.children('.form-error-msg').html error

  onAuthError: ->
    @onInvalid 'email', 'Wrong email / password'
    @onInvalid 'password', 'Wrong email / password'


module.exports = LoginView
