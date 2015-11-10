config = require '../config.coffee'


class CollectionWithMember extends Bacckbone.Collection

  urlConfigKey: null

  constructor: (@member, models, options) ->
    super models, options

  url: ->
    throw new Error("Missing urlConfigKey attribute.") unless @urlConfigKey
    config.get @urlConfigKey, id: @member.id
