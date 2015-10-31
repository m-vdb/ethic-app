chai = require 'chai'
expect = chai.expect

VinValidator = require '../../ethic/utils/vin-validator.coffee'

describe 'VinValidator', ->
  beforeEach ->
    @validator = new VinValidator

  describe 'validateLength', ->
    it 'should raise Error if length is > 17', ->
      expect(-> @validator.validateLength 'VOHIHIJ81209BJEWKJEWJEOWJE').to.throw(Error);

    it 'should raise Error if length is < 17', ->
      expect(-> @validator.validateLength 'IQUGYWBQ').to.throw(Error);

    it 'should do nothing if length == 17', ->
      expect(@validator.validateLength 'QWERTDHOPOK197JKP').to.be.undefined
