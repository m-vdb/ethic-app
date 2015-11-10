window.$ = window.jQuery = require 'jquery'
window._ = require 'underscore'
window.Backbone = require 'backbone'
require 'marionette'
require 'backbone-validation'
require './utils/backbone.inheritance.coffee'

Router = require './router.coffee'
Controller = require './controller.coffee'
AuthUtils = require './utils/auth.coffee'

# collections
PolicyCollection = require './collections/policies.coffee'
ClaimCollection = require './collections/claims.coffee'

# models
Policy = require './models/policy.coffee'
Claim = require './models/claim.coffee'

# layouts
MainLayout = require './views/main.layout.coffee'
BaseLayout = require './views/base.layout.coffee'

# views
HomeView = require './views/home/home.view.coffee'
MenuView = require './views/menu/menu.view.coffee'
LoginView = require './views/auth/login.view.coffee'
PolicyListView = require './views/policies/list.view.coffee'
RegisterPolicyLayout = require './views/policies/register/step.layout.coffee'
ClaimListView = require './views/claims/list.view.coffee'
FileClaimView = require './views/claims/file.view.coffee'
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

    @app.on 'start', ->
      @collections =
        claims: new ClaimCollection()
        policies: new PolicyCollection()

    @app.on 'start', ->
      @controller = new Controller
        vent: @vent
        collections: @collections
      @router = new Router
        controller: @controller

    @app.on 'start', _.bind(@routingViews, @)

    @app.on 'start', ->
      if window.Backbone.history
        window.Backbone.history.start()

    # debugging purposes
    @app.on 'start', ->
      if location.search.indexOf('fixtures') != -1
        @collections.policies.add require('../fixtures/policies.json')
        @collections.claims.add require('../fixtures/claims.json')

    AuthUtils.checkAuthentication =>
      @app.start options

  routingViews: ->
    @app.vent.on 'routing:home', =>
      @showMainLayout()
      homeView = new HomeView()
      @layout.showChildView 'content', homeView
      homeView.showChildView 'policies', new PolicyListView
        collection: @app.collections.policies
      homeView.showChildView 'claims', new ClaimListView
        collection: @app.collections.claims

    @app.vent.on 'routing:login', =>
      @showAuthLayout()
      @layout.showChildView 'content', new LoginView()

    @app.vent.on 'routing:registerPolicy', =>
      @showMainLayout()
      @layout.showChildView 'content', new RegisterPolicyLayout
        model: new Policy()
        collection: @app.collections.policies

    @app.vent.on 'routing:fileClaim', =>
      @showMainLayout()
      # TODO: relies on polcicy collection content
      @layout.showChildView 'content', new FileClaimView
        model: new Claim()
        collection: @app.collections.claims
        policiesCollection: @app.collections.policies

    @app.vent.on 'routing:payment', =>
      @showMainLayout()
      @layout.showChildView 'content', new PaymentView()

    @app.vent.on 'routing:faq', =>
      @showMainLayout()
      @layout.showChildView 'content', new FAQView()

    @app.vent.on 'routing:tos', =>
      @showMainLayout()
      @layout.showChildView 'content', new TOSView()

  showMainLayout: ->
    return if @layout instanceof MainLayout
    @layout = new MainLayout()
    @app.main.show @layout
    @layout.menu.show new MenuView
      router: @router

  showAuthLayout: ->
    return if @layout instanceof BaseLayout
    @layout = new BaseLayout()
    @app.main.show @layout


module.exports = window.ethic = App.get()
