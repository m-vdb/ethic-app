require 'marionette'


class PolicyItemView extends Backbone.Marionette.ItemView

  template: _.template(require './item.view.html')


module.exports = PolicyItemView
