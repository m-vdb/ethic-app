insuranceProviders = require '../data/insurance-providers.json'
VinValidator = require '../utils/vin-validator.coffee'

vinValidator = new VinValidator()

class Policy extends Backbone.Model

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

    initial_deductible:
      required: true
      pattern: 'number'


module.exports = Policy
