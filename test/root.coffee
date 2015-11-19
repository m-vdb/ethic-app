sinon = require 'sinon'


beforeEach ->
  @sinon = sinon.sandbox.create()

  @stubPromise = (obj, prop) =>
    def = new $.Deferred()
    @sinon.stub obj, prop, (-> def)
    def

  @stubStripe = ->
    window.Stripe =
      setPublishableKey: (key) ->
        window.Stripe.key = key
      card:
        createToken: @sinon.spy()

afterEach ->
  delete window.Stripe
  @sinon.restore()
