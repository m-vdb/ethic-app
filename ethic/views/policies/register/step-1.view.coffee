require 'marionette'
formInlines = require './step1-form-inlines/inlines.coffee'


class Step1RegisterPolicyView extends Backbone.Marionette.CompositeView

  template: require './step-1.view.html'
  ui:
    errorList: '.form-error-list'
    submitContainer: '.js-submit-container'
    submit: '.js-submit'

  events:
    'click @ui.submit': 'onSubmit'

  modelEvents:
    'change': 'clearErrors'

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
    Backbone.Validation.bind @, invalid: @onInvalid

  isFullyDisplayed: ->
    @children.length == formInlines.length

  onInlineValid: (view) ->
    isFullyDisplayed = @isFullyDisplayed()
    # we only do things if the view is the last one
    # user might change values of inputs in between
    if @children.findByIndex(@children.length - 1) is view and not isFullyDisplayed
      @addChild()

    # if all the views are displayed and the form is valid
    # we should show the submit button
    if isFullyDisplayed
      @ui.submitContainer.show()

  clearErrors: ->
    @ui.errorList.html ''

  onInvalid: (view, attr, error) ->
    $(".error-#{attr}", view.ui.errorList).remove()  # do not duplicate errors
    view.ui.errorList.append "<li class='error-#{attr}'>#{ error }</li>"
    if view.isFullyDisplayed()
      view.ui.submitContainer.hide()

  onSubmit: (e) ->
    e.preventDefault()
    @triggerMethod 'step:over'


module.exports = Step1RegisterPolicyView
