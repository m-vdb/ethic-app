carMakes = require '../data/car-makes.json'
carModels = require '../data/car-models.json'


class Policy extends Backbone.Model

  validation:

    car_year:
      required: true
      range: [2000, new Date().getFullYear()]

    car_make:
      required: true
      oneOf: _.pluck(carMakes, "id")

    car_model:
      required: true
      fn: (value, attr, computedState) ->
        validCarModels = _.pluck carModels[computedState.car_make], 'id'
        Backbone.Validation.validators.oneOf value, attr, validCarModels, @

    initial_premium:
      required: true
      pattern: 'number'

    initial_deductible:
      required: true
      pattern: 'number'


module.exports = Policy
