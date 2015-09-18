Policy = require '../models/policy.coffee'


class PolicyCollection extends Backbone.Collection

  model: Policy


module.exports = PolicyCollection
