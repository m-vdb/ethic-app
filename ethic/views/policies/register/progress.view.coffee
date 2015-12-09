require 'marionette'


class ProgressView extends Backbone.Marionette.ItemView

  template: _.template(require './progress.view.html')

  initialize: ->
    @idx = @options.start

  className: ->
    hideOrShow = if @options.start == 0 then ' hide' else ''
    'register-progress-bar text-center' + hideOrShow

  nextStep: () ->
    @idx++
    @toggle false
    @$("[data-step=#{ @idx }]").addClass 'active'

  serializeData: ->
    hide: @options.start == 0

  toggle: (hide) ->
    @$el.toggleClass 'hide', hide


module.exports = ProgressView
