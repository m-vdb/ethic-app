require 'marionette'


class Form extends Backbone.Marionette.ItemView

  formUi:
    submit: '.js-submit'
    formControls: '.form-control'

  formEvents:
    'click @ui.submit': 'onSubmit'

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

    @model.set data, validate: true
    if @model.isValid()
      @collection.create @model

  onRender: ->
    Backbone.Validation.bind @,
      valid: (view, attr) ->
        formGroup = view.$('[name="'+attr+'"]').parents('.form-group')
        formGroup.removeClass 'has-error'
        formGroup.addClass 'has-success'
        formGroup.children('.form-error-msg').html ''

      invalid: (view, attr, error) ->
        formGroup = view.$('[name="'+attr+'"]').parents('.form-group')
        formGroup.removeClass 'has-success'
        formGroup.addClass 'has-error'
        formGroup.children('.form-error-msg').html error


module.exports = Form
