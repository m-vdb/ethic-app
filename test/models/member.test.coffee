Member = require '../../ethic/models/member.coffee'
Policy = require '../../ethic/models/policy.coffee'
StripeCard = require '../../ethic/models/stripeCard.coffee'


describe 'MemberModel', ->

  describe 'newPolicy', ->
    it 'should return a new policy, bound to the member instance', ->
      member = new Member
      policy = member.newPolicy()
      expect(policy).to.be.an.instanceof Policy
      expect(policy.get 'member').to.be.equal member

  describe 'newStripeCard', ->
    it 'should return a new stripe card, bound to the member instance', ->
      @stubStripe()
      member = new Member
      card = member.newStripeCard()
      expect(card).to.be.an.instanceof StripeCard
      expect(card.get 'member').to.be.equal member
