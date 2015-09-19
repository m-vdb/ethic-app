class Claim extends Backbone.Model

  validation:
    amount:
      required: true
      pattern: 'number'

    reason:
      required: true
      minLength: 100

module.exports = Claim
