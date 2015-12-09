require 'marionette'
ProgressView = require './progress.view.coffee'

steps = [
  require './greetings.view.coffee'
  require './form.view.coffee'
  require './proof.view.coffee'
  require './payment.view.coffee'
  require './success.view.coffee'
]

class RegisterLayout extends Backbone.Marionette.LayoutView

  template: require './layout.html'

  regions:
    progress: ".register-policy-progress"
    content: ".register-policy-step-content"

  childEvents:
    'step:over': 'onStepOver'

  initialize: ->
    @currentStepIdx = if @collection.length == 0 then 0 else 1
    @FirstStepView = steps[@currentStepIdx]

  onShow: ->
    @progressView = new ProgressView
      model: @model
      start: @currentStepIdx
    @showChildView 'progress', @progressView
    @showChildView 'content', new @FirstStepView
      model: @model

  onStepOver: (view, saveModel) ->
    if saveModel
      @model.save null,
        success: _.bind @doNextStep, @
        error: ->
          # TODO
          console.log 'dayum'
    else
      @doNextStep()

  doNextStep: ->
    @currentStepIdx++
    if @currentStepIdx < steps.length
      StepView = steps[@currentStepIdx]
      @showChildView 'content', new StepView
        model: @model
      if @currentStepIdx == steps.length - 1
        @progressView.toggle true
      else
        @progressView.nextStep()


module.exports = RegisterLayout
