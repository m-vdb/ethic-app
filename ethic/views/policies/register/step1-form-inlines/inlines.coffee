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

  onChange: ->
    clearTimeout @_timer
    name = @ui.input.attr 'name'
    val = @getInputValue()
    @_timer = setTimeout =>
      if @model.set(name, val, validate: true)
        @triggerMethod 'inline:valid'
    , 500

  getInputValue: ->
    @ui.input.val()


class Inline0 extends BaseInline

  template: require './inline0.view.html'
  carMakes: require '../../../../data/car-makes.json'

  onRender: ->
    placeholder = [{id: "", name: "Select a car make"}]
    @ui.input.select2
      data: placeholder.concat @carMakes
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name


class Inline1 extends BaseInline

  template: require './inline1.view.html'
  carModels: require '../../../../data/car-models.json'

  modelEvents:
    'change:car_make': 'onCarMakeChange'

  onRender: ->
    placeholder = [{id: "", name: "Select a car model"}]
    @ui.input.select2
      data: placeholder.concat @carModels[@model.get 'car_make']
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name

  onCarMakeChange: ->
    @ui.input.select2 'destroy'
    @onRender()
    # TODO: display error message "empty"


class Inline2 extends BaseInline

  template: require './inline2.view.html'

  serializeData: ->
    currentYear: new Date().getFullYear()


class Inline3 extends BaseInline

  # TODO: use https://libraries.io/bower/edmundssdk for validation
  template: require './inline3.view.html'


class Inline4 extends BaseInline

  template: require './inline4.view.html'
  insuranceProfiders: require '../../../../data/insurance-providers.json'

  onRender: ->
    placeholder = [{id: "", name: "Select an insurance provider"}]
    @ui.input.select2
      data: placeholder.concat @insuranceProfiders
      templateSelection: (item) -> item.name
      templateResult: (item) -> item.name


class Inline5 extends BaseInline

  template: require './inline5.view.html'


class Inline6 extends BaseInline

  template: require './inline6.view.html'
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
  Inline0, Inline1, Inline2, Inline3,
  Inline4, Inline5, Inline6
]
module.exports.BaseInline = BaseInline
