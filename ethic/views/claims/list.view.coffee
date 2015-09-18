require 'marionette'


class ClaimListView extends Backbone.Marionette.CompositeView

  template: require './list.view.html'
  childView: require './item.view.coffee'
  emptyView: require './empty.view.coffee'
  childViewContainer: '.claims-container'


module.exports = ClaimListView
