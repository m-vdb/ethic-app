Member = require '../../ethic/models/member.coffee'
config = require '../../ethic/config.coffee'


describe 'StripeCard', ->

  beforeEach ->
    @member = new Member id: 'xxx007'
    @stubStripe()

  afterEach ->
    delete window.Stripe

  describe 'initialize', ->
    it 'should init Stripe key if none', ->
      @member.newStripeCard()
      expect(Stripe.key).to.be.ok
      expect(Stripe.key).to.be.equal config.get('stripe.publicKey')

    it 'should not init Stripe key if already set', ->
      Stripe.key = 'toto'
      expect(Stripe.key).to.be.not.equal config.get('stripe.publicKey')
      expect(Stripe.key).to.be.equal 'toto'

  describe 'save', ->
    it 'should call Stripe.card.createToken', ->
      card = @member.newStripeCard()
      card.set
        number: '4242424242424242'
        cvc: '290'
        exp: '10/2020'
      card.save()
      expect(window.Stripe.card.createToken).to.have.been.calledWithMatch
        number: '4242424242424242'
        cvc: '290'
        exp: '10/2020'

    it 'should not call Stripe.card.createToken if model doesnt validate', ->
      card = @member.newStripeCard()
      card.set
        number: '12345678'
        cvc: '290'
        exp: '10/2020'
      card.save()
      expect(window.Stripe.card.createToken).to.not.have.been.called

  describe 'saveHandler', ->
    it 'should trigger error if error in response', ->
      card = @member.newStripeCard()
      @sinon.stub card, 'trigger'

      card.saveHandler 'status',
        error:
          message: 'Some message'
      expect(card.trigger).to.have.been.calledWith 'stripe:error', 'Some message'

    it 'should POST to another url on success', ->
      deferred = @stubPromise $, 'ajax'
      card = @member.newStripeCard()
      @sinon.stub card, 'trigger'

      card.saveHandler 'status',
        error: null
        id: '1337'
      expect($.ajax).to.have.been.calledWithMatch
        type: 'POST'
        url: config.get('api.stripeCustomer', id: 'xxx007')
        data: '{"stripeToken":"1337"}'
        contentType: "application/json"
        dataType: "json"
      deferred.resolve()
      expect(card.trigger).to.have.been.calledWith 'stripe:success'

    it 'should POST to another url on success, but trigger error if any during this POST', ->
      deferred = @stubPromise $, 'ajax'
      card = @member.newStripeCard()
      @sinon.stub card, 'trigger'

      card.saveHandler 'status',
        error: null
        id: '1337'
      expect($.ajax).to.have.been.calledWithMatch
        type: 'POST'
        url: config.get('api.stripeCustomer', id: 'xxx007')
        data: '{"stripeToken":"1337"}'
        contentType: "application/json"
        dataType: "json"
      deferred.reject()
      expect(card.trigger).to.have.been.calledWith 'stripe:error'

  describe 'onSaveSuccess', ->
    it 'should trigger stripe:success event', ->
      card = @member.newStripeCard()
      @sinon.stub card, 'trigger'
      card.onSaveSuccess()
      expect(card.trigger).to.have.been.calledWith 'stripe:success'

  describe 'onSaveError', ->
    it 'should trigger stripe:error event', ->
      card = @member.newStripeCard()
      @sinon.stub card, 'trigger'
      card.onSaveError()
      expect(card.trigger).to.have.been.calledWith 'stripe:error'
