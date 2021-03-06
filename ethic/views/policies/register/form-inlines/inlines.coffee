require 'marionette'

# TODO: on enter -> do not submit form

class BaseInline extends Backbone.Marionette.ItemView

  className: 'js-step1-form-inline inline-block'
  ui:
    input: '.js-input'

  getAttrName: ->
    @ui.input.attr 'name'

  onChange: ->
    clearTimeout @_timer
    name = @getAttrName()
    val = @getInputValue()
    @_timer = setTimeout =>
      if @model.set(name, val, validate: true)
        @triggerMethod 'inline:valid'
    , 500

  getInputValue: ->
    @ui.input.val()


class InlineVIN extends BaseInline

  template: require './inline-vin.view.html'
  events:
    'keyup @ui.input': 'onChange'


class InlineInsuranceProvider extends BaseInline

  template: require './inline-insurance-provider.view.html'
  insuranceProfiders: require '../../../../data/insurance-providers.json'
  events:
    'change @ui.input': 'onChange'

  onRender: ->
    placeholder = [{id: "", name: "Select an insurance provider"}]
    @ui.input.select2
      data: placeholder.concat @insuranceProfiders
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name


class InlineDeductible extends BaseInline

  template: require './inline-deductible.view.html'
  events:
    'oninput @ui.input': 'onChange'
    'keyup @ui.input': 'onChange'


class InlinePremium extends BaseInline

  template: require './inline-premium.view.html'
  ui:
    periodSelect: 'select[name=premium_period]'

  events:
    'change @ui.periodSelect': 'onChange'
    'oninput @ui.input': 'onChange'
    'keyup @ui.input': 'onChange'

  onRender: ->
    @ui.periodSelect.select2
      data: ['monthly', 'yearly']

  getInputValue: ->
    val = super
    if val and @ui.periodSelect.val() == 'yearly'
      val = (val / 12).toFixed()
    val


module.exports = [
  InlineVIN, InlineInsuranceProvider,
  InlineDeductible, InlinePremium
]
module.exports.BaseInline = BaseInline
