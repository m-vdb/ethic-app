require 'marionette'


class PolicyListView extends Backbone.Marionette.CompositeView

  template: require './list.view.html'
  childView: require './item.view.coffee'
  emptyView: require './empty.view.coffee'
  childViewContainer: '.policies-container'


module.exports = PolicyListView
