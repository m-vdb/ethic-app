sinon = require 'sinon'


beforeEach ->
  @sinon = sinon.sandbox.create()

  @stubPromise = (obj, prop) =>
    def = new $.Deferred()
    @sinon.stub obj, prop, (-> def)
    def

afterEach ->
  @sinon.restore()
