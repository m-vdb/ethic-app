require 'marionette'


class Step0RegisterPolicyView extends Backbone.Marionette.ItemView

  template: require './step-0.view.html'

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

module.exports = Step0RegisterPolicyView
