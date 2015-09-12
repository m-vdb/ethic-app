require 'backbone.marionette'


class MainLayout extends Backbone.Marionette.LayoutView
  template: require './main.layout.html'
  className: 'row main-theme-container'

  regions:
    menu: "#menu",
    content: "#content"


module.exports = MainLayout
