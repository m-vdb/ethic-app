require 'marionette'


class Controller extends Backbone.Marionette.Controller

  initialize: (options) ->
    _.extend @, options

  onHome: ->
    @vent.trigger 'routing:home'

  onRegisterPolicy: ->
    @vent.trigger 'routing:registerPolicy'

  onClaims: ->
    @vent.trigger 'routing:claims'

  onPayment: ->
    @vent.trigger 'routing:payment'

  onFAQ: ->
    @vent.trigger 'routing:faq'

  onTOS: ->
    @vent.trigger 'routing:tos'


module.exports = Controller
