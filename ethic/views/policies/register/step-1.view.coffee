require 'marionette'
formInlines = require './step1-form-inlines/inlines.coffee'


class Step1RegisterPolicyView extends Backbone.Marionette.CompositeView

  template: require './step-1.view.html'
  ui:
    errorContainer: '.form-error-container'
    submitContainer: '.js-submit-container'
    submit: '.js-submit'

  events:
    'click @ui.submit': 'onSubmit'

  childViewContainer: '.form-step-container'
  childView: formInlines.BaseInline
  childEvents:
    'inline:valid': 'onInlineValid'
    'inline:invalid': 'onInlineInValid'

  constructor: (options)->
    window.step1 = @
    super

  addChild: ->
    index = @children.length
    # we don't have the index in `getChildView` method
    ChildView = formInlines[index]
    # child is meaningless here, we use @model
    super @model, ChildView, index

  onShow: ->
    @addChild()

  onInlineValid: (view) ->
    # TODO clear error
    # we only do things if the view is the last one
    # user might change values of inputs in between
    if @children.findByIndex(@children.length - 1) is view
      if @children.length < formInlines.length
        @addChild()
      else
        @ui.submitContainer.show()

  onInlineInValid: (error) ->
    # TODO add error
    true

  onSubmit: (e) ->
    e.preventDefault()
    @triggerMethod 'step:over'


module.exports = Step1RegisterPolicyView
