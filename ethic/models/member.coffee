Policy = require './policy.coffee'
StripeCard = require './stripeCard.coffee'


class Member extends Backbone.Model

  validation:

    email:
      pattern: 'email'
      required: true
      msg: 'Please enter a valid email'

    password:
      required: true
      msg: 'Password is required'

  newPolicy: ->
    new Policy
      member: @

  newStripeCard: ->
    new StripeCard
      member: @


module.exports = Member
