Policy = require '../models/policy.coffee'
CollectionWithMember = require './collectionWithMember.coffee'


class PolicyCollection extends CollectionWithMember

  model: Policy
  urlConfigKey: 'api.policies'


module.exports = PolicyCollection
