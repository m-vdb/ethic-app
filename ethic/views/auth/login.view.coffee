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
    if @validate data
      AuthUtils.authenticate data, => @onAuthError()

  validate: (data) ->
    true

  onAuthError: ->
    true


module.exports = LoginView
