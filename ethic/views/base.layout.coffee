require 'marionette'


class BaseLayout extends Backbone.Marionette.LayoutView
  template: require './base.layout.html'
  className: 'row main-theme-container'

  regions:
    content: "#base-content"


module.exports = BaseLayout
