require 'marionette'


class RegisterPolicyGreetingsView extends Backbone.Marionette.ItemView

  template: require './greetings.view.html'
  className: 'register-policy-step-0'

  ui:
    startRegister: '.js-start-register'
    needHelp: '.js-need-help'
    help: '.js-help'

  events:
    'click @ui.startRegister': 'onStartRegister'
    'click @ui.needHelp': 'onHelp'

  onHelp: ->
    @ui.help.removeClass 'hide'

  onStartRegister: ->
    @triggerMethod 'step:over'


module.exports = RegisterPolicyGreetingsView
