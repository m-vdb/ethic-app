insuranceProviders = require '../data/insurance-providers.json'
VinValidator = require '../utils/vin-validator.coffee'
ModelWithMember = require './modelWithMember.coffee'
config = require '../config.coffee'

vinValidator = new VinValidator()


class Policy extends ModelWithMember

  urlConfigKey: 'api.policies'
  defaults:
    type: 'CarPolicy'

  validation:

    car_vin:
      required: true
      fn: (value, attr, computedState) ->
        vinValidator.validate value

    insurance_provider:
      required: true
      oneOf: _.pluck(insuranceProviders, "id")
      msg: 'Please enter a valid insurance provider.'

    initial_premium:
      required: true
      pattern: 'number'
      min: 1

    initial_deductible:
      required: true
      pattern: 'number'
      min: 1

  proofUrl: ->
    config.get 'api.policiesProof',
      id: @get('member').id
      policyId: @id


module.exports = Policy
