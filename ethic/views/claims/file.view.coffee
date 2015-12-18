require 'marionette'


class FileClaimView extends Backbone.Marionette.ItemView

  template: _.template(require './file.view.html')

  serializeData: ->
    data = super
    data.policies = @options.policiesCollection.pluck 'id'
    data

module.exports = FileClaimView
