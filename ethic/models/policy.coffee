carMakes = require '../data/car-makes.json'
carModels = require '../data/car-models.json'
insuranceProviders = require '../data/insurance-providers.json'
VinValidator = require '../utils/vin-validator.coffee'

vinValidator = new VinValidator()

class Policy extends Backbone.Model

  validation:

    car_year:
      required: true
      range: [2000, new Date().getFullYear()]

    car_make:
      required: true
      oneOf: _.pluck(carMakes, "id")
      msg: 'Please enter a valid car make.'

    car_model:
      required: true
      fn: (value, attr, computedState) ->
        validCarModels = _.pluck carModels[computedState.car_make], 'id'
        Backbone.Validation.validators.oneOf value, attr, validCarModels, @
      msg: 'Please enter a valid car model.'

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
