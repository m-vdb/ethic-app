config = require '../config.coffee'


class ModelWithMember extends Backbone.Model

  urlConfigKey: null

  constructor: (attributes, options) ->
    throw new Error("Missing member attribute.") unless attributes.member
    super attributes, options

  url: ->
    throw new Error("Missing urlConfigKey attribute.") unless @urlConfigKey
    config.get @urlConfigKey, id: @get('member').id

  toJSON: ->
    json = super
    delete json.member
    json


module.exports = ModelWithMember
