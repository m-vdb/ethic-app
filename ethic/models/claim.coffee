class Claim extends Backbone.Model

  validation:
    amount:
      required: true
      pattern: 'number'

    reason:
      required: true
      minLength: 100

    policy_id:
      required: true
      pattern: "number"  # TODO: value should be verified with oneOf

module.exports = Claim
