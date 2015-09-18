require 'marionette'


class MenuView extends Backbone.Marionette.ItemView

  template: _.template(require './menu.view.html')

  initialize: (options) ->
    throw new Error('Missing router argument.') unless options.router
    super
    options.router.on 'route', @onRoute, @

  onRoute: ->
    @$('.link').removeClass 'active'
    location_hash = if location.hash then location.hash else '#'
    @$('[href="'+location_hash+'"]').parent('.link').addClass 'active'

module.exports = MenuView
