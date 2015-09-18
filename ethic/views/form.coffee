require 'marionette'


class Form extends Backbone.Marionette.ItemView

  formUi:
    submit: '.js-submit'
    formControls: '.form-control'

  formEvents:
    'click @ui.submit': 'onSubmit'
    'change @ui.formControls': 'resetInvalidState'

  modelEvents:
    'invalid': 'onInvalid'

  events: {}
  ui: {}

  constructor: ->
    _.extend @events, @formEvents
    _.extend @ui, @formUi
    super

  onSubmit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    data = {}
    _.each @ui.formControls, (el) =>
      $el = @$(el)
      data[$el.attr 'name'] = $el.val()

    @model.set data
    if @model.isValid()
      @collection.create @model

  onInvalid: (model, error) ->
    # TODO: mark form controls as invalid
    console.log error

  resetInvalidState: (e) ->
    # TODO: reset invalid state

module.exports = Form
