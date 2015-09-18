require 'marionette'


class EmptyPolicyItemView extends Backbone.Marionette.ItemView

  template: require './empty.view.html'


module.exports = EmptyPolicyItemView
