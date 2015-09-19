Form = require '../form.coffee'

class FileClaimView extends Form

  template: _.template(require './file.view.html')

  serializeData: ->
    data = super
    data.policies = @options.policiesCollection.pluck 'id'
    data

module.exports = FileClaimView
