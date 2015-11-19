PaymentValidator = require '../../ethic/utils/payment-validator.coffee'


describe 'PaymentValidator', ->

  describe 'makeValidator', ->

    it 'should make a validator function', ->
      fn = (value) -> value % 2 == 0
      fn = PaymentValidator.makeValidator fn, 'Value is odd.'
      expect(fn 2).to.be.undefined
      expect(fn 5).to.be.equal 'Value is odd.'
