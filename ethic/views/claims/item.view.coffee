require 'marionette'


class ClaimItemView extends Backbone.Marionette.ItemView

  template: _.template(require './item.view.html')


module.exports = ClaimItemView
