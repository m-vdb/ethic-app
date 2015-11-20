require 'marionette'


class RegisterPolicySuccessView extends Backbone.Marionette.ItemView

  template: _.template(require './success.view.html')
  ui:
    callCarrier: '.text-call-carrier'

  serializeData: ->
    {
      provider: @model.get 'insurance_provider'
      maxDeductible: @model.getMaxDeductible()
    }

  onShow: ->
    content = @model.get('insurance_provider') + ': ' + @model.getProviderPhone()
    @ui.callCarrier.popover
      title: 'Call your provider'
      content: content
      placement: 'top'
      trigger: 'hover'


module.exports = RegisterPolicySuccessView
