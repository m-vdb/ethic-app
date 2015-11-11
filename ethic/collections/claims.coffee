Claim = require '../models/claim.coffee'
CollectionWithMember = require './collectionWithMember.coffee'


class ClaimCollection extends CollectionWithMember

  model: Claim
  urlConfigKey: 'api.claims'


module.exports = ClaimCollection
