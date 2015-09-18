window._ = require 'underscore'
window.Backbone = require 'backbone'
require 'marionette'

Router = require './router.coffee'
Controller = require './controller.coffee'

# collections
PolicyCollection = require './collections/policies.coffee'
ClaimCollection = require './collections/claims.coffee'

# models
Policy = require './models/policy.coffee'

# views
MainLayout = require './views/main.layout.coffee'
HomeView = require './views/home/home.view.coffee'
RegisterPolicyView = require './views/policies/register.view.coffee'
ClaimsListView = require './views/claims/list.view.coffee'
PaymentView = require './views/payment/payment.view.coffee'
FAQView = require './views/faq/faq.view.coffee'
TOSView = require './views/tos/tos.view.coffee'


class App
  instance = null    

  # Static singleton retriever/loader
  @get: ->
    if not @instance?
      instance = new @

    instance

  init: (options) ->
    @app = new Backbone.Marionette.Application()

    @app.addRegions
      main: options.container

    @app.addInitializer ->
      @layout = new MainLayout()
      @main.show @layout

    @app.addInitializer ->
      @collections =
        claims: new ClaimCollection()
        policies: new PolicyCollection()

    @app.addInitializer _.bind(@routingViews, @)

    @app.addInitializer ->
      @controller = new Controller
        vent: @vent
      @router = new Router
          controller: @controller

    @app.addInitializer ->
      if window.Backbone.history
        window.Backbone.history.start()

    @app.start options

  routingViews: ->
    @app.vent.on 'routing:home', =>
      @app.layout.content.show new HomeView()

    @app.vent.on 'routing:registerPolicy', =>
      @app.layout.content.show new RegisterPolicyView
        model: new Policy()
        collection: @app.collections.policies

    @app.vent.on 'routing:claims', =>
      @app.layout.content.show new ClaimsListView()

    @app.vent.on 'routing:payment', =>
      @app.layout.content.show new PaymentView()

    @app.vent.on 'routing:faq', =>
      @app.layout.content.show new FAQView()

    @app.vent.on 'routing:tos', =>
      @app.layout.content.show new TOSView()


module.exports = window.ethic = App.get()
