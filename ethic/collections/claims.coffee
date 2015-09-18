Claim = require '../models/claim.coffee'


class ClaimCollection extends Backbone.Collection

  model: Claim

  fetch: ->
    true

module.exports = ClaimCollection
