require 'marionette'


class Controller extends Backbone.Marionette.Controller

  initialize: (options) ->
    _.extend @, options

  onHome: ->
    @vent.trigger 'routing:home'

  onLogin: ->
    @vent.trigger 'routing:login'

  onRegisterPolicy: ->
    @vent.trigger 'routing:registerPolicy'

  onFileClaim: ->
    @vent.trigger 'routing:fileClaim'

  onPayment: ->
    @vent.trigger 'routing:payment'

  onFAQ: ->
    @vent.trigger 'routing:faq'

  onTOS: ->
    @vent.trigger 'routing:tos'


module.exports = Controller
