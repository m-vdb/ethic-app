require 'marionette'


class HomeView extends Backbone.Marionette.LayoutView

  template: require './home.view.html'

  regions:
    policies: ".policy-list",
    claims: ".claim-list"


module.exports = HomeView
