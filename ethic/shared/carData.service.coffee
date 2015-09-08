module.exports = (CONTRACT_ADDRESS) ->
  {
    getMakes: () ->
      require '../data/makes.json'
    getModels: (make) ->
      require('../data/models.json')[make]
  }
