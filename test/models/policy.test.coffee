Member = require '../../ethic/models/member.coffee'


describe 'PolicyModel', ->

  describe 'proofUrl', ->
    it 'should return the proof url', ->
      member = new Member id: 'some-id'
      policy = member.newPolicy()
      policy.set id: 'policy-id'
      expect(policy.proofUrl()).to.be.equal 'http://localhost:1234/members/some-id/policies/policy-id/proof'
      
