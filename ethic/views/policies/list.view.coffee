require 'marionette'


class PolicyListView extends Backbone.Marionette.CollectionView

  template: require './list.view.html'
  childView: require './item.view.coffee'
  emptyView: require './empty.view.coffee'
  childViewContainer: '.policies-container'


module.exports = PolicyListView
