Member = require '../../ethic/models/member.coffee'
Policy = require '../../ethic/models/policy.coffee'


describe 'MemberModel', ->

  describe 'newPolicy', ->
    it 'should return a new policy, bound to the member instance', ->
      member = new Member
      policy = member.newPolicy()
      expect(policy).to.be.an.instanceof Policy
      expect(policy.get 'member').to.be.equal member
