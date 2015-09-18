Claim = require '../models/claim.coffee'


class ClaimCollection extends Backbone.Collection

  model: Claim


module.exports = ClaimCollection
