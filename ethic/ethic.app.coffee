window.$ = window.jQuery = require 'jquery'
require 'bootstrap'  # TODO: include minimal version
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
Member = require './models/member.coffee'
Claim = require './models/claim.coffee'

# layouts
MainLayout = require './views/main.layout.coffee'
BaseLayout = require './views/base.layout.coffee'

# views
HomeView = require './views/home/home.view.coffee'
MenuView = require './views/menu/menu.view.coffee'
LoginView = require './views/auth/login.view.coffee'
PolicyListView = require './views/policies/list.view.coffee'
RegisterPolicyLayout = require './views/policies/register/layout.coffee'
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

    @member = new Member()
    AuthUtils.setMember @member

    @app.on 'start', =>
      @collections =
        claims: new ClaimCollection @member
        policies: new PolicyCollection @member

    @app.on 'start', =>
      @controller = new Controller
        vent: @app.vent
        collections: @collections
      @router = new Router
        controller: @controller

    @app.on 'start', _.bind(@routingViews, @)

    @app.on 'start', ->
      if window.Backbone.history
        window.Backbone.history.start()

    AuthUtils.checkAuthentication =>
      @app.start options

  routingViews: ->
    @app.vent.on 'routing:home', =>
      @showMainLayout()
      homeView = new HomeView()
      @layout.showChildView 'content', homeView
      homeView.showChildView 'policies', new PolicyListView
        collection: @collections.policies
      homeView.showChildView 'claims', new ClaimListView
        collection: @collections.claims

    @app.vent.on 'routing:login', =>
      @showAuthLayout()
      @layout.showChildView 'content', new LoginView
        model: @member

    @app.vent.on 'routing:registerPolicy', =>
      @showMainLayout()
      @layout.showChildView 'content', new RegisterPolicyLayout
        model: @member.newPolicy()
        collection: @collections.policies

    @app.vent.on 'routing:fileClaim', =>
      @showMainLayout()
      # TODO: relies on polcicy collection content
      @layout.showChildView 'content', new FileClaimView
        model: new Claim member: @member
        collection: @collections.claims
        policiesCollection: @collections.policies

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
