Member = require '../../ethic/models/member.coffee'


describe 'PolicyModel', ->

  beforeEach ->
    member = new Member id: 'some-id'
    @policy = member.newPolicy()

  describe 'proofUrl', ->
    it 'should return the proof url', ->
      @policy.set id: 'policy-id'
      expect(@policy.proofUrl()).to.be.equal 'http://localhost:1234/members/some-id/policies/policy-id/proof'
      
  describe '_getInsuranceProviderData', ->
    it 'should raise error if unknown provider', ->
      @policy.set 'insurance_provider', 'dummy'
      expect(@policy._getInsuranceProviderData).to.throw Error

    it 'should return the insurance provider data if known', ->
      @policy.set 'insurance_provider', 'statefarm'
      expect(@policy._getInsuranceProviderData()).to.be.like
        id: 'statefarm'
        name: 'Statefarm'
        maxDeductible: 2000
        phoneNumber: '(415) 000-1111'

  describe 'getMaxDeductible', ->
    it 'should return the max deductible of the provider', ->
      @policy.set 'insurance_provider', 'statefarm'
      expect(@policy.getMaxDeductible()).to.be.equal 2000

  describe 'getProviderPhone', ->
    it 'should return the phone number of the provider', ->
      @policy.set 'insurance_provider', 'statefarm'
      expect(@policy.getProviderPhone()).to.be.equal '(415) 000-1111'
