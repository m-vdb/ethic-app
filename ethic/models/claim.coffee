ModelWithMember = require './modelWithMember.coffee'


class Claim extends ModelWithMember

  urlConfigKey: 'api.claims'
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
