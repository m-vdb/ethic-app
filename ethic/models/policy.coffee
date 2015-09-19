carMakes = require '../data/car-makes.json'
carModels = require '../data/car-models.json'


class Policy extends Backbone.Model

  validation:

    car_year:
      required: true
      range: [1950, new Date().getFullYear()]

    car_make:
      required: true
      oneOf: _.pluck(carMakes, "make_id")

    car_model:
      required: true
      fn: (value, attr, computedState) ->
        validCarModels = carModels[computedState.car_make] or []
        Backbone.Validation.validators.oneOf value, attr, validCarModels, @

    initial_premium:
      required: true
      pattern: 'number'

    initial_deductible:
      required: true
      pattern: 'number'


module.exports = Policy
