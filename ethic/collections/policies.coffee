Policy = require '../models/policy.coffee'


class PolicyCollection extends Backbone.Collection

  model: Policy

  fetch: ->
    true

module.exports = PolicyCollection
