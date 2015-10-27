viewOptions = ['events', 'ui', 'triggers', 'modelEvents', 'collectionEvents']


class ExtendedView extends Backbone.View

  constructor: (options) ->
    parent = null
    obj = null

    _.each viewOptions, (prop) =>
      parent = @constructor.__super__
      obj = {}

      while parent
        if parent[prop]
          _.extend obj, parent[prop]

        parent = parent.constructor.__super__

      @[prop] = _.extend {}, obj, @constructor.prototype[prop]

    super


Backbone.View = ExtendedView
module.exports = ExtendedView
