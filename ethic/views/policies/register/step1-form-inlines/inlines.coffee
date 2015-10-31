require 'marionette'

# TODO: on enter -> do not submit form

class BaseInline extends Backbone.Marionette.ItemView

  className: 'js-step1-form-inline inline-block'
  ui:
    input: '.js-input'

  events:
    'change @ui.input': 'onChange'  # selects
    'keyup @ui.input': 'onChange'  # text input
    'oninput @ui.input': 'onChange'  # number input

  getAttrName: ->
    @ui.input.attr 'name'

  onChange: ->
    clearTimeout @_timer
    name = @getAttrName()
    val = @getInputValue()
    @_timer = setTimeout =>
      @beforeSet()
      if @model.set(name, val, validate: true)
        @triggerMethod 'inline:valid'
    , 500

  getInputValue: ->
    @ui.input.val()

  beforeSet: ->


class Inline0 extends BaseInline

  template: require './inline0.view.html'
  carMakes: require '../../../../data/car-makes.json'

  onRender: ->
    placeholder = [{id: "", name: "Select a car make"}]
    @ui.input.select2
      data: placeholder.concat @carMakes
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name

  beforeSet: ->
    @model.unset 'car_model'


class Inline1 extends BaseInline

  template: require './inline1.view.html'
  carModels: require '../../../../data/car-models.json'

  modelEvents:
    'invalid': 'onInvalid'
    'change:car_make': 'onCarMakeChange'

  onRender: ->
    placeholder = [{id: "", name: "Select a car model"}]
    @ui.input.prop "disabled", false
    @ui.input.select2
      data: placeholder.concat @carModels[@model.get 'car_make']
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name

  onInvalid: (model, invalidAttrs)->
    if invalidAttrs.car_make
      @ui.input.prop "disabled", true

  onCarMakeChange: ->
    @ui.input.select2 'destroy'
    @onRender()  # re-render the select2
    @onChange()  # trigger a change for validation


class Inline2 extends BaseInline

  template: require './inline2.view.html'

  serializeData: ->
    currentYear: new Date().getFullYear()


class InlineVIN extends BaseInline

  template: require './inline-vin.view.html'


class InlineInsuranceProvider extends BaseInline

  template: require './inline-insurance-provider.view.html'
  insuranceProfiders: require '../../../../data/insurance-providers.json'

  onRender: ->
    placeholder = [{id: "", name: "Select an insurance provider"}]
    @ui.input.select2
      data: placeholder.concat @insuranceProfiders
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name


class InlineDeductible extends BaseInline

  template: require './inline-deductible.view.html'


class InlinePremium extends BaseInline

  template: require './inline-premium.view.html'
  ui:
    periodSelect: 'select[name=premium_period]'

  events:
    'change @ui.periodSelect': 'onChange'

  onRender: ->
    @ui.periodSelect.select2
      data: ['monthly', 'yearly']

  getInputValue: ->
    val = super
    if @ui.periodSelect.val() == 'yearly'
      val = (val / 12).toFixed()
    val


module.exports = [
  InlineInsuranceProvider, InlineDeductible, InlinePremium
]
module.exports.BaseInline = BaseInline
